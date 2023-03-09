package com.lgu.ccss.common.interceptor;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.util.Properties;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.MethodUtils;
import org.apache.commons.lang.WordUtils;
import org.apache.ibatis.cache.CacheKey;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import lguplus.security.vulner.SecurityModule;
import lguplus.security.vulner.SetPolicyFile;

@Intercepts({
	@Signature(type = Executor.class, method = "update", args = {MappedStatement.class, Object.class}),
	@Signature(type = Executor.class, method = "query", args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class, CacheKey.class, BoundSql.class}),
//	@Signature(type = Executor.class, method = "query", args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class}),
//	@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class})
})
public class MyBatisInterceptor implements Interceptor{

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public Object intercept(Invocation invocation) throws Throwable {

		Object[]        args     = invocation.getArgs();
		MappedStatement ms       = (MappedStatement)args[0];
		Object          param    = (Object)args[1];
//		BoundSql        boundSql = ms.getBoundSql(param);

		Object resultObject = checkParamValue(param);
		invocation.getArgs()[1] = resultObject;
		
		Object o = invocation.proceed();
		return o;
	}

	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties arg0) {
		// TODO Auto-generated method stub
		
	}
	
	public Object checkParamValue(Object obj) throws IOException, InvocationTargetException, IllegalAccessException {
		
		
		Field[] fields = obj.getClass().getDeclaredFields();
		
		for(Field field : fields){
			String fieldName = field.getName();
			if("serialVersionUID".equals(fieldName))
				continue;
			Object o = invokeMethod(obj, "get"+ WordUtils.capitalize(fieldName));
			
			if(o != null) {
				String fType = field.getType().getSimpleName();
				if(fType.equals("String")) {
					if(org.apache.commons.lang3.StringUtils.isNotEmpty((String) o)) {
						
						//SetPolicyFile.setDocument(this.getClass().getClassLoader().getResource("").getPath() + File.separator + "VulnerCheckList.xml");
						String result = SecurityModule.VulnerabilityChek((String) o, 0, "common", "sqlinjection");
						if("true".equals(result)) {
							String resultString = SecurityModule.VulnerabilityChek((String) o, 1, "common", "sqlinjection");
							logger.info("Sql Injection 발생");
							logger.info("Sql Injection Value = " + (String) o);
							logger.info("Slq Injection Replace Value = " + resultString);
							BeanUtils.setProperty(obj, fieldName, resultString);
						}
					}
				}
			}
		}
		return obj;
	}
	
	private Object invokeMethod(Object obj, String methodName)  {
		Object o = null;
		try {
			o = MethodUtils.invokeMethod(obj, methodName, new Object[0]);
		} catch (NoSuchMethodException e) {
			logger.error(e.getMessage(), e);
//			throw new BizExceptionProperties (ErrorCodeEnum.NOT_METHOD.getCode(), new String[]{methodName +" param valid check error"});
		} catch (IllegalAccessException e) {
			logger.error(e.getMessage(), e);
//			throw new BizExceptionProperties(ErrorCodeEnum.NOT_PARAMETER.getCode(), new String[]{methodName +" param valid check error"});
		} catch (InvocationTargetException e) {
			logger.error(e.getMessage(), e);
//			throw new BizExceptionProperties(ErrorCodeEnum.NOT_PARAMETER.getCode(), new String[]{methodName +" param valid check error"});
		}
		return o;
	}
}
