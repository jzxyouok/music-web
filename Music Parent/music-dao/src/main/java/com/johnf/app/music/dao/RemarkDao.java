package com.johnf.app.music.dao;

import java.util.List;
import java.util.Map;

import com.johnf.app.music.po.RemarkPo;

/**
 * 评论数据库相关操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface RemarkDao {	
	/**
	 * 添加评论
	 * @param po
	 */
	public void insert(RemarkPo po);
	
	/**
	 * 按照编号查询评论
	 * @param id
	 * @return
	 */
	public RemarkPo find(String id);
	
	/**
	 * 更新评论信息
	 * @param po
	 */
	public void update(RemarkPo po);

	/**
	 * 统计评论数目
	 * @param paramMap
	 * @return
	 */
	public long count(Map<String,Object> paramMap);
	
	/**
	 * 按照条件分页查询评论列表
	 * @param paramMap
	 * @param skipResults
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(Map<String,Object> paramMap, int skipResults, int pageSize);
	
	/**
	 * 启用/停用评论信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}