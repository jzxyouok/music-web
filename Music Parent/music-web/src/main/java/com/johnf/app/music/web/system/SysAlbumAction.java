package com.johnf.app.music.web.system;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.AlbumForm;
import com.johnf.app.music.service.AlbumService;
import com.johnf.app.music.service.SongService;
import com.johnf.app.music.service.SysDicService;
import com.johnf.app.music.util.Constants;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.AlbumVo;
import com.johnf.app.music.vo.SysDicVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings(value={"rawtypes"})
public class SysAlbumAction extends BaseAction implements ModelDriven<AlbumForm> {
	private static final long serialVersionUID = -847060230130029325L;	
	
	private AlbumService albumService;			
	private SysDicService sysDicService;
	private SongService songService;
	
	private AlbumForm albumForm;	
	
	private File big; // 上传的文件
    private String bigFileName; // 文件名称
	
	/**
	 * 列表
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		try {
			AlbumVo vo = new AlbumVo();
			BeanUtils.copyProperties(albumForm, vo);
			
			//设置分页包装类
			long totalRecords = albumService.count(vo);
			PageBean pageBean = new PageBean(totalRecords, pageSize+"", pageNo+"");		
			List voList = albumService.listByPage(vo, pageNo, pageSize);
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
		List<SysDicVo> albumTypeList = sysDicService.list("SINGER_TYPE", "and [value] is not null");
		putValue("albumTypeList", albumTypeList);
		return "add";
	}
	
	/**
	 * 添加
	 * @throws Exception
	 */
	public String add() throws Exception {
		try {
			AlbumVo vo = new AlbumVo();
	        BeanUtils.copyProperties(albumForm, vo);
	        vo.setIsValid("1");
	        vo.setId(UUID.randomUUID().toString());
	        albumService.insert(vo);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
        return SUCCESS;
	}
	
	/**
	 * 添加(ajax方式)
	 * @throws Exception
	 */
	public String addAjax() throws Exception {
		try {
			AlbumVo vo = new AlbumVo();
	        BeanUtils.copyProperties(albumForm, vo);
	        vo.setIsValid("1");
	        vo.setId(UUID.randomUUID().toString());
	        albumService.insert(vo);
	        
	        PrintWriter out = getHttpResponse().getWriter();
	        out.write("success");
	        out.flush();
	        out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
        
        return null;
	}
	
	/**
	 * 进入编辑页面
	 * @return
	 */
	public String toUpdate() throws Exception {
		try {
			//查询专辑信息
			AlbumVo vo = albumService.find(albumForm.getId());
			putValue("vo", vo);
			//查询专辑类别信息
			//List<SysDicVo> albumTypeList = sysDicService.list("SINGER_TYPE", "and [value] is not null");
			//putValue("albumTypeList", albumTypeList);
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
			AlbumVo vo = new AlbumVo();
	        BeanUtils.copyProperties(albumForm, vo);
	        if(big != null) {
	        	String image = processFile(bigFileName, big, Constants.ALBUM_LOGO_DIR);
	        	vo.setImage(image);
	        }
	        albumService.update(vo);
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
			if(StringTools.isEmptyOrNull(albumForm.getId())) {
				return INPUT;
			}
			albumService.updateState(albumForm.getId(), "0");
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
	 * 查看专辑详情
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		try {
			//查询专辑信息
			AlbumVo vo = albumService.find(albumForm.getId());
			putValue("vo", vo);
			//查询专辑下的歌曲列表
			List songList = songService.list("where a.isValid=1 and id in (select songId from album_song where albumId='"+albumForm.getId()+"')");
			putValue("songList", songList);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "view";
	}
	
	@Override
	public AlbumForm getModel() {
		if(albumForm == null) {
			albumForm = new AlbumForm();
		}
		return albumForm;
	}

	public AlbumForm getAlbumForm() {
		return albumForm;
	}

	public void setAlbumForm(AlbumForm albumForm) {
		this.albumForm = albumForm;
	}

	public void setAlbumService(AlbumService albumService) {
		this.albumService = albumService;
	}

	public SysDicService getSysDicService() {
		return sysDicService;
	}

	public void setSysDicService(SysDicService sysDicService) {
		this.sysDicService = sysDicService;
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

	public void setSongService(SongService songService) {
		this.songService = songService;
	}
	
}