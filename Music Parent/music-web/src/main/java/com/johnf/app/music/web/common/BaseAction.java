package com.johnf.app.music.web.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.johnf.app.music.util.Constants;
import com.johnf.app.music.util.PropertiesUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport {
	private static final long serialVersionUID = -5593645472644145661L;

	protected Integer total = 0;
	
	protected Integer pageNo = 1;
	
	protected Integer pageSize = 10;
		
	protected String msg = "操作失败!";
	
	protected Map<String, Object> map = new HashMap<String,Object>();

	@Override
	public String execute() throws Exception {		
		return super.execute();
	}
	
	public HttpServletResponse getHttpResponse(){
		return ServletActionContext.getResponse();
	}
	
	public HttpServletRequest getHttpRequest(){
		return ServletActionContext.getRequest();
	}
	
	public HttpSession getHttpSession(){
		return ServletActionContext.getRequest().getSession();
	}
	
	public Map<String, Object> getSession(){
		return ActionContext.getContext().getSession();
	}
	
	public ActionContext getContext(){
		return ServletActionContext.getContext();
	}
	
	public void putValue(String key, Object value){
		ServletActionContext.getContext().put(key, value);
	}
	
	public String getParameter(String name){
		return ServletActionContext.getRequest().getParameter(name);
	}
	
	public String getBasePath(){
		return ServletActionContext.getServletContext().getRealPath("/");
	}
	
	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	/**
	 * 文件相关处理
	 * @param fileName 
	 * @param imgFile
	 * @return
	 * @throws FileNotFoundException
	 * @throws Exception
	 * @throws IOException
	 */
	protected String processFile(String fileName, File imgFile, String baseDir)
			throws FileNotFoundException, Exception, IOException {
		//获取专辑图片存放目录
		String relativePath = PropertiesUtil.readValue(Constants.UPOAD_DIR)
				+ PropertiesUtil.readValue(baseDir);
		String savePath = getBasePath() + relativePath;
		File dir = new File(savePath);
		if(!dir.exists()) {
			dir.mkdirs();
		}
	
		//保存图片
		String uuid = UUID.randomUUID().toString();
		String imgName = uuid + fileName.substring(fileName.lastIndexOf("."));
		FileOutputStream fos = new FileOutputStream(savePath + imgName);
		FileInputStream fis = new FileInputStream(imgFile);
		byte[] buffer = new byte[1024];
		int len = 0;
		while ((len = fis.read(buffer)) > 0) {
		    fos.write(buffer, 0, len);
		}
		fis.close();
		fos.close();
		return (relativePath + imgName);
	}

}