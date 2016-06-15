package com.johnf.app.music.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * 登录验证拦截器
 * @author JohnFNash
 */
public class CheckLogin extends AbstractInterceptor{	
	private static final long serialVersionUID = 1L;
	
	public String intercept(ActionInvocation invocation) throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String actName = invocation.getInvocationContext().getName();
		if("sysUser_login".equals(actName)||"code".equals(actName)||"sysUser_logout".equals(actName)
				|| "indexAction".equals(actName) || actName.startsWith("album_")
				|| actName.startsWith("singer_") || actName.startsWith("song_")
				|| actName.startsWith("songListing_") || actName.startsWith("user_register")
				|| actName.startsWith("user_login")){
			return invocation.invoke();
		}
		//session失效
		if(null == request.getSession(false)){
			return "logout";
		}else{
			HttpSession session = request.getSession();
			if(null == session.getAttribute("userInfo")){
				return "logout";
			}else{
				return invocation.invoke();
			}
		}
	}
}