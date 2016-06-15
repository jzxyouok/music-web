package com.johnf.app.music.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

@SuppressWarnings("rawtypes")
public interface BaseDao {
	
	void addObject(String statementName, Object obj) throws DataAccessException;
	
	int deleteObject(String statementName,String objId) throws DataAccessException;
	
	int deleteForMap(String statementName,Map<String, Object> map) throws DataAccessException;
	
	Object findObject(String statementName,String objId) throws DataAccessException;
	
	int updateObject(String statementName,Object obj) throws DataAccessException;
	
	int updateObjectState(String statementName,Map<String, Object> map) throws DataAccessException;
	
	int getObjectCount(String statementName, String filter);
	
	int getObjectCount(String statementName, Map<String, Object> map);
	
	Object findObject(String statementName, Map<String, Object> map);
	
	List listByPage(String statementName, Map<String, Object> map, int skipResults, int pageSize);
	
	List listByPage(String statementName, String filter, int skipResults, int pageSize);
	
	List list(String statementName, String filter);
	
	List list(String statementName, Map<String, Object> map);
	
}
