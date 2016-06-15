package com.johnf.app.music.dao;

import java.util.List;
import java.util.Map;

import com.johnf.app.music.po.SingerPo;

/**
 * 歌手数据库相关操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface SingerDao extends BaseDao {
	/**
	 * 添加歌手
	 * @param po
	 */
	public void insert(SingerPo po);

	/**
	 * 按照编号查询歌手
	 * @param id
	 * @return
	 */
	public SingerPo find(String id);
	
	/**
	 * 统计歌手数目
	 * @param paramMap
	 * @return 歌手数目
	 */
	public long count(Map<String,Object> paramMap);
	
	/**
	 * 按照条件分页查询歌手列表
	 * @param paramMap
	 * @param skipResults
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(Map<String, Object> paramMap, int skipResults, int pageSize);
	
	/**
	 * 按照条件查询歌手列表
	 * @param filter
	 * @return
	 */
	public List list(String filter);
	
	/**
	 * 更新歌手信息
	 * @param po
	 */
	public void update(SingerPo po);
	
	/**
	 * 启用/停用歌手信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
}
