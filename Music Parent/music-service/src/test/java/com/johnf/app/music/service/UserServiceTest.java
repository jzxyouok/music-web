package com.johnf.app.music.service;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.johnf.app.music.vo.UserVo;

public class UserServiceTest {
	private ApplicationContext context;
	
	@Before
	public void init() {
		context = new ClassPathXmlApplicationContext(new String[]{"applicationContext-dao.xml","applicationContext-service.xml"});
	}
	
	@Test
	public void testFindUser() {
		UserService userService = (UserService) context.getBean("userService");
		UserVo vo = userService.find("0f08593f-0431-4b19-a617-10ac1d941c2f");
		Assert.assertNotNull(vo);
		Assert.assertEquals("12111111333", vo.getAccount());
	}
	
}
