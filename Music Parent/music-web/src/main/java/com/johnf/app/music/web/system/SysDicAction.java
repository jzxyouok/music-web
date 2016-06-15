package com.johnf.app.music.web.system;

import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.SysDicForm;
import com.johnf.app.music.service.SysDicService;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.vo.SysDicVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings(value={"rawtypes"})
public class SysDicAction extends BaseAction implements ModelDriven<SysDicForm> {
	private static final long serialVersionUID = -847060230130029325L;	
	
	private SysDicService sysDicService;
	
	private SysDicForm sysDicForm;	
	
	/**
	 * 列表
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		try {
			SysDicVo vo = new SysDicVo();
			BeanUtils.copyProperties(sysDicForm, vo);
			
			//设置分页包装类
			long totalRecords = sysDicService.count(vo);
			PageBean pageBean = new PageBean(totalRecords, pageSize+"", pageNo+"");		
			List voList = sysDicService.listByPage(vo, pageBean.getCurPage(), pageBean.getPageSize());
			pageBean.setDataList(voList);
			putValue("pageBean", pageBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		
		return "list";
	}
	
	/**
	 * 进入添加页面
	 * @return
	 * @throws Exception
	 */
	public String toAdd() throws Exception {
		return "add";
	}
	
	/**
	 * 添加
	 * @throws Exception
	 */
	public String add() throws Exception {
		try {
			SysDicVo vo = new SysDicVo();
	        BeanUtils.copyProperties(sysDicForm, vo);
	        vo.setId(UUID.randomUUID().toString());
	        sysDicService.insert(vo);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
        return "addSuccess";
	}
	
	/**
	 * 进入修改页面
	 * @return
	 * @throws Exception
	 */
	public String toUpdate() throws Exception {
		try {
			SysDicVo vo = sysDicService.find(sysDicForm.getId());
			putValue("vo", vo);
		} catch(Exception e){
			e.printStackTrace();
			return "exceptions";
		}
		return "update";
	}
	
	/**
	 * 修改
	 * @return
	 * @throws Exception
	 */
	public String update() throws Exception {
		try {
			SysDicVo vo = new SysDicVo();
			BeanUtils.copyProperties(sysDicForm, vo);
			sysDicService.update(vo);
		} catch(Exception e){
			e.printStackTrace();
			return "exceptions";
		}
		return "updateSuccess";
	}
	
	/**
	 * 删除
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception {
		try {
			sysDicService.delete(sysDicForm.getId());
			
			PrintWriter out = getHttpResponse().getWriter();
			out.write("success");
			out.flush();
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	@Override
	public SysDicForm getModel() {
		if(sysDicForm == null) {
			sysDicForm = new SysDicForm();
		}
		return sysDicForm;
	}

	public SysDicForm getSysDicForm() {
		return sysDicForm;
	}

	public void setSysDicForm(SysDicForm sysDicForm) {
		this.sysDicForm = sysDicForm;
	}

	public void setSysDicService(SysDicService sysDicService) {
		this.sysDicService = sysDicService;
	}

}