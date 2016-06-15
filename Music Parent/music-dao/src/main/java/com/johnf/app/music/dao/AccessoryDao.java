package com.johnf.app.music.dao;

import com.johnf.app.music.po.AccessoryPo;

/**
 * 附件关联信息数据库相关操作接口
 * @author JohnFNash
 */
public interface AccessoryDao {	
	/**
	 * 添加附件关联信息
	 * @param po
	 */
	public void insert(AccessoryPo po);
	
	/**
	 * 删除附件关联信息
	 * @param projectId
	 * @param type
	 */
	public void delete(String projectId, String type);
	
}