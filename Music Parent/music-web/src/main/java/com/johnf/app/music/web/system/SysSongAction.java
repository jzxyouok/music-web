package com.johnf.app.music.web.system;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.SongForm;
import com.johnf.app.music.service.SongService;
import com.johnf.app.music.util.Constants;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.SongVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings(value={"rawtypes"})
public class SysSongAction extends BaseAction implements ModelDriven<SongForm> {
	private static final long serialVersionUID = -847060230130029325L;	
	
	private SongService songService;			
	//private SysDicService sysDicService;
	
	private SongForm songForm;	
	
	private File big; // 音频文件
	private String bigFileName; // 音频文件名称
	private File small; // 歌词文件
	private String smallFileName; // 歌词文件名称
	
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
			List voList = songService.listByPage(vo, pageNo, pageSize);
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
		SongVo vo = new SongVo();
        BeanUtils.copyProperties(songForm, vo);
     
        String audioPath = processFile(bigFileName, big, Constants.AUDIO_DIR);
        vo.setAudio(audioPath);
        
        String lyricPath = processFile(smallFileName, small, Constants.LYRIC_DIR);
        vo.setLyric(lyricPath);
    	
        //构造Song对象，并添加至数据库
    	vo.setIsValid("1");
        vo.setId(UUID.randomUUID().toString());
        songService.insert(vo);
        
        return SUCCESS;
	}
	
	/**
	 * 进入编辑页面
	 * @return
	 */
	public String toUpdate() throws Exception {
		try {
			//查询歌手信息
			SongVo vo = songService.find(songForm.getId());
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
			SongVo vo = new SongVo();
	        BeanUtils.copyProperties(songForm, vo);
	        if(big != null) {
	        	String audioPath = processFile(bigFileName, big, Constants.AUDIO_DIR);
	            vo.setAudio(audioPath);
	        }
	        if(small != null) {
	        	String lyricPath = processFile(smallFileName, small, Constants.LYRIC_DIR);
	            vo.setLyric(lyricPath);
	        }
	        songService.update(vo);
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
			if(StringTools.isEmptyOrNull(songForm.getId())) {
				return INPUT;
			}
			songService.updateState(songForm.getId(), "0");
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
			getHttpRequest().setAttribute("lyric", lyricStr);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "view";
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

	public SongService getSongService() {
		return songService;
	}

}