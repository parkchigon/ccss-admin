package com.lgu.ccss.admin.term.service;

import java.util.Map;

import com.lgu.ccss.admin.term.domain.TermsVO;

public interface TermsService {
    
	public Map<String, Object> selectTermsList(TermsVO termsVO) throws Exception ;

	public Map<String, Object> insertNewTerms(TermsVO termsVO) throws Exception;

	public TermsVO selectTermsDetail(TermsVO termsVO) throws Exception ;

	public Map<String, Object> updateTerms(TermsVO termsVO) throws Exception;
	
	public Map<String, Object> deleteTermsAjax(TermsVO termsVO)  throws Exception;
	
}
