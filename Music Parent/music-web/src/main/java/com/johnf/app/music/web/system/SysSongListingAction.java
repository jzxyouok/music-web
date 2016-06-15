package com.johnf.app.music.web.system;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.SongListingForm;
import com.johnf.app.music.service.SongListingService;
import com.johnf.app.music.util.Constants;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.SongListingVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings(value={"rawtypes"})
public class SysSongListingAction extends BaseAction implements ModelDriven<SongListingForm> {
	private static final long serialVersionUID = -847060230130029325L;	
	
	private SongListingService songListingService;			
	
	private SongListingForm songListingForm;	
	
	private File big; // 上传的文件
    private String bigFileName; // 文件名称
	
	/**
	 * 列表
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		try {
			SongListingVo vo = new SongListingVo();
			BeanUtils.copyProperties(songListingForm, vo);
			
			//设置分页包装类
			long totalRecords = songListingService.count(vo);
			PageBean pageBean = new PageBean(totalRecords, pageSize+"", pageNo+"");		
			List voList = songListingService.listByPage(vo, pageNo, pageSize);
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
		SongListingVo vo = new SongListingVo();
        BeanUtils.copyProperties(songListingForm, vo);
        
        String bigImg = "";   
        if(big != null) {
        	bigImg = processFile(bigFileName, big, Constants.SONGLISTING_LOGO_DIR);
        }
        vo.setImage(bigImg);
        vo.setIsValid("1");
        vo.setId(UUID.randomUUID().toString());
        songListingService.insert(vo);
        return SUCCESS;
	}
	
	/**
	 * 进入编辑页面
	 * @return
	 */
	public String toUpdate() throws Exception {
		try {
			//查询歌单信息
			SongListingVo vo = songListingService.find(songListingForm.getId());
			putValue("vo", vo);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "update";
	}
	
	/**
	 * 更新
	 * @return
	 * @throws Exception
	 */
	public String update() throws Exception {
		try {
			SongListingVo vo = new SongListingVo();
	        BeanUtils.copyProperties(songListingForm, vo);
	        
	        if(big != null) {
	        	String bigImg = processFile(bigFileName, big, Constants.SONGLISTING_LOGO_DIR);
	        	vo.setImage(bigImg);
	        }
	        
	        songListingService.update(vo);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		
		return SUCCESS;
	}
	
	/**
	 * 移除用户
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception {
		try {
			if(StringTools.isEmptyOrNull(songListingForm.getId())) {
				return INPUT;
			}
			songListingService.updateState(songListingForm.getId(), "0");
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
	
	/**
	 * 查看歌单详情
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		try {
			//查询歌单信息
			SongListingVo vo = songListingService.find(songListingForm.getId());
			putValue("vo", vo);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "view";
	}
	
	@Override
	public SongListingForm getModel() {
		if(songListingForm == null) {
			songListingForm = new SongListingForm();
		}
		return songListingForm;
	}

	public SongListingForm getSongListingForm() {
		return songListingForm;
	}

	public void setSongListingForm(SongListingForm songListingForm) {
		this.songListingForm = songListingForm;
	}

	public void setSongListingService(SongListingService songListingService) {
		this.songListingService = songListingService;
	}

	public File getBig() {
		return big;
	}

	public void setBig(File big) {
		this.big = big;
	}

	public String getBigFileName() {
		return bigFileName;
	}

	public void setBigFileName(String bigFileName) {
		this.bigFileName = bigFileName;
	}

}