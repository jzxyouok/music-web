package com.johnf.app.music.web.app;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.SongForm;
import com.johnf.app.music.service.RemarkService;
import com.johnf.app.music.service.SongService;
import com.johnf.app.music.service.UserService;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.vo.RemarkVo;
import com.johnf.app.music.vo.SongVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 前台歌曲相关Action
 * @author JohnFNash
 */
@SuppressWarnings(value={"rawtypes","unchecked"})
public class SongAction extends BaseAction implements ModelDriven<SongForm> {
	private static final long serialVersionUID = 7917103429652599015L;

	private SongService songService;
	private UserService userService;
	private RemarkService remarkService;
	
	private SongForm songForm;
	
	/**
	 * 列表
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		try {
			SongVo vo = new SongVo();
			BeanUtils.copyProperties(songForm, vo);
			
			//设置分页包装类
			long totalRecords = songService.count(vo);
			PageBean pageBean = new PageBean(totalRecords, pageSize+"", pageNo+"");		
			List voList = songService.listByPage(vo, pageBean.getCurPage(), pageBean.getPageSize());
			pageBean.setDataList(voList);
			putValue("pageBean", pageBean);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		
		return "list";
	}
	
	/**
	 * 歌曲详情
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		try {
			//查询歌手信息
			SongVo vo = songService.find(songForm.getId());
			putValue("vo", vo);
			
			//查询歌曲的歌词信息
			//Map<String, Object> lyricMap = songService.getLyricForSong(song.getSongId());
			String lyricRealPath = getBasePath() + vo.getLyric();
			List<String> lyricStr = new ArrayList<String>();
			try {
				BufferedReader bfr = 
					new BufferedReader(new InputStreamReader(new FileInputStream(lyricRealPath),"utf-8"));		
				String line;
				while( (line = bfr.readLine()) != null) {
					int index = line.indexOf("]");
					if(index == -1) {//该行没有歌词
						continue;
					}
					lyricStr.add(line.substring(index+1));		
				}		
				bfr.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
			putValue("lyric", lyricStr);
			
			//查询收藏过该歌曲的用户
			List userList = userService.listByPage(" and id in "
					+ "(select userId from song_listing where id in "
					+ "		(select listingId from listing_song where songId='"+songForm.getId()+"') )", 1, 8);
			putValue("userList", userList);
			
			//查询歌曲的评论
			//设置分页包装类
			final int defaultNum = 8;	//默认的加载的记录的数目
			RemarkVo remarkVo = new RemarkVo();
			remarkVo.setType("1");
			remarkVo.setProjectId(songForm.getId());
			long totalRecords =  remarkService.count(remarkVo);
			PageBean pageBean = 
					new PageBean(totalRecords, pageSize<=0 ? defaultNum + "" : pageSize+"", 
							pageNo<=0 ? 1+"" : pageNo+"");
			List<RemarkVo> remarkList = 
					remarkService.listByPage(remarkVo, pageBean.getCurPage(), pageBean.getPageSize());		
			pageBean.setDataList(remarkList);
			//将pageBean放入request
			putValue("pageBean", pageBean);

		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
				
		return "view";
	}	

	/**
	 * 热歌榜
	 * @return
	 */
	public String ranking() {
		try {
			String type = getParameter("type");
			putValue("type", type);
			
			int songsToGet = 50;
			SongVo tmpSongVo = new SongVo(); 
			if("hot".equals(type)) {
				//查询指定数目歌曲的热歌榜
				tmpSongVo.setOrderBy("order by playCount desc");
				List<SongVo> hotSongList = songService.listByPage(tmpSongVo, 1, songsToGet);
				putValue("songList", hotSongList);
			} else {
				//查询指定数目歌曲的新歌榜
				tmpSongVo.setOrderBy("left join ("
						+" select al.publishDate, als.songId from album al, album_song als where al.id=als.albumId "
						+" )b on b.songId=a.id order by b.publishDate desc");
				List<SongVo> newSongList = songService.listByPage(tmpSongVo, 1, songsToGet);
				putValue("songList", newSongList);
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "ranking";
	}
	
	/**
	 * 加载歌曲资源
	 * @return
	 * @throws Exception
	 */
	public String loadSongRes() throws Exception {
		try {
			//查询歌曲信息
			SongVo song = songService.find(songForm.getId());
			//获取歌曲资源json字符串
			String songResJson = songResToJson(song);
			
			PrintWriter out =  ServletActionContext.getResponse().getWriter();
			out.write(songResJson);
			out.flush();
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 将歌曲歌词信息、音频url转化为json字符串
	 * @param song 歌曲
	 * @return
	 * @throws IOException 
	 */
	private String songResToJson(SongVo song) throws IOException {
		//读取歌词文件
		StringBuffer lyricSb = new StringBuffer();
		String filePath = getBasePath() + "/" + song.getLyric();
		File lyricFile = new File(filePath);
		if(lyricFile.exists()) {//如果歌词文件存在
			BufferedReader bfr = new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"UTF-8"));
			String line = "";
			while( (line = bfr.readLine()) != null) {
				line = line.trim();
				if(line.length() > 0) {//如果不是空行
					lyricSb.append(line);
					lyricSb.append(";");
				}
			}
			bfr.close();
		}
		
		//获取音频的url
		String audioPath = getHttpRequest().getScheme() + "://" + getHttpRequest().getServerName() + ":" 
			+ getHttpRequest().getServerPort() + getHttpRequest().getContextPath() 
			+ "/" + song.getAudio();
		
		return lyricSb.toString() + "@" + audioPath;		
	}
	
	@Override
	public SongForm getModel() {
		if(songForm == null) {
			songForm = new SongForm();
		}
		return songForm;
	}

	public SongForm getSongForm() {
		return songForm;
	}

	public void setSongForm(SongForm songForm) {
		this.songForm = songForm;
	}

	public void setSongService(SongService songService) {
		this.songService = songService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setRemarkService(RemarkService remarkService) {
		this.remarkService = remarkService;
	}
	
}
