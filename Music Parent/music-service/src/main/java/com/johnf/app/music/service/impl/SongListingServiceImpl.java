package com.johnf.app.music.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.dao.ListingLanguageDao;
import com.johnf.app.music.dao.ListingStyleDao;
import com.johnf.app.music.dao.SongListingDao;
import com.johnf.app.music.po.ListingLanguagePo;
import com.johnf.app.music.po.ListingStylePo;
import com.johnf.app.music.po.SongListingPo;
import com.johnf.app.music.service.SongListingService;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.SongListingVo;

public class SongListingServiceImpl implements SongListingService {
	private SongListingDao songListingDao;
	private ListingStyleDao listingStyleDao;
	private ListingLanguageDao listingLanguageDao;
	
	@Override
	public void insert(SongListingVo vo) {
		SongListingPo po = new SongListingPo();
		BeanUtils.copyProperties(vo, po);
		songListingDao.insert(po);
	}

	@Override
	public SongListingVo find(String id) {
		SongListingPo po = songListingDao.find(id);
		SongListingVo vo = new SongListingVo();
		BeanUtils.copyProperties(po, vo);
		return vo;
	}

	@Override
	public long count(SongListingVo vo) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getName())) {
			paramMap.put("name", "%"+vo.getName()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getKey())) {
			paramMap.put("name", "%"+vo.getKey()+"%");
		}
		return songListingDao.count(paramMap);
	}

	@Override
	public List<SongListingVo> listByPage(SongListingVo vo, int pageNo, int pageSize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getName())) {
			paramMap.put("name", "%"+vo.getName()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getKey())) {
			paramMap.put("name", "%"+vo.getKey()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getOrderBy())) {
			paramMap.put("orderby", vo.getOrderBy());
		}
		List<SongListingPo> poList = 
				songListingDao.listByPage(paramMap, (pageNo-1)*pageSize, pageSize);
		List<SongListingVo> voList = new ArrayList<SongListingVo>();
		SongListingVo tmpVo;
		for(SongListingPo tmpPo : poList) {
			tmpVo = new SongListingVo();
			BeanUtils.copyProperties(tmpPo, tmpVo);
			voList.add(tmpVo);
		}
		return voList;
	}

	@Override
	public List<SongListingVo> list(String filter) {
		List<SongListingPo> poList = songListingDao.list(filter);
		List<SongListingVo> voList = new ArrayList<SongListingVo>();
		SongListingVo tmpVo;
		for(SongListingPo tmpPo : poList) {
			tmpVo = new SongListingVo();
			BeanUtils.copyProperties(tmpPo, tmpVo);
			voList.add(tmpVo);
		}
		return voList;
	}

	@Override
	public void update(SongListingVo vo) {
		SongListingPo po = new SongListingPo();
		BeanUtils.copyProperties(vo, po);
		songListingDao.update(po);
		
		//删除之前的歌单-风格关联信息
		listingStyleDao.delete(vo.getId());
		//删除之前的歌单-语言关联信息
		listingLanguageDao.delete(vo.getId());
		
		//保存新的歌单-风格关联信息
		if(!StringTools.isEmptyOrNull(vo.getStyle())) {
			String[] styleArr = vo.getStyle().split(",");
			//循环保存歌单-风格关联信息
			ListingStylePo tmpPo;
			for(int i=0; i<styleArr.length; i++) {
				tmpPo = new ListingStylePo();
				tmpPo.setId(UUID.randomUUID().toString());
				tmpPo.setListingId(vo.getId());
				tmpPo.setStyle(styleArr[i]);
				listingStyleDao.insert(tmpPo);
			}
		}
		
		//保存新的歌单-语言关联信息
		if(!StringTools.isEmptyOrNull(vo.getStyle())) {
			String[] languageArr = vo.getLanguage().split(",");
			//循环保存歌单-语言关联信息
			ListingLanguagePo tmpPo;
			for(int i=0; i<languageArr.length; i++) {
				tmpPo = new ListingLanguagePo();
				tmpPo.setId(UUID.randomUUID().toString());
				tmpPo.setListingId(vo.getId());
				tmpPo.setLanguage(languageArr[i]);
				listingLanguageDao.insert(tmpPo);
			}
		}
	}

	@Override
	public void updateState(String id, String state) {
		songListingDao.updateState(id, state);
	}

	public void setSongListingDao(SongListingDao songListingDao) {
		this.songListingDao = songListingDao;
	}

	public void setListingStyleDao(ListingStyleDao listingStyleDao) {
		this.listingStyleDao = listingStyleDao;
	}

	public void setListingLanguageDao(ListingLanguageDao listingLanguageDao) {
		this.listingLanguageDao = listingLanguageDao;
	}
	
}
