package com.johnf.app.music.dao.impl;

import java.util.List;
import java.util.Map;

import com.johnf.app.music.dao.SysDicDao;
import com.johnf.app.music.po.SysDicPo;

@SuppressWarnings(value={"rawtypes","unchecked"})
public class SysDicDaoImpl extends BaseDaoImpl implements SysDicDao {

	@Override
	public void insert(SysDicPo po) {
		addObject("SysDic.add", po);
	}

	@Override
	public SysDicPo find(String id) {
		return (SysDicPo) findObject("SysDic.find", id);
	}

	@Override
	public long count(Map<String,Object> paramMap) {
		return getObjectCount("SysDic.count", paramMap);
	}

	@Override
	public List listByPage(Map<String,Object> paramMap, int skipResults, int pageSize) {
		return listByPage("SysDic.list", paramMap, skipResults, pageSize);
	}

	@Override
	public List<SysDicPo> list(Map<String,Object> paramMap) {
		return list("SysDic.list", paramMap);
	}

	@Override
	public void update(SysDicPo po) {
		updateObject("SysDic.update", po);
	}

	@Override
	public void delete(String id) {
		deleteObject("SysDic.deleteById", id);
	}

}
