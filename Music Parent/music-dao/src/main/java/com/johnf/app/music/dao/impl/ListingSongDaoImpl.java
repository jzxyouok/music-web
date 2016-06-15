package com.johnf.app.music.dao.impl;

import java.util.HashMap;
import java.util.Map;

import com.johnf.app.music.dao.ListingSongDao;
import com.johnf.app.music.po.ListingSongPo;

public class ListingSongDaoImpl extends BaseDaoImpl implements ListingSongDao {

	@Override
	public void insert(ListingSongPo po) {
		addObject("ListingSong.add", po);
	}

	@Override
	public void delete(String listingId, String songId) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("listingId", listingId);
		paramMap.put("songId", songId);
		deleteForMap("ListingSong.delete", paramMap);
	}

}
