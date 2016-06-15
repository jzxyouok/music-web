package com.johnf.app.music.dao.impl;

import java.util.HashMap;
import java.util.Map;

import com.johnf.app.music.dao.AccessoryDao;
import com.johnf.app.music.po.AccessoryPo;

public class AccessoryDaoImpl extends BaseDaoImpl implements AccessoryDao {

	@Override
	public void insert(AccessoryPo po) {
		addObject("Accessory.add", po);
	}

	@Override
	public void delete(String projectId, String type) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("projectId", projectId);
		paramMap.put("type", type);
		deleteForMap("Accessory.delete", paramMap);
	}

}
