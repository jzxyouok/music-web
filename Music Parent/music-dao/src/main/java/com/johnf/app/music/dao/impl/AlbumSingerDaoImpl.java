package com.johnf.app.music.dao.impl;

import com.johnf.app.music.dao.AlbumSingerDao;
import com.johnf.app.music.po.AlbumSingerPo;

public class AlbumSingerDaoImpl extends BaseDaoImpl implements AlbumSingerDao {

	@Override
	public void insert(AlbumSingerPo po) {
		addObject("AlbumSinger.add", po);
	}

	@Override
	public void delete(String albumId) {
		deleteObject("AlbumSinger.delete", albumId);
	}

}
