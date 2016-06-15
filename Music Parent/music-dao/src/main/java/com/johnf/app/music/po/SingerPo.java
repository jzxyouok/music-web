package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 歌手数据库实体类
 */
public class SingerPo implements Serializable {
	private static final long serialVersionUID = 7927997877160385493L;

	//主键ID
	private String id;
	
	//名字
	private String name;
	
	//歌手名字简拼
	private String abbr;
	
	//歌手类别
	private String category;
	
	//小图片地址
	private String smallImg;
	
	//大图片地址
	private String bigImg;
	
	//类别，1个人/2组合
	private String type;
	
	//歌手性别，1男/0女
	private String sex;
	
	//歌手描述
	private String description;
	
	//乐队描述
	private String bankDescription;
	
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAbbr() {
		return abbr;
	}

	public void setAbbr(String abbr) {
		this.abbr = abbr;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSmallImg() {
		return smallImg;
	}

	public void setSmallImg(String smallImg) {
		this.smallImg = smallImg;
	}

	public String getBigImg() {
		return bigImg;
	}

	public void setBigImg(String bigImg) {
		this.bigImg = bigImg;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getBankDescription() {
		return bankDescription;
	}

	public void setBankDescription(String bankDescription) {
		this.bankDescription = bankDescription;
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