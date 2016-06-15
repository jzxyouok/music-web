package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 编码表实体类
 */
public class SysDicPo implements Serializable {
	private static final long serialVersionUID = 1351700881179821240L;

	//主键
	private String id;
	
	//名字
	private String name;
	
	//值
	private String value;
	
	//类型
	private String type;
		
	//排序号
	private long seqnum;
	
	//版本控制字段
	private long version;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public long getSeqnum() {
		return seqnum;
	}

	public void setSeqnum(long seqnum) {
		this.seqnum = seqnum;
	}

	public long getVersion() {
		return version;
	}

	public void setVersion(long version) {
		this.version = version;
	}

}