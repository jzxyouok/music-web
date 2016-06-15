package com.johnf.app.music.dao;

import java.util.List;
import java.util.Map;

import com.johnf.app.music.po.AlbumPo;

/**
 * 专辑数据库相关操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface AlbumDao {
	/**
	 * 添加专辑
	 * @param po 专辑
	 */
	public void insert(AlbumPo po);

	/**
	 * 按照编号查询专辑
	 * @param id
	 * @return
	 */
	public AlbumPo find(String id);
	
	/**
	 * 统计专辑数目
	 * @return 专辑数目
	 */
	public long count(String filter);
	
	/**
	 * 按照条件分页查询专辑列表
	 * @param paramMap
	 * @param skipResults
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(Map<String,Object> paramMap, int skipResults, int pageSize);
	
	/**
	 * 按照条件查询专辑列表
	 * @param filter
	 * @return
	 */
	public List list(String filter);
	
	/**
	 * 更新专辑信息
	 * @param po
	 */
	public void update(AlbumPo po);
	
	/**
	 * 启用/停用专辑信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}
