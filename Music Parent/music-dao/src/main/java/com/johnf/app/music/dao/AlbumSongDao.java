package com.johnf.app.music.dao;

import com.johnf.app.music.po.AlbumSongPo;

/**
 * 专辑-歌曲关联信息数据库相关操作接口
 * @author JohnFNash
 */
public interface AlbumSongDao {	
	/**
	 * 添加专辑-歌曲关联信息
	 * @param po
	 */
	public void insert(AlbumSongPo po);
	
	/**
	 * 删除专辑-歌曲关联信息
	 * @param albumId
	 * @param songId
	 */
	public void delete(String albumId, String songId);
	
}