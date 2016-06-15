package com.johnf.app.music.service;

import java.util.List;

import com.johnf.app.music.vo.RemarkVo;

/**
 * 评论业务逻辑操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface RemarkService {
	/**
	 * 添加评论
	 * @param vo
	 */
	public void insert(RemarkVo vo);

	/**
	 * 按照编号查询评论
	 * @param id
	 * @return
	 */
	public RemarkVo find(String id);
	
	/**
	 * 统计评论数目
	 * @param vo
	 * @return 评论数目
	 */
	public long count(RemarkVo vo);
	
	/**
	 * 按照条件分页查询评论列表
	 * @param vo
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(RemarkVo vo, int pageNo, int pageSize);
	
	/**
	 * 更新评论信息
	 * @param vo
	 */
	public void update(RemarkVo vo);
	
	/**
	 * 启用/停用评论信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}