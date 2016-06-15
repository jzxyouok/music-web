package com.johnf.app.music.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.dao.RemarkDao;
import com.johnf.app.music.po.RemarkPo;
import com.johnf.app.music.service.RemarkService;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.RemarkVo;

@SuppressWarnings("rawtypes")
public class RemarkServiceImpl implements RemarkService {
	private RemarkDao remarkDao;
	
	@Override
	public void insert(RemarkVo vo) {
		RemarkPo po = new RemarkPo();
		BeanUtils.copyProperties(vo, po);
		remarkDao.insert(po);
	}

	@Override
	public RemarkVo find(String id) {
		RemarkPo po = remarkDao.find(id);
		RemarkVo vo = new RemarkVo();
		BeanUtils.copyProperties(po, vo);
		return vo;
	}

	@Override
	public long count(RemarkVo vo) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getStatus())) {
			paramMap.put("status", vo.getStatus());
		}
		if(!StringTools.isEmptyOrNull(vo.getType())) {
			paramMap.put("rtype", vo.getType());
		}		
		if(!StringTools.isEmptyOrNull(vo.getProjectId())) {
			paramMap.put("projectId", vo.getProjectId());
		}
		return remarkDao.count(paramMap);
	}

	@Override
	public List listByPage(RemarkVo vo, int pageNo, int pageSize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getStatus())) {
			paramMap.put("status", vo.getStatus());
		}
		if(!StringTools.isEmptyOrNull(vo.getType())) {
			paramMap.put("rtype", vo.getType());
		}
		if(!StringTools.isEmptyOrNull(vo.getProjectId())) {
			paramMap.put("projectId", vo.getProjectId());
		}
		return remarkDao.listByPage(paramMap, (pageNo-1)*pageSize, pageSize);
	}

	@Override
	public void update(RemarkVo vo) {
		RemarkPo po = new RemarkPo();
		BeanUtils.copyProperties(vo, po);
		remarkDao.update(po);
	}

	@Override
	public void updateState(String id, String state) {
		remarkDao.updateState(id, state);
	}

	public void setRemarkDao(RemarkDao remarkDao) {
		this.remarkDao = remarkDao;
	}
	
}
