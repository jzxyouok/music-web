package com.johnf.app.music.dao;

import java.util.List;
import java.util.Map;

import com.johnf.app.music.po.UserPo;

/**
 * 用户数据库相关操作接口
 * @author JohnFNash
 */
public interface UserDao {	
	/**
	 * 添加用户
	 * @param po
	 */
	public void insert(UserPo po);
	
	/**
	 * 按照编号查询用户
	 * @param id 用户编号
	 * @return
	 */
	public UserPo find(String id);
	
	/**
	 * 按照账号和密码查询用户
	 * @param paramMap
	 * @return
	 */
	public UserPo findByParams(Map<String, Object> paramMap);
	
	/**
	 * 更新用户信息
	 * @param po
	 */
	public void update(UserPo po);

	/**
	 * 统计用户数目
	 * @param filter
	 * @return
	 */
	public long count(String filter);
	
	/**
	 * 按照条件分页查询用户列表
	 * @param filter
	 * @param skipResults
	 * @param pageSize 
	 * @return
	 */
	public List<UserPo> listByPage(String filter, int skipResults, int pageSize);
	
	/**
	 * 按照条件查询用户列表
	 * @param filter
	 * @return
	 */
	public List<UserPo> list(String filter);
	
	/**
	 * 启用/停用用户信息
	 * @param id
	 * @param state
	 */
	public void updateState(String id, String state);
	
}