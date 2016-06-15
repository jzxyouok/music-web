package com.johnf.app.music.service;

import com.johnf.app.music.vo.ListingCollectionVo;

/**
 * 歌单收藏业务逻辑操作接口
 * @author 
 */
public interface ListingCollectionService {
	/**
	 * 收藏歌单
	 * @param vo
	 */
	public void insert(ListingCollectionVo vo);

	/**
	 * 取消用户的给定歌单的收藏
	 * @param listingId 歌单id
	 * @param userId 用户id
	 */
	public void delete(String listingId, String userId);
	
}