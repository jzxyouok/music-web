package com.johnf.app.music.web.app;

import java.util.List;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.SingerForm;
import com.johnf.app.music.service.AlbumService;
import com.johnf.app.music.service.SingerService;
import com.johnf.app.music.service.SongService;
import com.johnf.app.music.service.SysDicService;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.SingerVo;
import com.johnf.app.music.vo.SongVo;
import com.johnf.app.music.vo.SysDicVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings(value={"rawtypes","unchecked"})
public class SingerAction extends BaseAction implements ModelDriven<SingerForm> {
	private static final long serialVersionUID = 560289207881142880L;

	private SingerService singerService;
	private SongService songService;
	private AlbumService albumService;
	private SysDicService sysDicService;
	
	private SingerForm singerForm;
	
	/**
	 * 歌手信息逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		try {
			//查询歌手
			SingerVo vo = singerService.find(singerForm.getId());
			putValue("vo", vo);
			//查询与当前歌手类似的歌手
			List singerList = singerService.listByPage(" where a.isValid=1 and a.id!='"+vo.getId()+"'"
					+ " and a.category='"+vo.getCategory()+"'", pageNo, pageSize);
			putValue("singerList", singerList);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "view";
	}
	
	/**
	 * 歌手热门top50歌曲
	 * @return
	 * @throws Exception
	 */
	public String songList() throws Exception {
		//获取歌手指定数目最热单曲
		List<SongVo> songList = songService.list("where isValid=1 and id in "
				+ "(select songId from song_singer where singerId='"+singerForm.getId()+"') "
				+ "order by playCount desc", 1, 50);
		putValue("songList", songList);
		return "songList";
	}
	
	/**
	 * 歌手的所有专辑
	 * @return
	 * @throws Exception
	 */
	public String albumList() throws Exception {
		//获取歌手的全部专辑
		List albumList = albumService.list("where isValid=1 and id in "
				+ "(select albumId from album_singer where singerId='"+singerForm.getId()+"')");
		putValue("albumList", albumList);
		return "albumList";
	}
	
	/**
	 * 歌手个人信息
	 * @return
	 * @throws Exception
	 */
	public String intro() throws Exception {
		//获取歌手信息
		SingerVo singer = singerService.find(singerForm.getId());
		putValue("singer", singer);
		//获取歌手的全部专辑
		List albumList = albumService.list("where isValid=1 and id in "
				+ "(select albumId from album_singer where singerId='"+singerForm.getId()+"')");
		putValue("albumList", albumList);
		return "intro";
	}

	/**
	 * 歌手列表
	 * @return
	 */
	public String list() {
		try {
			//查询歌手类别列表
			List<SysDicVo> singerTypeList = sysDicService.list("SINGER_TYPE", null);
			putValue("singerTypeList", singerTypeList);
			//获取当前选中的类型的名称
			if(!StringTools.isEmptyOrNull(singerForm.getCategory())) {
				for(SysDicVo tmpVo : singerTypeList) {
					if(tmpVo.getValue()!=null && tmpVo.getValue().equals(singerForm.getCategory())) {
						putValue("cateName", tmpVo.getName());
						break;
					}
				}
			}
			
			int numToGet = 100;
			SingerVo tmpVo = new SingerVo();
			BeanUtils.copyProperties(singerForm, tmpVo);
			List singerList = singerService.listByPage(tmpVo, 1, numToGet);
			putValue("singerList", singerList);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "list";
	}

	/**
	 * 歌手列表(搜索页面)
	 * @return
	 */
	public String listForSearch() {
		try {
			SingerVo tmpVo = new SingerVo();
			BeanUtils.copyProperties(singerForm, tmpVo);
			long totalRecords = singerService.count(tmpVo);
			PageBean pageBean = new PageBean(totalRecords, pageSize+"", pageNo+"");		
			List voList = singerService.listByPage(tmpVo, pageBean.getCurPage(), pageBean.getPageSize());
			pageBean.setDataList(voList);
			putValue("pageBean", pageBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "listForSearch";
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

	public void setSongService(SongService songService) {
		this.songService = songService;
	}

	public void setAlbumService(AlbumService albumService) {
		this.albumService = albumService;
	}

	public void setSysDicService(SysDicService sysDicService) {
		this.sysDicService = sysDicService;
	}
	
}
