package com.johnf.app.music.dao;

import java.util.Map;

import com.johnf.app.music.po.ListingCollectionPo;

/**
 * 歌单收藏信息数据库相关操作接口
 * @author JohnFNash
 */
public interface ListingCollectionDao {	
	/**
	 * 添加歌单收藏信息
	 * @param po
	 */
	public void insert(ListingCollectionPo po);
	
	/**
	 * 删除歌单收藏信息
	 * @param paramMap 参数map
	 */
	public void delete(Map<String,Object> paramMap);
	
}