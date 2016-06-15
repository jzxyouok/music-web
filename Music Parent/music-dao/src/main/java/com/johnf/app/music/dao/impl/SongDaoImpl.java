package com.johnf.app.music.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.johnf.app.music.dao.SongDao;
import com.johnf.app.music.po.SongPo;

@SuppressWarnings("rawtypes")
public class SongDaoImpl extends BaseDaoImpl implements SongDao {

	@Override
	public void insert(SongPo po) {
		addObject("Song.add", po);
	}

	@Override
	public SongPo find(String id) {
		return (SongPo) findObject("Song.find", id);
	}

	@Override
	public long count(Map<String, Object> paramMap) {
		return getObjectCount("Song.count", paramMap);
	}
	
	@Override
	public long count(String filter) {
		return getObjectCount("Song.count", filter);
	}

	@Override
	public List listByPage(Map<String, Object> paramMap, int skipResults, int pageSize) {
		return listByPage("Song.list", paramMap, skipResults, pageSize);
	}

	@Override
	public List list(String filter) {
		return list("Song.listByFilter", filter);
	}

	@Override
	public void update(SongPo po) {
		updateObject("Song.update", po);
	}

	@Override
	public void updateState(String id, String state) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("isValid", state);
		updateObjectState("Song.updateState", paramMap);
	}

}