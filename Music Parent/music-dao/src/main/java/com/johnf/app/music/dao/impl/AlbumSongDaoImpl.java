package com.johnf.app.music.dao.impl;

import java.util.HashMap;
import java.util.Map;

import com.johnf.app.music.dao.AlbumSongDao;
import com.johnf.app.music.po.AlbumSongPo;

public class AlbumSongDaoImpl extends BaseDaoImpl implements AlbumSongDao {

	@Override
	public void insert(AlbumSongPo po) {
		addObject("AlbumSong.add", po);
	}

	@Override
	public void delete(String albumId, String songId) {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("albumId", albumId);
		paramMap.put("songId", songId);
		deleteForMap("AlbumSong.delete", paramMap);
	}

}
