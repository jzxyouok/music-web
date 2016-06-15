package com.johnf.app.music.web.app;

import java.util.List;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.AlbumForm;
import com.johnf.app.music.service.AlbumService;
import com.johnf.app.music.service.RemarkService;
import com.johnf.app.music.service.SongService;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.vo.AlbumVo;
import com.johnf.app.music.vo.RemarkVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 前台专辑相关Action
 * @author JohnFNash
 *
 */
@SuppressWarnings(value={"rawtypes","unchecked"})
public class AlbumAction extends BaseAction implements ModelDriven<AlbumForm> {
	private static final long serialVersionUID = -3216038869726943080L;
	
	private AlbumService albumService;	
	private SongService songService;
	private RemarkService remarkService;
	
	private AlbumForm albumForm;
	
	/**
	 * 专辑列表逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		//加载热碟
		AlbumVo tmpAlbumVo = new AlbumVo();
		BeanUtils.copyProperties(albumForm, tmpAlbumVo);
		tmpAlbumVo.setIsValid("1");
		tmpAlbumVo.setOrderBy("order by playCount desc");
		List hotAlbumList = albumService.listByPage(tmpAlbumVo, 1, 10);
		putValue("hotAlbumList", hotAlbumList);
		
		//获取总记录数
		long totalRecords = albumService.count(tmpAlbumVo);
		//设置分页包装类
		final int defaultNum = 20;	//默认的加载的记录的数目
		PageBean pageBean = 
				new PageBean(totalRecords, pageSize<=0 ? defaultNum + "" : pageSize+"", 
						pageNo<=0 ? "1" : pageNo+"");
		List<AlbumVo> albumList = 
				albumService.listByPage(tmpAlbumVo, pageBean.getCurPage(), pageBean.getPageSize());
		pageBean.setDataList(albumList);
		putValue("pageBean", pageBean);
		
		return "list";
	}
	
	/**
	 * 专辑列表逻辑方法(搜索结果)
	 * @return
	 * @throws Exception
	 */
	public String listForSearch() throws Exception {
		//加载热碟
		AlbumVo tmpAlbumVo = new AlbumVo();
		BeanUtils.copyProperties(albumForm, tmpAlbumVo);
		tmpAlbumVo.setIsValid("1");
		tmpAlbumVo.setOrderBy("order by playCount desc");
		
		//获取总记录数
		long totalRecords = albumService.count(tmpAlbumVo);
		//设置分页包装类
		final int defaultNum = 10;	//默认的加载的记录的数目
		PageBean pageBean = 
				new PageBean(totalRecords, pageSize<=0 ? defaultNum + "" : pageSize+"", 
						pageNo<=0 ? "1" : pageNo+"");
		List<AlbumVo> albumList = 
				albumService.listByPage(tmpAlbumVo, pageBean.getCurPage(), pageBean.getPageSize());
		pageBean.setDataList(albumList);
		putValue("pageBean", pageBean);
		
		return "listForSearch";
	}
	
	/**
	 * 专辑详情逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		//查询对应的专辑
		AlbumVo vo = albumService.find(albumForm.getId());
		putValue("vo", vo);
		
		//加载专辑中的歌曲
		List songList = songService.list("where isValid=1 and id in "
				+ "(select songId from album_song where albumId='"+vo.getId()+"')");
		putValue("songList", songList);
		
		/* 分页查询专辑的评论 */
		//设置分页包装类
		final int defaultNum = 8;	//默认的加载的记录的数目
		RemarkVo remarkVo = new RemarkVo();
		remarkVo.setType("2");
		remarkVo.setProjectId(albumForm.getId());
		long totalRecords = remarkService.count(remarkVo); 
		PageBean pageBean = 
				new PageBean(totalRecords, pageSize<=0 ? defaultNum + "" : pageSize+"", 
						pageNo<=0 ? "1" : pageNo+"");
		List<RemarkVo> remarkList = 
				remarkService.listByPage(remarkVo, pageBean.getCurPage(), pageBean.getPageSize());		
		pageBean.setDataList(remarkList);
		//将pageBean放入request
		putValue("pageBean", pageBean);
		
		//加载该歌手的其他专辑
		String firstSingerId = (vo.getSingerInfo().split(" "))[0].split(",")[0];
		List otherAlbumList = albumService.list("where isValid=1 and id!='"+albumForm.getId()+"'"
				+ " and id in (select albumId from album_singer where singerId='"+firstSingerId+"')");				
		putValue("otherAlbumList", otherAlbumList);
		
		return "view";
	}
	
	@Override
	public AlbumForm getModel() {
		if(albumForm == null) {
			albumForm = new AlbumForm();
		}
		return albumForm;
	}

	public void setAlbumService(AlbumService albumService) {
		this.albumService = albumService;
	}

	public AlbumForm getAlbumForm() {
		return albumForm;
	}

	public void setAlbumForm(AlbumForm albumForm) {
		this.albumForm = albumForm;
	}

	public void setSongService(SongService songService) {
		this.songService = songService;
	}

	public void setRemarkService(RemarkService remarkService) {
		this.remarkService = remarkService;
	}
	
}
