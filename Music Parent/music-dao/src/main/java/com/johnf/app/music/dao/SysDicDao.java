package com.johnf.app.music.dao;

import java.util.List;
import java.util.Map;

import com.johnf.app.music.po.SysDicPo;

/**
 * 数据字典数据库相关操作接口
 * @author JohnFNash
 */
@SuppressWarnings("rawtypes")
public interface SysDicDao extends BaseDao {
	/**
	 * 添加数据字典
	 * @param po 数据字典
	 */
	public void insert(SysDicPo po);

	/**
	 * 按照编号查询数据字典
	 * @param id
	 * @return
	 */
	public SysDicPo find(String id);
	
	/**
	 * 统计数据字典数目
	 * @param paramMap
	 * @return 数据字典数目
	 */
	public long count(Map<String,Object> paramMap);
	
	/**
	 * 按照条件分页查询数据字典列表
	 * @param paramMap
	 * @param skipResults
	 * @param pageSize 
	 * @return
	 */
	public List listByPage(Map<String,Object> paramMap, int skipResults, int pageSize);
	
	/**
	 * 按照条件查询数据字典列表
	 * @param paramMap
	 * @return
	 */
	public List<SysDicPo> list(Map<String,Object> paramMap);
	
	/**
	 * 更新数据字典信息
	 * @param po
	 */
	public void update(SysDicPo po);
	
	/**
	 * 删除数据字典信息
	 * @param id
	 */
	public void delete(String id);
	
}
