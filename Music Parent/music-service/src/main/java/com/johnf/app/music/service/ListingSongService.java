package com.johnf.app.music.service;

import com.johnf.app.music.vo.ListingSongVo;

/**
 * 歌单业务逻辑操作接口
 * @author JohnFNash
 */
public interface ListingSongService {
	/**
	 * 添加歌单
	 * @param vo
	 */
	public void insert(ListingSongVo vo);

	/**
	 * 从歌单中移除歌曲
	 * @param listingId 歌单id
	 * @param songId 歌曲id
	 */
	public void delete(String listingId, String songId);
	
}