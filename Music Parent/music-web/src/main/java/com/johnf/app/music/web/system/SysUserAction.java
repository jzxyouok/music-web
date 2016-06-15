package com.johnf.app.music.web.system;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.UserForm;
import com.johnf.app.music.service.UserService;
import com.johnf.app.music.util.MD5;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.UserVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("rawtypes")
public class SysUserAction extends BaseAction implements ModelDriven<UserForm> {
	private static final long serialVersionUID = -847060230130029325L;	
	
	private UserService userService;			

	private UserForm userForm;
	
	/**
	 * 后台默认Action逻辑方法，跳转至登录界面
	 * @return
	 * @throws Exception
	 */
	public String index() throws Exception {
		return SUCCESS;
	}
	
	/**
	 * 后台登录验证Action逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String login() throws Exception {
		try {
			//获取session
			HttpSession session = getHttpSession();
			//获取实际上的验证码	
			String checkCode = (String) session.getAttribute("checkCode");
			//验证码验证
			if(!checkCode.equals(userForm.getValidateCode())) {//如果验证码不正确，重新登录
				addActionError("验证码输入错误！");
				return INPUT;
			}
			
			UserVo userVo = new UserVo();
			BeanUtils.copyProperties(userForm, userVo);
			userVo.setPassword(MD5.getMD5Code(userVo.getPassword()));//对密码进行MD5加密
			UserVo userInfo = userService.find(userVo.getAccount(), userVo.getPassword());
			if(userInfo == null) {//用户名或密码不正确，重新登录
				addActionError("用户名或密码不正确！");
				return INPUT;
			} else {
				session.setAttribute("userInfo", userInfo);//记录登录的管理员
				session.setMaxInactiveInterval(600);
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "main";
	}

	/**
	 * 更新个人信息
	 * @return
	 * @throws Exception
	 */
	public String updatePwd() throws Exception {
		UserVo admin = (UserVo)getHttpSession().getAttribute("userInfo");
		
		PrintWriter out = getHttpResponse().getWriter();
		//获取用户输入的验证码
		String validateCode = getParameter("code");
		//获取正确的验证码
		HttpSession session = getHttpSession();
		String code = (String) session.getAttribute("checkCode");
		if(!code.equals(validateCode)) {//验证码错误			
			out.write("code");
			out.flush();
			out.close();
			return null;
		}
		
		//获取输入的原密码和新密码			
		String newPwd = getHttpRequest().getParameter("newPwd");
		if(!MD5.getMD5Code(userForm.getPassword()).equals(admin.getPassword())) {//原密码输入错误
			out.write("access");
		} else {
			UserVo vo = new UserVo();
			BeanUtils.copyProperties(userForm, vo);
			vo.setPassword(MD5.getMD5Code(newPwd));
			userService.update(vo);
			out.write("success");
		}
		out.flush();
		out.close();
		
		return null;
	}

	/**
	 * 注销
	 * @return
	 */
	public String logout() {
		getHttpSession().removeAttribute("admin");
		return "logout";
	}

	/**
	 * 用户列表
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		try {
			UserVo vo = new UserVo();
			BeanUtils.copyProperties(userForm, vo);
			//对输入的参数进行html编码
			vo.setId(StringTools.encodeHtml(vo.getId()));
			vo.setAccount(StringTools.encodeHtml(vo.getAccount()));
			//设置分页包装类
			long totalRecords = userService.count(vo);
			PageBean pageBean = new PageBean(totalRecords, pageSize+"", pageNo+"");		
			List voList = userService.listByPage(vo, pageNo, pageSize);
			pageBean.setDataList(voList);
			putValue("pageBean", pageBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		
		return "list";
	}
	
	/**
	 * 移除用户
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception {
		try {
			if(StringTools.isEmptyOrNull(userForm.getId())) {
				return INPUT;
			}
			userService.updateState(userForm.getId(), "0");
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			out.write("success");
			out.flush();
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return null;
	}
	
	@Override
	public UserForm getModel() {
		if(userForm == null) {
			userForm = new UserForm();
		}
		return userForm;
	}

	public UserForm getUserForm() {
		return userForm;
	}

	public void setUserForm(UserForm userForm) {
		this.userForm = userForm;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
}