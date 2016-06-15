package com.johnf.app.music.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.johnf.app.music.dao.AlbumDao;
import com.johnf.app.music.po.AlbumPo;

@SuppressWarnings("rawtypes")
public class AlbumDaoImpl extends BaseDaoImpl implements AlbumDao {

	@Override
	public void insert(AlbumPo po) {
		addObject("Album.add", po);
	}

	@Override
	public AlbumPo find(String id) {
		return (AlbumPo) findObject("Album.find", id);
	}

	@Override
	public long count(String filter) {
		return getObjectCount("Album.count", filter);
	}

	@Override
	public List listByPage(Map<String,Object> paramMap, int skipResults, int pageSize) {
		return listByPage("Album.list", paramMap, skipResults, pageSize);
	}

	@Override
	public List list(String filter) {
		return list("Album.listByFilter", filter);
	}

	@Override
	public void update(AlbumPo po) {
		updateObject("Album.update", po);
	}

	@Override
	public void updateState(String id, String state) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("id", id);
		paramMap.put("isValid", state);
		updateObjectState("Album.updateState", paramMap);
	}

}
