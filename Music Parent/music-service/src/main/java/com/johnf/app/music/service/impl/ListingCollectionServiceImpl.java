package com.johnf.app.music.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.dao.ListingCollectionDao;
import com.johnf.app.music.po.ListingCollectionPo;
import com.johnf.app.music.service.ListingCollectionService;
import com.johnf.app.music.vo.ListingCollectionVo;

public class ListingCollectionServiceImpl implements ListingCollectionService {
	private ListingCollectionDao listingCollectionDao;
	
	@Override
	public void insert(ListingCollectionVo vo) {
		ListingCollectionPo po = new ListingCollectionPo();
		BeanUtils.copyProperties(vo, po);
		listingCollectionDao.insert(po);
	}

	@Override
	public void delete(String listingId, String userId) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("listingId", listingId);
		paramMap.put("userId", userId);
		listingCollectionDao.delete(paramMap);
	}
	
	public void setListingCollectionDao(ListingCollectionDao listingCollectionDao) {
		this.listingCollectionDao = listingCollectionDao;
	}
	
}
