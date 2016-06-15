package com.johnf.app.music.dao;

import com.johnf.app.music.po.ListingLanguagePo;

/**
 * 歌单语言信息数据库相关操作接口
 * @author JohnFNash
 */
public interface ListingLanguageDao {	
	/**
	 * 添加歌单语言信息
	 * @param po
	 */
	public void insert(ListingLanguagePo po);
	
	/**
	 * 删除歌单语言信息
	 * @param listingId
	 */
	public void delete(String listingId);
	
}