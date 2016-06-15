package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 歌单收藏实体类 
 */
public class ListingCollectionPo implements Serializable {
	private static final long serialVersionUID = -3106988567190201151L;

	//主键
	private String id;
	
	//歌单ID
	private String listingId;
	
	//收藏者ID
	private String userId;
	
	//版本控制字段
	private String version;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getListingId() {
		return listingId;
	}

	public void setListingId(String listingId) {
		this.listingId = listingId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
}