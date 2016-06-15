package com.johnf.app.music.dao.impl;

import com.johnf.app.music.dao.ListingLanguageDao;
import com.johnf.app.music.po.ListingLanguagePo;

public class ListingLanguageDaoImpl extends BaseDaoImpl implements ListingLanguageDao {

	@Override
	public void insert(ListingLanguagePo po) {
		addObject("ListingLanguage.add", po);
	}

	@Override
	public void delete(String listingId) {
		deleteObject("ListingLanguage.delete", listingId);
	}

}
