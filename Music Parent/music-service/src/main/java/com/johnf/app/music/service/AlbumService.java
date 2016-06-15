package com.johnf.app.music.service;

import java.util.List;

import com.johnf.app.music.vo.AlbumVo;

/**
 * 专辑业务逻辑操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface AlbumService {
	/**
	 * 添加专辑
	 * @param vo
	 */
	public void insert(AlbumVo vo);

	/**
	 * 按照编号查询专辑
	 * @param id
	 * @return
	 */
	public AlbumVo find(String id);
	
	/**
	 * 统计专辑数目
	 * @param albumVo
	 * @return 专辑数目
	 */
	public long count(AlbumVo albumVo);
	
	/**
	 * 按照条件分页查询专辑列表
	 * @param filter
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(AlbumVo albumVo, int pageNo, int pageSize);
	
	/**
	 * 按照条件查询专辑列表
	 * @param filter
	 * @return
	 */
	public List list(String filter);
	
	/**
	 * 更新专辑信息
	 * @param vo
	 */
	public void update(AlbumVo vo);
	
	/**
	 * 启用/停用专辑信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}