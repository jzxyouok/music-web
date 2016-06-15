package com.johnf.app.music.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.johnf.app.music.dao.SongListingDao;
import com.johnf.app.music.po.SongListingPo;

@SuppressWarnings("unchecked")
public class SongListingDaoImpl extends BaseDaoImpl implements SongListingDao {

	@Override
	public void insert(SongListingPo po) {
		addObject("SongListing.add", po);
	}

	@Override
	public SongListingPo find(String id) {
		return (SongListingPo) findObject("SongListing.find", id);
	}

	@Override
	public long count(Map<String,Object> paramMap) {
		return getObjectCount("SongListing.count", paramMap);
	}

	@Override
	public List<SongListingPo> listByPage(Map<String,Object> paramMap, int skipResults, int pageSize) {
		return listByPage("SongListing.list", paramMap, skipResults, pageSize);
	}

	@Override
	public List<SongListingPo> list(String filter) {
		return list("SongListing.listByFilter", filter);
	}

	@Override
	public void update(SongListingPo po) {
		updateObject("SongListing.update", po);
	}

	@Override
	public void updateState(String id, String state) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("id", id);
		paramMap.put("isValid", state);
		updateObjectState("SongListing.updateState", paramMap);
	}

}
