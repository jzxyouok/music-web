package com.johnf.app.music.dao;

import com.johnf.app.music.po.SongSingerPo;

/**
 * 歌曲-歌手关联信息数据库相关操作接口
 * @author JohnFNash
 */
public interface SongSingerDao {	
	/**
	 * 添加歌曲-歌手关联信息
	 * @param po
	 */
	public void insert(SongSingerPo po);
	
	/**
	 * 删除歌曲-歌手关联信息
	 * @param listingId
	 */
	public void delete(String listingId);
	
}