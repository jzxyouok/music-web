package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 歌单-歌曲关联实体类 
 */
public class ListingSongPo implements Serializable {
	private static final long serialVersionUID = -3106988567190201151L;

	//主键
	private String id;
	
	//歌单ID
	private String listingId;
	
	//歌曲ID
	private String songId;
	
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

	public String getSongId() {
		return songId;
	}

	public void setSongId(String songId) {
		this.songId = songId;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
}