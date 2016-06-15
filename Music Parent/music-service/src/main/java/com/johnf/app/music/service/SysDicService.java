package com.johnf.app.music.service;

import java.util.List;

import com.johnf.app.music.vo.SysDicVo;

/**
 * 数据字典业务逻辑操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface SysDicService {
	/**
	 * 添加数据字典
	 * @param vo
	 */
	public void insert(SysDicVo vo);

	/**
	 * 统计数据字典数目
	 * @param vo
	 * @return 数据字典数目
	 */
	public long count(SysDicVo vo);
	
	/**
	 * 按照条件分页查询数据字典列表
	 * @param filter
	 * @param pageNo
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(SysDicVo vo, int pageNo, int pageSize);
	
	/**
	 * 按照条件查询列表
	 * @param vo
	 * @return
	 */
	public List list(SysDicVo vo);
	
	/**
	 * 按照条件查询列表
	 * @param type 数据字典的类型
	 * @param filter
	 * @return
	 */
	public List<SysDicVo> list(String type,String filter);
	
	/**
	 * 更新数据字典信息
	 * @param vo
	 */
	public void update(SysDicVo vo);

	/**
	 * 查询数据字典信息
	 * @param id
	 */
	public SysDicVo find(String id);
	
	/**
	 * 删除
	 * @param id
	 */
	public void delete(String id);
	
}