package com.johnf.app.music.po;

import java.io.Serializable;

/**
 * 歌单风格实体类 
 */
public class ListingStylePo implements Serializable {
	private static final long serialVersionUID = -3106988567190201151L;

	//主键
	private String id;
	
	//歌单ID
	private String listingId;
	
	//歌单风格
	private String style;
	
	//版本控制字段
	private String version;
	
	//风格对应的数据字典
	private SysDicPo dicPo;

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

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public SysDicPo getDicPo() {
		return dicPo;
	}

	public void setDicPo(SysDicPo dicPo) {
		this.dicPo = dicPo;
	}
	
}