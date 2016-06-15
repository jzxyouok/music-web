package com.johnf.app.music.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.johnf.app.music.dao.RemarkDao;
import com.johnf.app.music.po.RemarkPo;

@SuppressWarnings("rawtypes")
public class RemarkDaoImpl extends BaseDaoImpl implements RemarkDao {

	@Override
	public void insert(RemarkPo po) {
		addObject("Remark.add", po);
	}

	@Override
	public RemarkPo find(String id) {
		return (RemarkPo) findObject("Remark.find", id);
	}

	@Override
	public void update(RemarkPo po) {
		updateObject("Remark.update", po);
	}

	@Override
	public long count(Map<String,Object> paramMap) {
		return getObjectCount("Remark.count", paramMap);
	}
	
	@Override
	public List listByPage(Map<String,Object> paramMap, int skipResults, int pageSize) {
		return listByPage("Remark.list", paramMap, skipResults, pageSize);
	}

	@Override
	public void updateState(String id, String state) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("id", id);
		paramMap.put("isValid", state);
		updateObjectState("Remark.updateState", paramMap);
	}

}
