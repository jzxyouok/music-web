package com.johnf.app.music.web.system;

import java.io.PrintWriter;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.RemarkForm;
import com.johnf.app.music.service.RemarkService;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.RemarkVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("rawtypes")
public class SysRemarkAction extends BaseAction implements ModelDriven<RemarkForm> {
	private static final long serialVersionUID = -847060230130029325L;	
	
	private RemarkService remarkService;			

	private RemarkForm remarkForm;	
	
	/**
	 * 列表
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		try {
			RemarkVo vo = new RemarkVo();
			if(StringTools.isEmptyOrNull(remarkForm.getStatus())) {
				remarkForm.setStatus("0");
			}
			BeanUtils.copyProperties(remarkForm, vo);
			
			//设置分页包装类
			long totalRecords = remarkService.count(vo);
			PageBean pageBean = new PageBean(totalRecords, pageSize+"", pageNo+"");		
			List voList = remarkService.listByPage(vo, pageBean.getCurPage(), pageBean.getPageSize());
			pageBean.setDataList(voList);
			putValue("pageBean", pageBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		
		return "list";
	}
	
	/**
	 * 审核评论
	 * @return
	 * @throws Exception
	 */
	public String update() throws Exception {
		try {
			RemarkVo vo = new RemarkVo();
			BeanUtils.copyProperties(remarkForm, vo);
			remarkService.update(vo);
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
			remarkService.updateState(remarkForm.getId(), "0");
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
	public RemarkForm getModel() {
		if(remarkForm == null) {
			remarkForm = new RemarkForm();
		}
		return remarkForm;
	}

	public RemarkForm getRemarkForm() {
		return remarkForm;
	}

	public void setRemarkForm(RemarkForm remarkForm) {
		this.remarkForm = remarkForm;
	}

	public void setRemarkService(RemarkService remarkService) {
		this.remarkService = remarkService;
	}
	
}