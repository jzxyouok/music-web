package com.johnf.app.music.service;

import java.util.List;

import com.johnf.app.music.vo.SingerVo;

/**
 * 歌手业务逻辑操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface SingerService {
	/**
	 * 添加歌手
	 * @param vo
	 */
	public void insert(SingerVo vo);

	/**
	 * 按照编号查询歌手
	 * @param id
	 * @return
	 */
	public SingerVo find(String id);
	
	/**
	 * 统计歌手数目
	 * @param vo
	 * @return 歌手数目
	 */
	public long count(SingerVo vo);
	
	/**
	 * 按照条件分页查询歌手列表
	 * @param vo
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(SingerVo vo, int pageNo, int pageSize);
	
	/**
	 * 按照条件分页查询歌手列表
	 * @param filter
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(String filter, int pageNo, int pageSize);
	
	/**
	 * 更新歌手信息
	 * @param vo
	 */
	public void update(SingerVo vo);
	
	/**
	 * 启用/停用歌手信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}