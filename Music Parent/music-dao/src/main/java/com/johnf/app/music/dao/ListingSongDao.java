package com.johnf.app.music.dao;

import com.johnf.app.music.po.ListingSongPo;

/**
 * 歌单-歌曲关联信息数据库相关操作接口
 * @author JohnFNash
 */
public interface ListingSongDao {	
	/**
	 * 添加歌单-歌曲关联信息
	 * @param po
	 */
	public void insert(ListingSongPo po);
	
	/**
	 * 删除歌单-歌曲关联信息
	 * @param listingId
	 * @param songId
	 */
	public void delete(String listingId, String songId);
	
}