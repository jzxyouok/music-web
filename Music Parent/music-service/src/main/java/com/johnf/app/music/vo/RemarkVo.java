package com.johnf.app.music.vo;

import com.johnf.app.music.po.AlbumPo;
import com.johnf.app.music.po.SongListingPo;
import com.johnf.app.music.po.SongPo;
import com.johnf.app.music.po.UserPo;

/**
 * 评论业务逻辑类
 */
public class RemarkVo {
	//主键
	private String id;
	
	// 评论类型，1 歌曲评论，2 专辑评论，3 歌单评论
	private String type;
	
	//项目编号
	private String projectId;
	
	//用户编号
	private String userId;
	
	//评论内容
	private String content;
	
	//评论时间
	private String time;
	
	//评论的状态，1尚未审核，2审核通过，3审核未通过
	private String status;
	
	//是否可用，1可用/0不可用
	private String isValid;
	
	//版本控制字段
	private long version;
	
	// 用户信息
	private UserPo userPo;
	
	//歌曲信息
	private SongPo songPo;
	
	//专辑信息
	private AlbumPo albumPo;
	
	//歌单信息
	private SongListingPo songListingPo;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public UserPo getUserPo() {
		return userPo;
	}

	public void setUserPo(UserPo userPo) {
		this.userPo = userPo;
	}

	public SongPo getSongPo() {
		return songPo;
	}

	public void setSongPo(SongPo songPo) {
		this.songPo = songPo;
	}

	public AlbumPo getAlbumPo() {
		return albumPo;
	}

	public void setAlbumPo(AlbumPo albumPo) {
		this.albumPo = albumPo;
	}

	public SongListingPo getSongListingPo() {
		return songListingPo;
	}

	public void setSongListingPo(SongListingPo songListingPo) {
		this.songListingPo = songListingPo;
	}
	
}