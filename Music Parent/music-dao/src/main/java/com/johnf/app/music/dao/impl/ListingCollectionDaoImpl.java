package com.johnf.app.music.dao.impl;

import java.util.Map;

import com.johnf.app.music.dao.ListingCollectionDao;
import com.johnf.app.music.po.ListingCollectionPo;

public class ListingCollectionDaoImpl extends BaseDaoImpl implements ListingCollectionDao {

	@Override
	public void insert(ListingCollectionPo po) {
		addObject("ListingCollection.add", po);
	}

	@Override
	public void delete(Map<String,Object> paramMap) {
		deleteForMap("ListingCollection.delete", paramMap);
	}

}
