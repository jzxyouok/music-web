package com.johnf.app.music.service;

import java.util.List;

import com.johnf.app.music.vo.UserVo;

/**
 * 用户业务逻辑操作接口
 * @author JohnFNash
 */
public interface UserService {
	/**
	 * 添加用户
	 * @param vo
	 */
	public void insert(UserVo vo);

	/**
	 * 按照编号查询用户
	 * @param id
	 * @return
	 */
	public UserVo find(String id);
	
	/**
	 * 按照条件查询用户
	 * @param account
	 * @param password
	 * @return
	 */
	public UserVo find(String account, String password);
	
	/**
	 * 统计用户数目
	 * @param vo
	 * @return 用户数目
	 */
	public long count(UserVo vo);
	
	/**
	 * 按照条件分页查询用户列表
	 * @param filter
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List<UserVo> listByPage(String filter, int pageNo, int pageSize);
	
	/**
	 * 按照条件分页查询用户列表
	 * @param vo
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List<UserVo> listByPage(UserVo vo, int pageNo, int pageSize);
	
	/**
	 * 按照条件查询用户列表
	 * @param vo
	 * @return
	 */
	public List<UserVo> list(UserVo vo);
	
	/**
	 * 更新用户信息
	 * @param vo
	 */
	public void update(UserVo vo);
	
	/**
	 * 启用/停用用户信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}