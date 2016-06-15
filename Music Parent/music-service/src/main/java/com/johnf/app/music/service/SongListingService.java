package com.johnf.app.music.service;

import java.util.List;

import com.johnf.app.music.vo.SongListingVo;

/**
 * 歌单业务逻辑操作接口
 * @author JohnFNash
 */
public interface SongListingService {
	/**
	 * 添加歌单
	 * @param vo
	 */
	public void insert(SongListingVo vo);

	/**
	 * 按照编号查询歌单
	 * @param id
	 * @return
	 */
	public SongListingVo find(String id);
	
	/**
	 * 统计歌单数目
	 * @param vo
	 * @return 歌单数目
	 */
	public long count(SongListingVo vo);
	
	/**
	 * 按照条件分页查询歌单列表
	 * @param filter
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List<SongListingVo> listByPage(SongListingVo vo, int pageNo, int pageSize);
	
	/**
	 * 按照条件查询歌单列表
	 * @param filter
	 * @return
	 */
	public List<SongListingVo> list(String filter);
	
	/**
	 * 更新歌单信息
	 * @param vo
	 */
	public void update(SongListingVo vo);
	
	/**
	 * 启用/停用歌单信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}