package com.johnf.app.music.web.app;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.UserForm;
import com.johnf.app.music.service.SongListingService;
import com.johnf.app.music.service.UserService;
import com.johnf.app.music.util.MD5;
import com.johnf.app.music.vo.SongListingVo;
import com.johnf.app.music.vo.UserVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 前台用户相关Action
 * @author JohnFNash
 *
 */
@SuppressWarnings(value={"rawtypes"})
public class UserAction extends BaseAction implements ModelDriven<UserForm> {
	private static final long serialVersionUID = 6768226878085889112L;

	private UserService userService;
	
	private SongListingService songListingService;
	
	private UserForm userForm;
	
	private File image; // 上传的文件
    private String imageFileName; // 文件名称
    private String savePath;
	
	/**
	 * 用户注册逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String register() throws Exception {
		try {
			PrintWriter out = getHttpResponse().getWriter();
			//获取实际的验证码
			String validateCode = (String) getSession().get("checkCode");
			//获取用户输入的验证码
			if(userForm.getValidateCode() == null || !userForm.getValidateCode().equals(validateCode)) {//验证码错误
				out.write("code");
				out.flush();
				out.close();
				return null;
			}
			
			//判断用户名是否已经存在
			List userList = userService.listByPage(" and account='"+userForm.getAccount()+"'", 1, 1);
			if(userList!=null && userList.size()>0) {//账号已经被占用
				out.write("exists");
				out.flush();
				out.close();
				return null;
			}
			
			//将信息存入数据库
			UserVo vo = new UserVo();
			BeanUtils.copyProperties(userForm, vo);
			vo.setId(UUID.randomUUID().toString());
			vo.setPassword(MD5.getMD5Code(userForm.getPassword()));
			vo.setIsValid("1");
			userService.insert(vo);		
			out.write("success");
			out.flush();
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
			
			PrintWriter out = getHttpResponse().getWriter();
			out.write("error");
			out.flush();
			out.close();
		}
		return null;
	}
	
	/**
	 * 用户登录逻辑方法
	 * @return
	 * @throws IOException 
	 */
	public String login() throws IOException {
		PrintWriter out = getHttpResponse().getWriter();
		//获取正确的验证码
		HttpSession session = getHttpRequest().getSession(false);
		String code = (String) session.getAttribute("checkCode");
		if(!code.equals(userForm.getValidateCode())) {//验证码错误
			out.write("code");
			out.flush();
			out.close();
			return null;
		} 
		
		//验证用户登录
		String filter = " and account='"+userForm.getAccount()+ "' and password='"
				+ MD5.getMD5Code(userForm.getPassword())+"'";
		List userList = userService.listByPage(filter, 1, 1);
		if(userList!=null && userList.size()>0) {//登录成功					
			session.setAttribute("userInfo", userList.get(0));//记录当前登录的用户的信息
			session.setMaxInactiveInterval(1800);
			out.write("success");
			out.flush();
			out.close();
		} else {//用户名或者密码错误，登录失败
			out.write("other");
			out.flush();
			out.close();
		}
		return null;
	}	
	
	/**
	 * 用户注销逻辑方法
	 * @return
	 * @throws IOException 
	 */
	public String logout() throws IOException {
		getHttpRequest().getSession().removeAttribute("userInfo");		
		return null;
	}

	/**
	 * 用户个人主页逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String info() throws Exception {
		try {
			//查询用户
			UserVo vo = userService.find(userForm.getId());
			//查询用户创建的歌单
			List<SongListingVo> listingCreated = 
					songListingService.list("where userId='"+userForm.getId()+"' and isValid='1' order by createDate desc");
			//查询用户收藏的歌单
			List<SongListingVo> listingCollected = 
					songListingService.list("where id in (select listingId from listing_collection where userId='"+userForm.getId()+"')  and isValid='1'");
			//将数据放入request中
			putValue("vo", vo);
			putValue("listingCreated", listingCreated);
			putValue("listingCollected", listingCollected);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "info";
	}
	
	/**
	 * 用户歌单中心逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String mylisting() throws Exception {
		//获取当前登录的用户
		UserVo userVo = (UserVo) getSession().get("userInfo");
		//查询用户创建的歌单
		List listingCreated = songListingService.list("where isValid='1' and userId='"+userVo.getId()+"'");
		//查询用户收藏的歌单
		List listingCollected = songListingService.list("where isValid='1' and id in (select listingId from listing_collection where userId='"+userVo.getId()+"')");
		
		putValue("listingCreated", listingCreated);
		putValue("listingCollected", listingCollected);

		return "mylisting";		
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

	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getSavePath() {
		return getBasePath()+savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	@Override
	public UserForm getModel() {
		if(userForm==null) {
			userForm = new UserForm();
		}
		return userForm;
	}

	public void setSongListingService(SongListingService songListingService) {
		this.songListingService = songListingService;
	}
	
}
