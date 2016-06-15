package com.johnf.app.music.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.dao.SysDicDao;
import com.johnf.app.music.po.SysDicPo;
import com.johnf.app.music.service.SysDicService;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.SysDicVo;

@SuppressWarnings("rawtypes")
public class SysDicServiceImpl implements SysDicService {
	private SysDicDao sysDicDao;
	
	@Override
	public void insert(SysDicVo vo) {
		SysDicPo po = new SysDicPo();
		BeanUtils.copyProperties(vo, po);
		sysDicDao.insert(po);
	}

	@Override
	public long count(SysDicVo vo) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getType())) {
			paramMap.put("type", vo.getType());
		}
		return sysDicDao.count(paramMap);
	}

	@Override
	public List listByPage(SysDicVo vo, int pageNo, int pageSize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getType())) {
			paramMap.put("type", vo.getType());
		}
		return sysDicDao.listByPage(paramMap, (pageNo-1)*pageSize, pageSize);
	}

	@Override
	public List list(SysDicVo vo) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getType())) {
			paramMap.put("type", vo.getType());
		}
		return sysDicDao.list(paramMap);
	}
	
	@Override
	public List<SysDicVo> list(String type, String filter) {	
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(type)) {
			paramMap.put("type", type);
		}
		if(!StringTools.isEmptyOrNull(filter)) {
			paramMap.put("filter", filter);
		}
		List<SysDicPo> dicPoList = sysDicDao.list(paramMap);
		List<SysDicVo> dicVoList = new ArrayList<SysDicVo>();
		SysDicVo tmpVo;
		for(SysDicPo po : dicPoList) {
			tmpVo = new SysDicVo();
			BeanUtils.copyProperties(po, tmpVo);
			dicVoList.add(tmpVo);
		}
		return dicVoList;
	}
	
	@Override
	public void update(SysDicVo vo) {
		SysDicPo po = new SysDicPo();
		BeanUtils.copyProperties(vo, po);
		sysDicDao.update(po);
	}
	
	@Override
	public SysDicVo find(String id) {
		SysDicPo po = sysDicDao.find(id);
		SysDicVo vo = new SysDicVo();
		BeanUtils.copyProperties(po, vo);
		return vo;
	}
	
	@Override
	public void delete(String id) {
		sysDicDao.delete(id);
	}

	public void setSysDicDao(SysDicDao singerDao) {
		this.sysDicDao = singerDao;
	}

}
