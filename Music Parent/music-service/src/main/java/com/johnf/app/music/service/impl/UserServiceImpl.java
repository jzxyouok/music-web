package com.johnf.app.music.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.dao.SongListingDao;
import com.johnf.app.music.dao.UserDao;
import com.johnf.app.music.po.SongListingPo;
import com.johnf.app.music.po.UserPo;
import com.johnf.app.music.service.UserService;
import com.johnf.app.music.util.DateTools;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.UserVo;

public class UserServiceImpl implements UserService {
	private UserDao userDao;
	private SongListingDao songListingDao;
	
	@Override
	public void insert(UserVo vo) {
		//添加用户
		UserPo po = new UserPo();
		BeanUtils.copyProperties(vo, po);
		userDao.insert(po);
		
		//创建用户默认的歌单
		SongListingPo songListing = new SongListingPo();
		songListing.setId(UUID.randomUUID().toString());
		songListing.setName("我喜欢的音乐");
		songListing.setImage("images/listing/default_songlisting.png");
		songListing.setUserId(po.getId());
		songListing.setIsValid("1");
		songListing.setCreateDate(DateTools.getCurrentTime());
		songListingDao.insert(songListing);
	}

	@Override
	public UserVo find(String id) {
		UserPo po = userDao.find(id);
		UserVo vo = new UserVo();
		BeanUtils.copyProperties(po, vo);
		return vo;
	}
	
	@Override
	public UserVo find(String account, String password) {
		//构造参数map
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("account", account);
		paramMap.put("password", password);
		//查询
		UserPo po = userDao.findByParams(paramMap);
		if(po != null) {
			UserVo vo = new UserVo();
			BeanUtils.copyProperties(po, vo);
			return vo;
		} else {
			return null;
		}
	}

	@Override
	public long count(UserVo vo) {
		StringBuffer filter = new StringBuffer();
		if(!StringTools.isEmptyOrNull(vo.getId())) {
			filter.append(" and id like '%").append(vo.getId()).append("%' ");
		}
		if(!StringTools.isEmptyOrNull(vo.getAccount())) {
			filter.append(" and account like '%").append(vo.getAccount()).append("%' ");
		}
		return userDao.count(filter.toString());
	}

	@Override
	public List<UserVo> listByPage(UserVo vo, int pageNo, int pageSize) {
		StringBuffer filter = new StringBuffer();
		if(!StringTools.isEmptyOrNull(vo.getId())) {
			filter.append(" and id like '%").append(vo.getId()).append("%' ");
		}
		if(!StringTools.isEmptyOrNull(vo.getAccount())) {
			filter.append(" and account like '%" + vo.getAccount() + "%'");
		}
		List<UserPo> poList = 
				userDao.listByPage(filter.toString(), (pageNo-1)*pageSize, pageSize);
		List<UserVo> voList = new ArrayList<UserVo>();
		UserVo tmpVo;
		for(UserPo tmpPo : poList) {
			tmpVo = new UserVo();
			BeanUtils.copyProperties(tmpPo, tmpVo);
			voList.add(tmpVo);
		}
		return voList;
	}
	
	@Override
	public List<UserVo> listByPage(String filter, int pageNo, int pageSize) {
		List<UserPo> poList = 
				userDao.listByPage(filter, (pageNo-1)*pageSize, pageSize);
		List<UserVo> voList = new ArrayList<UserVo>();
		UserVo tmpVo;
		for(UserPo tmpPo : poList) {
			tmpVo = new UserVo();
			BeanUtils.copyProperties(tmpPo, tmpVo);
			voList.add(tmpVo);
		}
		return voList;
	}

	@Override
	public List<UserVo> list(UserVo vo) {
		StringBuffer filter = new StringBuffer();
		if(!StringTools.isEmptyOrNull(vo.getId())) {
			filter.append(" and id like '%").append(vo.getId()).append("%' ");
		}
		if(!StringTools.isEmptyOrNull(vo.getAccount())) {
			filter.append(" and account like '%" + vo.getAccount() + "%'");
		}
		List<UserPo> poList = userDao.list(filter.toString());
		List<UserVo> voList = new ArrayList<UserVo>();
		UserVo tmpVo;
		for(UserPo tmpPo : poList) {
			tmpVo = new UserVo();
			BeanUtils.copyProperties(tmpPo, tmpVo);
			voList.add(tmpVo);
		}
		return voList;
	}

	@Override
	public void update(UserVo vo) {
		UserPo po = new UserPo();
		BeanUtils.copyProperties(vo, po);
		userDao.update(po);
	}

	@Override
	public void updateState(String id, String state) {
		userDao.updateState(id, state);
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public void setSongListingDao(SongListingDao songListingDao) {
		this.songListingDao = songListingDao;
	}
	
}
