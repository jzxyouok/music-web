package com.johnf.app.music.po;

import java.io.Serializable;
import java.util.List;

/**
 * 歌单实体类
 */
public class SongListingPo implements Serializable {
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
	
	//播放次数
	private long playCount;
	
	//是否可用，1可用/0不可用
	private String isValid;
	
	//版本控制字段
	private long version;
	
	//歌单创建者信息
	private UserPo userPo;
	
	//歌单中的歌曲数目
	private int songsInListing;
	
	//歌单被收藏数目
	private int listingCollected;
	
	//歌单的风格列表
	private List<ListingStylePo> styleList;
	
	//歌单的语言列表
	private List<ListingLanguagePo> languageList;

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

	public UserPo getUserPo() {
		return userPo;
	}

	public void setUserPo(UserPo userPo) {
		this.userPo = userPo;
	}

	public int getSongsInListing() {
		return songsInListing;
	}

	public void setSongsInListing(int songsInListing) {
		this.songsInListing = songsInListing;
	}

	public List<ListingStylePo> getStyleList() {
		return styleList;
	}

	public void setStyleList(List<ListingStylePo> styleList) {
		this.styleList = styleList;
	}

	public List<ListingLanguagePo> getLanguageList() {
		return languageList;
	}

	public void setLanguageList(List<ListingLanguagePo> languageList) {
		this.languageList = languageList;
	}

	public int getListingCollected() {
		return listingCollected;
	}

	public void setListingCollected(int listingCollected) {
		this.listingCollected = listingCollected;
	}

}