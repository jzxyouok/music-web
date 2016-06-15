package com.johnf.app.music.dao;

import com.johnf.app.music.po.ListingStylePo;

/**
 * 歌单风格数据库操作接口
 * @author JohnFNash
 */
public interface ListingStyleDao {	
	/**
	 * 新增歌单风格
	 * @param po
	 */
	public void insert(ListingStylePo po);
	
	/**
	 * 删除给定歌单的所有风格信息
	 * @param listingId
	 */
	public void delete(String listingId);
	
}