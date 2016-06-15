package com.johnf.app.music.dao.impl;

import com.johnf.app.music.dao.SongSingerDao;
import com.johnf.app.music.po.SongSingerPo;

public class SongSingerDaoImpl extends BaseDaoImpl implements SongSingerDao {

	@Override
	public void insert(SongSingerPo po) {
		addObject("SongSinger.add", po);
	}

	@Override
	public void delete(String listingId) {
		deleteObject("SongSinger.delete", listingId);
	}

}
