package com.johnf.app.music.web.app;

import java.io.PrintWriter;
import java.util.UUID;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.RemarkForm;
import com.johnf.app.music.service.RemarkService;
import com.johnf.app.music.util.DateTools;
import com.johnf.app.music.vo.RemarkVo;
import com.johnf.app.music.vo.UserVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 专辑评论相关Action
 * @author JohnFNash
 *
 */
public class RemarkAction extends BaseAction implements ModelDriven<RemarkForm> {
	private static final long serialVersionUID = -5802462858420206262L;

	private RemarkService remarkService;
	private RemarkForm remarkForm;
	
	/**
	 * 发表评论逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String publish() throws Exception {
		try {
			//获取登录的用户的信息
			UserVo userVo = (UserVo) getHttpSession().getAttribute("userInfo");
			//构造RemarkVo并存入数据库
			RemarkVo vo = new RemarkVo();
			BeanUtils.copyProperties(remarkForm, vo);
			vo.setTime(DateTools.getCurrentTime());
			vo.setIsValid("1");
			vo.setUserId(userVo.getId());
			vo.setId(UUID.randomUUID().toString());
			vo.setStatus("0");
			remarkService.insert(vo);
			
			PrintWriter out = getHttpResponse().getWriter();
			out.write("success");
			out.flush();
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void setRemarkService(RemarkService remarkService) {
		this.remarkService = remarkService;
	}

	@Override
	public RemarkForm getModel() {
		if(remarkForm == null) {
			remarkForm = new RemarkForm();
		}
		return remarkForm;
	}
	
}
