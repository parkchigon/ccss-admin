package com.lgu.ccss.common.domain;

import java.util.Map;

public interface Tree {

	String getId();
	void setId(String id);
	
	String getParent();
	void setParent(String parentId);
	
	String getText();
	void setText(String text);
	
	Map<String, Boolean> getState();
}
