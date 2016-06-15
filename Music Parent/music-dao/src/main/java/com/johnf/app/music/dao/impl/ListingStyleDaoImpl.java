package com.johnf.app.music.dao.impl;

import com.johnf.app.music.dao.ListingStyleDao;
import com.johnf.app.music.po.ListingStylePo;

public class ListingStyleDaoImpl extends BaseDaoImpl implements ListingStyleDao {

	@Override
	public void insert(ListingStylePo po) {
		addObject("ListingStyle.add", po);
	}

	@Override
	public void delete(String listingId) {
		deleteObject("ListingStyle.delete", listingId);
	}

}
