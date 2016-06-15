package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 专辑-歌手关联实体类 
 */
public class AlbumSingerPo implements Serializable {
	private static final long serialVersionUID = -3106988567190201151L;

	//主键
	private String id;
	
	//专辑ID
	private String albumId;
	
	//歌手ID
	private String singerId;
	
	//版本控制字段
	private long version;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAlbumId() {
		return albumId;
	}

	public void setAlbumId(String albumId) {
		this.albumId = albumId;
	}

	public String getSingerId() {
		return singerId;
	}

	public void setSingerId(String singerId) {
		this.singerId = singerId;
	}

	public long getVersion() {
		return version;
	}

	public void setVersion(long version) {
		this.version = version;
	}

}