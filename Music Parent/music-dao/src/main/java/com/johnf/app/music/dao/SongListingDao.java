package com.johnf.app.music.dao;

import java.util.List;
import java.util.Map;

import com.johnf.app.music.po.SongListingPo;

/**
 * 歌单数据库相关操作接口
 * @author JohnFNash
 */
public interface SongListingDao extends BaseDao {
	/**
	 * 添加歌单
	 * @param po 歌单
	 */
	public void insert(SongListingPo po);

	/**
	 * 按照编号查询歌单
	 * @param id
	 * @return
	 */
	public SongListingPo find(String id);
	
	/**
	 * 统计歌单数目
	 * @return 歌单数目
	 */
	public long count(Map<String,Object> paramMap);
	
	/**
	 * 按照条件分页查询歌单列表
	 * @param paramMap
	 * @param skipResults
	 * @param pageSize 
	 * @return
	 */
	public List<SongListingPo> listByPage(Map<String,Object> paramMap, int skipResults, int pageSize);
	
	/**
	 * 按照条件查询歌单列表
	 * @param filter
	 * @return
	 */
	public List<SongListingPo> list(String filter);
	
	/**
	 * 更新歌单信息
	 * @param po
	 */
	public void update(SongListingPo po);
	
	/**
	 * 启用/停用歌单信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}
