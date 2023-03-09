package com.lgu.ccss.common.service;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import com.lgu.ccss.admin.system.menu.service.MenuServiceImpl;
import com.lgu.ccss.common.utility.DateUtil;


@Configuration
public class MenuServiceInit {

	
	@Autowired
	private MenuServiceImpl menuService;
	
	@PostConstruct
	public void init() {
		
		try {

			menuService.menuMapSetting();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("[" + DateUtil.getDate( "yyyy-MM-dd HH:mm:ss:SSS" ) + "] An error has occurred while initializing common component.");
			close();
		}
	}
	
	@PreDestroy
	public void close() {
		//자원 반환등 종료
	}
}
