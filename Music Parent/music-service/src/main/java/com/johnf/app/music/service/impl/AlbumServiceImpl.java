package com.johnf.app.music.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.dao.AlbumDao;
import com.johnf.app.music.dao.AlbumSingerDao;
import com.johnf.app.music.po.AlbumPo;
import com.johnf.app.music.po.AlbumSingerPo;
import com.johnf.app.music.service.AlbumService;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.AlbumVo;

@SuppressWarnings("rawtypes")
public class AlbumServiceImpl implements AlbumService {
	private AlbumDao albumDao;
	private AlbumSingerDao albumSingerDao;
	
	@Override
	public void insert(AlbumVo vo) {
		//添加专辑-歌手关联信息
		if(!StringTools.isEmptyOrNull(vo.getSingerIds())) {
			String singerIds = vo.getSingerIds().replace(" ", "");
			String[] singerIdArr = singerIds.split(",");
			AlbumSingerPo albumSingerPo;
			for(String id : singerIdArr) {
				albumSingerPo = new AlbumSingerPo();
				albumSingerPo.setId(UUID.randomUUID().toString());
				albumSingerPo.setAlbumId(vo.getId());
				albumSingerPo.setSingerId(id);
				albumSingerPo.setVersion(0);
				albumSingerDao.insert(albumSingerPo);
			}
		}
		//添加专辑信息
		AlbumPo po = new AlbumPo();
		BeanUtils.copyProperties(vo, po);
		albumDao.insert(po);
	}

	@Override
	public AlbumVo find(String id) {
		AlbumPo po = albumDao.find(id);
		AlbumVo vo = new AlbumVo();
		BeanUtils.copyProperties(po, vo);
		return vo;
	}

	@Override
	public long count(AlbumVo vo) {
		StringBuffer filter = new StringBuffer(" where 1=1 ");
		if(!StringTools.isEmptyOrNull(vo.getName())) {
			filter.append(" and name like '%").append(vo.getName()).append("%' ");
		}
		if(!StringTools.isEmptyOrNull(vo.getKey())) {
			filter.append(" and name like '%").append(vo.getKey()).append("%' ");
		}
		if(!StringTools.isEmptyOrNull(vo.getArea())) {
			filter.append(" and area='").append(vo.getArea()).append("%' ");
		}
		if(!StringTools.isEmptyOrNull(vo.getIsValid())) {
			filter.append(" and isValid='").append(vo.getIsValid()).append("' ");
		}
		return albumDao.count(filter.toString());
	}

	@Override
	public List listByPage(AlbumVo vo, int pageNo, int pageSize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getName())) {
			paramMap.put("name", "%"+vo.getName()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getKey())) {
			paramMap.put("name", "%"+vo.getKey()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getArea())) {
			paramMap.put("area", vo.getArea());
		}
		if(!StringTools.isEmptyOrNull(vo.getOrderBy())) {
			paramMap.put("orderby", vo.getOrderBy());
		}
		if(!StringTools.isEmptyOrNull(vo.getIsValid())) {
			paramMap.put("isValid", vo.getIsValid());
		}
		return albumDao.listByPage(paramMap, (pageNo-1)*pageSize, pageSize);
	}

	@Override
	public List list(String filter) {
		return albumDao.list(filter);
	}

	@Override
	public void update(AlbumVo vo) {
		AlbumPo po = new AlbumPo();
		BeanUtils.copyProperties(vo, po);
		albumDao.update(po);
	}

	@Override
	public void updateState(String id, String state) {
		albumDao.updateState(id, state);
	}

	public void setAlbumDao(AlbumDao albumDao) {
		this.albumDao = albumDao;
	}

	public void setAlbumSingerDao(AlbumSingerDao albumSingerDao) {
		this.albumSingerDao = albumSingerDao;
	}
	
}
