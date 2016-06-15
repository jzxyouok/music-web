package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 歌曲实体类
 */
public class SongPo implements Serializable {
	private static final long serialVersionUID = -5522922095172505193L;

	//主键ID
	private String id;
	
	//歌曲名
	private String name;
	
	//歌曲语言
	private String language;
	
	//歌曲时长
	private String duration;
	
	//播放次数
	private String playCount;
	
	//歌曲描述
	private String description;
	
	//音频文件路径
	private String audio;
	
	//歌词文件路径
	private String lyric;
	
	//是否可用，1可用/0不可用
	private String isValid;
	
	//版本控制字段
	private long version;

	//歌手信息
	private String singerInfo;
	
	//专辑信息
	private String albumInfo;
	
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

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public String getPlayCount() {
		return playCount;
	}

	public void setPlayCount(String playCount) {
		this.playCount = playCount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public String getAudio() {
		return audio;
	}

	public void setAudio(String audio) {
		this.audio = audio;
	}

	public String getLyric() {
		return lyric;
	}

	public void setLyric(String lyric) {
		this.lyric = lyric;
	}

	public String getAlbumInfo() {
		return albumInfo;
	}

	public void setAlbumInfo(String albumInfo) {
		this.albumInfo = albumInfo;
	}
	
}