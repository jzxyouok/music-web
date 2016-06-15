package com.johnf.app.music.web.common;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.johnf.app.music.util.Constants;
import com.johnf.app.music.util.DateTools;
import com.johnf.app.music.util.PropertiesUtil;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.UserVo;

/**
 * jquery ajax批量上传文件Action
 */
public class UploadifyAction extends BaseAction {
	private static final long serialVersionUID = 2484696021315216621L;

	private File fileupload;
	private String fileuploadFileName;
	
	/**
	 * 上传专辑图片
	 * @return
	 */
	public String uploadAlbumImages() {
		try {
			HttpServletRequest  request = getHttpRequest();
			HttpServletResponse response  = getHttpResponse();
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			
			UserVo userVo = (UserVo) getSession().get("userInfo");
			if(null==userVo){
				response.getWriter().print("请重新登录！");// 向页面端返回结果信息
			} else {
				if(null != this.getFileupload()){
					String fileName = "";
					if(!StringTools.isEmptyOrNull(getFileuploadFileName())){
						int index = getFileuploadFileName().lastIndexOf(".");
						fileName = DateTools.getCurrentDate("yyyyMMddHHmmssSSS")+getFileuploadFileName().substring(index);
						String dir = PropertiesUtil.readValue(Constants.UPOAD_DIR) 
								+ PropertiesUtil.readValue(Constants.ALBUM_LOGO_DIR);
						String filePath = ServletActionContext.getServletContext().getRealPath(dir);
						File savedir = new File(filePath);
						if (!savedir.exists())
							savedir.mkdirs();
						File savefile = new File(savedir, fileName);
						FileUtils.copyFile(getFileupload(), savefile);
						
						// 向页面端返回结果信息
						response.getWriter().write(getFileuploadFileName()+"上传成功！:"
								+ (dir + fileName));
						response.getWriter().close();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
        return null;
	}

	public File getFileupload() {
		return fileupload;
	}

	public void setFileupload(File fileupload) {
		this.fileupload = fileupload;
	}

	public String getFileuploadFileName() {
		return fileuploadFileName;
	}

	public void setFileuploadFileName(String fileuploadFileName) {
		this.fileuploadFileName = fileuploadFileName;
	}
	
}
