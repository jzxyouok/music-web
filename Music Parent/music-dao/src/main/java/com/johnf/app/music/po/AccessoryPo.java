package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 附件实体类
 */
public class AccessoryPo implements Serializable {
	private static final long serialVersionUID = 1351700881179821240L;

	//主键
	private String id;
	
	//项目编号
	private String projectId;
	
	//文件类型
	private String type;
	
	//文件大小
	private Double size;
	
	//文件路径
	private String url;
	
	//是否可用，1可用/0不可用
	private String isValid;
	
	//版本控制字段
	private long version;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Double getSize() {
		return size;
	}

	public void setSize(Double size) {
		this.size = size;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getIsValid() {
		return isValid;
	}

	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

	public long getVersion() {
		return version;
	}

	public void setVersion(long version) {
		this.version = version;
	}
	
}