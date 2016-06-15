package com.johnf.app.music.vo;

/**
 * 用户数据库业务逻辑类
 */
public class UserVo {
	//主键ID
	private String id;
	
	//账号
	private String account;
	
	//密码
	private String password;
	
	//性别，1男/0女
	private String sex;
	
	//头像地址
	private String headImg;
	
	//个人简介
	private String description;
	
	//是否可用，1可用/0不可用
	private String isValid;
	
	//版本控制字段
	private long version;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getHeadImg() {
		return headImg;
	}

	public void setHeadImg(String headImg) {
		this.headImg = headImg;
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
	
}