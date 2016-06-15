package com.johnf.app.music.service.impl;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.dao.ListingSongDao;
import com.johnf.app.music.po.ListingSongPo;
import com.johnf.app.music.service.ListingSongService;
import com.johnf.app.music.vo.ListingSongVo;

public class ListingSongServiceImpl implements ListingSongService {
	private ListingSongDao listingSongDao;
	
	@Override
	public void insert(ListingSongVo vo) {
		ListingSongPo po = new ListingSongPo();
		BeanUtils.copyProperties(vo, po);
		listingSongDao.insert(po);
	}

	@Override
	public void delete(String listingId, String songId) {
		listingSongDao.delete(listingId, songId);
	}
	
	public void setListingSongDao(ListingSongDao listingSongDao) {
		this.listingSongDao = listingSongDao;
	}
	
}
