package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 专辑实体类
 */
public class AlbumPo implements Serializable {
	private static final long serialVersionUID = 1351700881179821240L;

	//主键
	private String id;
	
	//专辑名
	private String name;
	
	//图片
	private String image;
	
	//发行公司
	private String company;
	
	//发行日期
	private String publishDate;
	
	//地区
	private String area;
	
	//专辑描述
	private String description;
	
	//播放次数
	private long playCount;
	
	//是否可用，1可用/0不可用
	private String isValid;
	
	//版本控制字段
	private long version;
	
	// 歌手信息
	private String singerInfo;

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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getPublishDate() {
		return publishDate;
	}

	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public long getPlayCount() {
		return playCount;
	}

	public void setPlayCount(long playCount) {
		this.playCount = playCount;
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

	public String getSingerInfo() {
		return singerInfo;
	}

	public void setSingerInfo(String singerInfo) {
		this.singerInfo = singerInfo;
	}
	
}