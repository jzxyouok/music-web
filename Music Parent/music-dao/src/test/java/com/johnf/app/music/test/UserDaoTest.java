package com.johnf.app.music.test;

import java.util.UUID;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.johnf.app.music.dao.UserDao;
import com.johnf.app.music.po.UserPo;

public class UserDaoTest {
	private ApplicationContext context;
	
	@Before
	public void init() {
		context = new ClassPathXmlApplicationContext("applicationContext-dao.xml");
	}
	
	//@Test
	public void testAdd() {
		UserPo userPo = new UserPo();
		userPo.setAccount("12111111333");
		userPo.setDescription("xxxxxxx");
		String id = UUID.randomUUID().toString();
		userPo.setId(id);
		userPo.setIsValid("1");
		userPo.setPassword("12122");
		userPo.setSex("1");
		userPo.setVersion(1);
		
		UserDao userDao = (UserDao) context.getBean("userDao");
		userDao.insert(userPo);
	}
	
	@Test
	public void testFind() {
		UserDao userDao = (UserDao) context.getBean("userDao");
		UserPo po = userDao.find("0f08593f-0431-4b19-a617-10ac1d941c2f");
		Assert.assertNotNull(po);
		Assert.assertEquals("12111111333", po.getAccount());
	}
	
	
}
