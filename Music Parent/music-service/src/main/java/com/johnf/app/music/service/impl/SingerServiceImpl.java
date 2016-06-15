package com.johnf.app.music.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.dao.SingerDao;
import com.johnf.app.music.po.SingerPo;
import com.johnf.app.music.service.SingerService;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.SingerVo;

@SuppressWarnings("rawtypes")
public class SingerServiceImpl implements SingerService {
	private SingerDao singerDao;
	
	@Override
	public void insert(SingerVo vo) {
		SingerPo po = new SingerPo();
		BeanUtils.copyProperties(vo, po);
		singerDao.insert(po);
	}

	@Override
	public SingerVo find(String id) {
		SingerPo po = singerDao.find(id);
		SingerVo vo = new SingerVo();
		BeanUtils.copyProperties(po, vo);
		return vo;
	}

	@Override
	public long count(SingerVo vo) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getName())) {
			paramMap.put("name", "%"+vo.getName()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getKey())) {
			paramMap.put("name", "%"+vo.getKey()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getIsValid())) {
			paramMap.put("isValid", vo.getIsValid());
		}
		if(!StringTools.isEmptyOrNull(vo.getCategory())) {
			paramMap.put("category", vo.getCategory());
		}
		if(!StringTools.isEmptyOrNull(vo.getAbbr())) {
			paramMap.put("abbr", vo.getAbbr());
		}
		return singerDao.count(paramMap);
	}

	@Override
	public List listByPage(SingerVo vo, int pageNo, int pageSize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getName())) {
			paramMap.put("name", "%"+vo.getName()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getKey())) {
			paramMap.put("name", "%"+vo.getKey()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getIsValid())) {
			paramMap.put("isValid", vo.getIsValid());
		}
		if(!StringTools.isEmptyOrNull(vo.getCategory())) {
			paramMap.put("category", vo.getCategory());
		}
		if(!StringTools.isEmptyOrNull(vo.getAbbr())) {
			paramMap.put("abbr", vo.getAbbr());
		}
		return singerDao.listByPage(paramMap, (pageNo-1)*pageSize, pageSize);
	}
	
	@Override
	public List listByPage(String filter, int pageNo, int pageSize) {
		return singerDao.listByPage("Singer.listByFilter", filter, (pageNo-1)*pageSize, pageSize);
	}

	@Override
	public void update(SingerVo vo) {
		SingerPo po = new SingerPo();
		BeanUtils.copyProperties(vo, po);
		singerDao.update(po);
	}

	@Override
	public void updateState(String id, String state) {
		singerDao.updateState(id, state);
	}

	public void setSingerDao(SingerDao singerDao) {
		this.singerDao = singerDao;
	}
	
}
