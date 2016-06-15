package com.johnf.app.music.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.dao.AlbumSongDao;
import com.johnf.app.music.dao.SongDao;
import com.johnf.app.music.dao.SongSingerDao;
import com.johnf.app.music.po.AlbumSongPo;
import com.johnf.app.music.po.SongPo;
import com.johnf.app.music.po.SongSingerPo;
import com.johnf.app.music.service.SongService;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.SongVo;

@SuppressWarnings("rawtypes")
public class SongServiceImpl implements SongService {
	private SongDao songDao;
	private SongSingerDao songSingerDao;
	private AlbumSongDao albumSongDao;
	
	@Override
	public void insert(SongVo vo) {
		//将歌曲-歌手的关联信息写入数据库
        String[] singerIdStrArr = vo.getSingerInfo().trim().split(" ");
        for(String singerIdStr : singerIdStrArr) {
        	SongSingerPo songSinger = new SongSingerPo();
        	songSinger.setId(UUID.randomUUID().toString());
        	songSinger.setSingerId(singerIdStr);
        	songSinger.setSongId(vo.getId());
        	songSingerDao.insert(songSinger);
        }
        
        //将歌曲-专辑的关联信息写入数据库
        AlbumSongPo albumSongPo = new AlbumSongPo();
        albumSongPo.setId(UUID.randomUUID().toString());
        albumSongPo.setAlbumId(vo.getAlbumInfo());
        albumSongPo.setSongId(vo.getId());
        albumSongDao.insert(albumSongPo);
		
        //将歌曲信息写入数据库
		SongPo po = new SongPo();
		BeanUtils.copyProperties(vo, po);
		songDao.insert(po);
	}

	@Override
	public SongVo find(String id) {
		SongPo po = songDao.find(id);
		SongVo vo = new SongVo();
		BeanUtils.copyProperties(po, vo);
		return vo;
	}

	@Override
	public long count(SongVo vo) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getName())) {
			paramMap.put("name", "%"+vo.getName()+"%");
		}
		//按照搜索关键字查询
		if(!StringTools.isEmptyOrNull(vo.getKey())) {
			paramMap.put("name", "%"+vo.getKey()+"%");
		}
		paramMap.put("isValid", "1");
		return songDao.count(paramMap);
	}

	@Override
	public List listByPage(SongVo vo, int pageNo, int pageSize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!StringTools.isEmptyOrNull(vo.getName())) {
			paramMap.put("name", "%"+vo.getName()+"%");
		}
		//按照搜索关键字查询
		if(!StringTools.isEmptyOrNull(vo.getKey())) {
			paramMap.put("name", "%"+vo.getKey()+"%");
		}
		if(!StringTools.isEmptyOrNull(vo.getOrderBy())) {
			paramMap.put("orderby", vo.getOrderBy());
		}
		paramMap.put("isValid", "1");
		return songDao.listByPage(paramMap, (pageNo-1)*pageSize, pageSize);
	}
	
	@Override
	public List list(String filter, int pageNo, int pageSize) {
		return songDao.listByPage("Song.listByFilter", filter, (pageNo-1)*pageSize, pageSize);
	}
	
	@Override
	public List list(String filter) {
		return songDao.list(filter);
	}

	@Override
	public void update(SongVo vo) {
		SongPo po = new SongPo();
		BeanUtils.copyProperties(vo, po);
		songDao.update(po);
	}

	@Override
	public void updateState(String id, String state) {
		songDao.updateState(id, state);
	}

	public void setSongDao(SongDao songDao) {
		this.songDao = songDao;
	}

	public void setSongSingerDao(SongSingerDao songSingerDao) {
		this.songSingerDao = songSingerDao;
	}

	public void setAlbumSongDao(AlbumSongDao albumSongDao) {
		this.albumSongDao = albumSongDao;
	}

}