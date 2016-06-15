package com.johnf.app.music.web.system;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.SingerForm;
import com.johnf.app.music.service.AlbumService;
import com.johnf.app.music.service.SingerService;
import com.johnf.app.music.service.SysDicService;
import com.johnf.app.music.util.Constants;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.SingerVo;
import com.johnf.app.music.vo.SysDicVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings(value={"rawtypes"})
public class SysSingerAction extends BaseAction implements ModelDriven<SingerForm> {
	private static final long serialVersionUID = -847060230130029325L;	
	
	private SingerService singerService;			
	private SysDicService sysDicService;
	private AlbumService albumService;
	
	private SingerForm singerForm;	
	
	private File big; // 上传的文件
    private String bigFileName; // 文件名称
    private File small; // 上传的文件
    private String smallFileName; // 文件名称
	
	/**
	 * 列表
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		try {
			SingerVo vo = new SingerVo();
			BeanUtils.copyProperties(singerForm, vo);
			
			//设置分页包装类
			long totalRecords = singerService.count(vo);
			PageBean pageBean = new PageBean(totalRecords, pageSize+"", pageNo+"");		
			List voList = singerService.listByPage(vo, pageNo, pageSize);
			pageBean.setDataList(voList);
			putValue("pageBean", pageBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		
		return "list";
	}
	
	/**
	 * 进入歌手选择页面
	 * @return
	 * @throws Exception
	 */
	public String listToSelect() throws Exception {
		try {
			SingerVo vo = new SingerVo();
			BeanUtils.copyProperties(singerForm, vo);
			
			//设置分页包装类
			long totalRecords = singerService.count(vo);
			PageBean pageBean = new PageBean(totalRecords, pageSize+"", pageNo+"");		
			List voList = singerService.listByPage(vo, pageNo, pageSize);
			pageBean.setDataList(voList);
			putValue("pageBean", pageBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		
		return "listToSelect";
	}
	
	/**
	 * 进入添加页面
	 * @return
	 * @throws Exception
	 */
	public String toAdd() throws Exception {
		List<SysDicVo> singerTypeList = sysDicService.list("SINGER_TYPE", "and [value] is not null");
		putValue("singerTypeList", singerTypeList);
		return "add";
	}
	
	/**
	 * 添加
	 * @throws Exception
	 */
	public String add() throws Exception {
		SingerVo vo = new SingerVo();
        BeanUtils.copyProperties(singerForm, vo);
        
		String smallImg = "";
        String bigImg = "";   
        if(small != null) {
        	smallImg = processFile(smallFileName, small, Constants.SINGER_LOGO_DIR);
        } 
        if(big != null) {
        	bigImg = processFile(bigFileName, big, Constants.SINGER_LOGO_DIR);
        }
        vo.setSmallImg(smallImg);
        vo.setBigImg(bigImg);
        vo.setIsValid("1");
        vo.setId(UUID.randomUUID().toString());
        singerService.insert(vo);
        return SUCCESS;
	}
	
	/**
	 * 进入编辑页面
	 * @return
	 */
	public String toUpdate() throws Exception {
		try {
			//查询歌手信息
			SingerVo vo = singerService.find(singerForm.getId());
			putValue("vo", vo);
			//查询歌手类别信息
			List<SysDicVo> singerTypeList = sysDicService.list("SINGER_TYPE", "and [value] is not null");
			putValue("singerTypeList", singerTypeList);
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
			SingerVo vo = new SingerVo();
	        BeanUtils.copyProperties(singerForm, vo);
	        
	        if(small != null) {
	        	String smallImg = processFile(smallFileName, small, Constants.SINGER_LOGO_DIR);
	        	vo.setSmallImg(smallImg);
	        } 
	        if(big != null) {
	        	String bigImg = processFile(bigFileName, big, Constants.SINGER_LOGO_DIR);
	        	vo.setBigImg(bigImg);
	        }
	        
	        singerService.update(vo);
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
			if(StringTools.isEmptyOrNull(singerForm.getId())) {
				return INPUT;
			}
			singerService.updateState(singerForm.getId(), "0");
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
	 * 查看歌手详情
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		try {
			//查询歌手信息
			SingerVo vo = singerService.find(singerForm.getId());
			putValue("vo", vo);
			//查询歌手的索引专辑信息
			List albumList = albumService.list(" where id in (select albumId from album_singer "
					+ " where singerId='" + singerForm.getId() + "') ");
			putValue("albumList", albumList);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "view";
	}
	
	@Override
	public SingerForm getModel() {
		if(singerForm == null) {
			singerForm = new SingerForm();
		}
		return singerForm;
	}

	public SingerForm getSingerForm() {
		return singerForm;
	}

	public void setSingerForm(SingerForm singerForm) {
		this.singerForm = singerForm;
	}

	public void setSingerService(SingerService singerService) {
		this.singerService = singerService;
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

	public File getSmall() {
		return small;
	}

	public void setSmall(File small) {
		this.small = small;
	}

	public String getSmallFileName() {
		return smallFileName;
	}

	public void setSmallFileName(String smallFileName) {
		this.smallFileName = smallFileName;
	}

	public SysDicService getSysDicService() {
		return sysDicService;
	}

	public void setSysDicService(SysDicService sysDicService) {
		this.sysDicService = sysDicService;
	}

	public void setAlbumService(AlbumService albumService) {
		this.albumService = albumService;
	}
	
}