package com.johnf.app.music.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.johnf.app.music.dao.SingerDao;
import com.johnf.app.music.po.SingerPo;

@SuppressWarnings("rawtypes")
public class SingerDaoImpl extends BaseDaoImpl implements SingerDao {

	@Override
	public void insert(SingerPo po) {
		addObject("Singer.add", po);
	}

	@Override
	public SingerPo find(String id) {
		return (SingerPo) findObject("Singer.find", id);
	}

	@Override
	public long count(Map<String, Object> paramMap) {
		return getObjectCount("Singer.count", paramMap);
	}

	@Override
	public List listByPage(Map<String, Object> paramMap, int skipResults, int pageSize) {
		return listByPage("Singer.list", paramMap, skipResults, pageSize);
	}

	@Override
	public List list(String filter) {
		return list("Singer.list", filter);
	}

	@Override
	public void update(SingerPo po) {
		updateObject("Singer.update", po);
	}

	@Override
	public void updateState(String id, String state) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("isValid", state);
		updateObjectState("Singer.updateState", paramMap);
	}

}
