package com.johnf.app.music.form;

import java.io.Serializable;

/**
 * 歌单表示层对象
 */
public class SongListingForm implements Serializable {
	private static final long serialVersionUID = 1351700881179821240L;

	//主键
	private String id;
	
	//歌单名
	private String name;
	
	//图片
	private String image;
	
	//创建者ID
	private String userId;
	
	//创建日期
	private String createDate;
	
	//歌单描述
	private String description;
	
	//语言
	private String language;
	
	//风格
	private String style;
	
	//播放次数
	private long playCount;
	
	//是否可用，1可用/0不可用
	private String isValid;
	
	//版本控制字段
	private long version;
	
	//排序字段(用于排序)
	private String orderBy;
	
	//搜索关键字
	private String key;

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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
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

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}
	
}