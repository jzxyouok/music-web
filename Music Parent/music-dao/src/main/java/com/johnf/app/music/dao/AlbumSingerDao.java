package com.johnf.app.music.dao;

import com.johnf.app.music.po.AlbumSingerPo;

/**
 * 专辑-歌手关联信息数据库相关操作接口
 * @author JohnFNash
 */
public interface AlbumSingerDao {
	/**
	 * 添加专辑-歌手关联信息
	 * @param po
	 */
	public void insert(AlbumSingerPo po);
	
	/**
	 * 删除专辑-歌手关联信息
	 * @param albumId
	 */
	public void delete(String albumId);
	
}