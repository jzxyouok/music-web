package com.johnf.app.music.service;

import java.util.List;

import com.johnf.app.music.vo.SongVo;

/**
 * 歌曲业务逻辑操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface SongService {
	/**
	 * 添加
	 * @param vo
	 */
	public void insert(SongVo vo);

	/**
	 * 按照编号查询
	 * @param id
	 * @return
	 */
	public SongVo find(String id);
	
	/**
	 * 统计数目
	 * @param vo
	 * @return 数目
	 */
	public long count(SongVo vo);
	
	/**
	 * 按照条件分页查询列表
	 * @param vo
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(SongVo vo, int pageNo, int pageSize);
	
	/**
	 * 按照条件分页查询列表
	 * @param filter
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List list(String filter, int pageNo, int pageSize);
	
	/**
	 * 按照条件查询所有的列表
	 * @param filter
	 * @return
	 */
	public List list(String filter);
	
	/**
	 * 更新信息
	 * @param vo
	 */
	public void update(SongVo vo);
	
	/**
	 * 启用/停用信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}