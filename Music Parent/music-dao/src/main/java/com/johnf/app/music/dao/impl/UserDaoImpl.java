package com.johnf.app.music.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.johnf.app.music.dao.UserDao;
import com.johnf.app.music.po.UserPo;

@SuppressWarnings("unchecked")
public class UserDaoImpl extends BaseDaoImpl implements UserDao {

	@Override
	public void insert(UserPo po) {
		addObject("User.add", po);
	}

	@Override
	public UserPo find(String id) {
		return (UserPo) findObject("User.find", id);
	}
	
	@Override
	public UserPo findByParams(Map<String, Object> paramMap) {
		return (UserPo) findObject("User.findByAccountAndPassword", paramMap);
	}

	@Override
	public void update(UserPo po) {
		updateObject("User.update", po);
	}

	@Override
	public long count(String filter) {
		return getObjectCount("User.count", filter);
	}
	
	@Override
	public List<UserPo> listByPage(String filter, int skipResults, int pageSize) {
		return listByPage("User.list", filter, skipResults, pageSize);
	}

	@Override
	public List<UserPo> list(String filter) {
		return list("User.list", filter);
	}

	@Override
	public void updateState(String id, String state) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("id", id);
		paramMap.put("isValid", state);
		updateObjectState("User.updateState", paramMap);
	}

}
