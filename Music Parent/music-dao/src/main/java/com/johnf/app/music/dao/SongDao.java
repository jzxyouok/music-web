package com.johnf.app.music.dao;

import java.util.List;
import java.util.Map;

import com.johnf.app.music.po.SongPo;

/**
 * 歌曲数据库相关操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface SongDao extends BaseDao {
	/**
	 * 添加
	 * @param po
	 */
	public void insert(SongPo po);

	/**
	 * 按照编号查询
	 * @param id
	 * @return
	 */
	public SongPo find(String id);
	
	/**
	 * 统计数目
	 * @param paramMap
	 * @return 数目
	 */
	public long count(Map<String,Object> paramMap);
	
	/**
	 * 统计数目
	 * @param filter
	 * @return 数目
	 */
	public long count(String filter);
	
	/**
	 * 按照条件分页查询列表
	 * @param paramMap
	 * @param skipResults
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(Map<String, Object> paramMap, int skipResults, int pageSize);
	
	/**
	 * 按照条件查询列表
	 * @param filter
	 * @return
	 */
	public List list(String filter);
	
	/**
	 * 更新信息
	 * @param po
	 */
	public void update(SongPo po);
	
	/**
	 * 启用/停用信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
}