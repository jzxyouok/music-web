package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 歌曲-歌手关联实体类 
 */
public class SongSingerPo implements Serializable {
	private static final long serialVersionUID = -3106988567190201151L;

	//主键
	private String id;
	
	//歌曲ID
	private String songId;
	
	//歌手ID
	private String singerId;
	
	//版本控制字段
	private String version;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSongId() {
		return songId;
	}

	public void setSongId(String songId) {
		this.songId = songId;
	}

	public String getSingerId() {
		return singerId;
	}

	public void setSingerId(String singerId) {
		this.singerId = singerId;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
}