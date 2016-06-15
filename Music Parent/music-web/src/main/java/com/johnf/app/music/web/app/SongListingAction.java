package com.johnf.app.music.web.app;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.BeanUtils;

import com.johnf.app.music.form.SongListingForm;
import com.johnf.app.music.service.ListingCollectionService;
import com.johnf.app.music.service.ListingSongService;
import com.johnf.app.music.service.RemarkService;
import com.johnf.app.music.service.SongListingService;
import com.johnf.app.music.service.SongService;
import com.johnf.app.music.service.SysDicService;
import com.johnf.app.music.service.UserService;
import com.johnf.app.music.util.Constants;
import com.johnf.app.music.util.DateTools;
import com.johnf.app.music.util.PageBean;
import com.johnf.app.music.util.StringTools;
import com.johnf.app.music.vo.ListingCollectionVo;
import com.johnf.app.music.vo.ListingSongVo;
import com.johnf.app.music.vo.RemarkVo;
import com.johnf.app.music.vo.SongListingVo;
import com.johnf.app.music.vo.UserVo;
import com.johnf.app.music.web.common.BaseAction;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 前台歌单相关列表
 * @author JohnFNash
 */
@SuppressWarnings(value={"unchecked","rawtypes"})
public class SongListingAction extends BaseAction implements ModelDriven<SongListingForm> {
	private static final long serialVersionUID = 6063634910292085687L;

	private SongListingService songListingService;
	private SysDicService sysDicService;
	private SongService songService;
	private RemarkService remarkService;
	private UserService userService;
	private ListingSongService listingSongService;
	private ListingCollectionService listingCollectionService;
	
	private SongListingForm songListingForm;
	
	private File image; // 上传的文件
    private String imageFileName; // 文件名称
    private String savePath;
	
	/**
	 * 歌单列表逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		//设置分页包装类
		final int defaultNum = 20;	//默认的加载的记录的数目
		SongListingVo vo = new SongListingVo();
		BeanUtils.copyProperties(songListingForm, vo);
		
		//查询歌单列表
		long totalRecords = songListingService.count(vo); 		
		PageBean pageBean = 
				new PageBean(totalRecords, getParameter("pageSize")==null ? 
						defaultNum + "" : getParameter("pageSize"), getParameter("curPage"));
		List<SongListingVo> listingList = 
				songListingService.listByPage(vo, pageBean.getCurPage(), pageBean.getPageSize());		
		pageBean.setDataList(listingList);
		putValue("pageBean", pageBean);				
		
		//查询歌单语种数据字典列表
		List languageList = sysDicService.list("LISTING_LANGUAGE_TYPE", "");
		putValue("languageList", languageList);
		
		//查询歌单语种数据字典列表
		List styleList = sysDicService.list("LISTING_STYLE_TYPE", "");
		putValue("styleList", styleList);
		
		return "list";
	}
	
	/**
	 * 歌单列表逻辑方法(搜索结果)
	 * @return
	 * @throws Exception
	 */
	public String listForSearch() throws Exception {
		//设置分页包装类
		final int defaultNum = 10;	//默认的加载的记录的数目
		SongListingVo vo = new SongListingVo();
		BeanUtils.copyProperties(songListingForm, vo);
		
		//查询歌单列表
		long totalRecords = songListingService.count(vo); 		
		PageBean pageBean = 
				new PageBean(totalRecords, getParameter("pageSize")==null ? 
						defaultNum + "" : getParameter("pageSize"), getParameter("curPage"));
		List<SongListingVo> listingList = 
				songListingService.listByPage(vo, pageBean.getCurPage(), pageBean.getPageSize());		
		pageBean.setDataList(listingList);
		putValue("pageBean", pageBean);				
		
		return "listForSearch";
	}
	
	/**
	 * 查看
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		//查询歌单信息
		SongListingVo vo = songListingService.find(songListingForm.getId());
		putValue("vo", vo);
		
		//分页查询歌单中的歌曲
		List songList = 
				songService.list(" where a.id in (select songId from listing_song where listingId='"
						+songListingForm.getId()+"')");
		putValue("songList", songList);
		
		/* 分页查询歌单的评论 */
		//设置分页包装类
		final int defaultNum = 8;	//默认的加载的记录的数目
		RemarkVo paramVo = new RemarkVo();
		paramVo.setType("3");// 评论类型，1 歌曲评论，2 专辑评论，3 歌单评论
		paramVo.setProjectId(songListingForm.getId());
		paramVo.setIsValid("1");
		long totalRecords = remarkService.count(paramVo); 
		PageBean pageBean = 
				new PageBean(totalRecords, pageSize==null ? defaultNum + "" : pageSize+"", pageNo+"");
		List<RemarkVo> remarkList = 
				remarkService.listByPage(paramVo, pageBean.getCurPage(), pageBean.getPageSize());		
		pageBean.setDataList(remarkList);
		//将pageBean放入request
		putValue("pageBean", pageBean);
		
		//查询收藏了该歌单的用户列表
		List<UserVo> userList = 
				userService.listByPage("and id in (select userId from listing_collection where listingId='"+songListingForm.getId()+"')", 1, 8);
		putValue("userList", userList);
		
		return "view";
	}
	
	/**
	 * 查看(用户)
	 * @return
	 * @throws Exception
	 */
	public String viewForUser() throws Exception {
		//查询歌单信息
		SongListingVo vo = songListingService.find(songListingForm.getId());
		putValue("vo", vo);
		
		//分页查询歌单中的歌曲
		List songList = 
				songService.list(" where a.id in (select songId from listing_song where listingId='"
						+songListingForm.getId()+"')");
		putValue("songList", songList);
		
		return "viewForUser";
	}
	
	/**
	 * 加载当前用户创建的歌单列表
	 * @return
	 * @throws Exception
	 */
	public String loadListing() throws Exception {
		//获取当前登录的用户
		UserVo userLogined = (UserVo) getSession().get("userInfo");
		//查询用户创建的歌单列表
		List<SongListingVo> songListings =
				songListingService.list("where isValid='1' and userId='"+userLogined.getId()+"'");
		//将歌单json字符串写入
		PrintWriter out = getHttpResponse().getWriter();
		out.write(getSongListingStr(songListings));
		out.flush();
		out.close();
		return null;
	}
	
	/**
	 * 获取歌单的json字符串
	 * @param songListings
	 * @return
	 */
	private String getSongListingStr(List<SongListingVo> songListings) {
		StringBuffer sb = new StringBuffer();
		sb.append("[");
		for(SongListingVo songListing : songListings) {						
			sb.append("{");
			sb.append("\"id\":\"" + songListing.getId() + "\",");
			sb.append("\"name\":\"" + songListing.getName() + "\",");
			sb.append("\"image\":\"" + songListing.getImage() + "\",");
			sb.append("\"songsInListing\":" + songListing.getSongsInListing());
			sb.append("},");
		}
		sb.append("]");
		if(sb.length() > 2) {//如果歌单数目不为0，去掉多余的","
			sb = sb.replace(sb.length()-2, sb.length()-1, "");
		}				
		return sb.toString();	
	}

	/**
	 * 添加歌曲到歌单中
	 * @return
	 * @throws Exception
	 */
	public String addSongToListing() throws Exception {
		try {
			//创建歌单歌曲项，并存入数据库
			String songId = getParameter("songId");
			String listingId = getParameter("id");
			ListingSongVo vo = new ListingSongVo();
			vo.setId(UUID.randomUUID().toString());
			vo.setListingId(listingId);
			vo.setSongId(songId);
			listingSongService.insert(vo);
			
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
	 * 收藏歌曲到新建的歌单
	 * @return
	 * @throws Exception
	 */
	public String addListing() throws Exception {
		try {
			//获取传入的要收藏的歌曲的编号
			String songIdStr = getParameter("id");
			if(songIdStr == null || "".equals(songIdStr)) {//未输入要收藏的歌曲编号
				return null;
			}
			//获取传入的歌单名
			String listingName = getParameter("name");
			
			//获取当前登录的用户
			UserVo userLogined = (UserVo) getHttpSession().getAttribute("userInfo");
			//构造SongListing
			SongListingVo songListing = new SongListingVo();
			songListing.setId(UUID.randomUUID().toString());
			songListing.setIsValid("1");
			songListing.setName(listingName);
			songListing.setCreateDate(DateTools.getCurrentDate("yyyy-MM-dd"));
			songListing.setUserId(userLogined.getId());
			songListing.setImage("images/listing/default_songlisting.png");
			songListingService.insert(songListing);
			//构造 ListingSong
			ListingSongVo listingSong = new ListingSongVo();
			listingSong.setId(UUID.randomUUID().toString());
			listingSong.setListingId(songListing.getId());
			listingSong.setSongId(songIdStr);
			listingSongService.insert(listingSong);
			
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
	 * 收藏歌单逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String collect() throws Exception {
		try {
			UserVo userLogined = (UserVo) getHttpSession().getAttribute("userInfo");
			String listingId = getParameter("listingId");
			
			SongListingVo vo = songListingService.find(listingId);
			if(vo!=null && !vo.getUserId().equals(userLogined.getId())) {
				ListingCollectionVo listingCollection = new ListingCollectionVo();
				listingCollection.setId(UUID.randomUUID().toString());
				listingCollection.setListingId(listingId);
				listingCollection.setUserId(userLogined.getId());
				listingCollectionService.insert(listingCollection);
				
				PrintWriter out = getHttpResponse().getWriter();
				out.write("success");
				out.flush();
				out.close();
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 修改
	 * @return
	 * @throws Exception
	 */
	public String toUpdate() throws Exception {
		try {
			//查询歌单基本信息
			SongListingVo vo = songListingService.find(songListingForm.getId());
			putValue("listing", vo);
			
			//查询歌单语种数据字典列表
			List languageList = sysDicService.list("LISTING_LANGUAGE_TYPE", "");
			putValue("languageList", languageList);
			
			//查询歌单语种数据字典列表
			List styleList = sysDicService.list("LISTING_STYLE_TYPE", "");
			putValue("styleList", styleList);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		return "update";
	}
	
	/**
     * 编辑歌单逻辑方法
     * @return
     * @throws Exception
     */
	public String editListing() throws Exception {
		SongListingVo vo = songListingService.find(songListingForm.getId());
		if(image != null) {
			String imagePath = processFile(imageFileName, image, Constants.SONGLISTING_LOGO_DIR);
        	vo.setImage(imagePath);
        }
        //设置新的歌单名，歌单描述,风格，语言信息   
        if(!StringTools.isEmptyOrNull(songListingForm.getName())) {
        	vo.setName(songListingForm.getName());
        }
        if(!StringTools.isEmptyOrNull(songListingForm.getDescription())) {
        	vo.setDescription(songListingForm.getDescription());
        }
        if(!StringTools.isEmptyOrNull(songListingForm.getLanguage())) {
        	vo.setLanguage(songListingForm.getLanguage());
        }
        if(!StringTools.isEmptyOrNull(songListingForm.getStyle())) {
        	vo.setStyle(songListingForm.getStyle());
        }
        songListingService.update(vo);
        return "editSuccess";		
	}
	
	/**
	 * 删除歌单逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception {
		try {
			songListingService.updateState(songListingForm.getId(), "0");
			
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
	 * 取消收藏歌单
	 * @return
	 * @throws IOException 
	 */
	public String cacelCollect() {
		try {
			UserVo userLogined = (UserVo) getHttpSession().getAttribute("userInfo");
			String listingId = getParameter("listingId");
			listingCollectionService.delete(listingId, userLogined.getId());
			
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
	 * 从歌单中移除歌曲逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String removeSong() throws Exception {
		try {
			UserVo userLogined = (UserVo) getHttpSession().getAttribute("userInfo");
			String listingId = getParameter("listingId");
			String songId = getParameter("songId");
					
			//查询当前登录用户是该歌单的创建者时，才能从该歌单中移除歌曲
			SongListingVo vo = songListingService.find(listingId);
			if(vo!=null && vo.getUserId().equals(userLogined.getId())) {
				//从歌单中移除歌曲
				listingSongService.delete(listingId, songId);
				
				PrintWriter out = getHttpResponse().getWriter();
				out.write("success");
				out.flush();
				out.close();
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 添加歌单逻辑方法
	 * @return
	 * @throws Exception
	 */
	public String justAdd() throws Exception {	
		try {
			//获取传入的歌单名
			String listingName = getParameter("name");
			//获取当前登录的用户
			UserVo userLogined = (UserVo) getHttpSession().getAttribute("userInfo");
			//构造SongListing
			//构造SongListing
			SongListingVo songListing = new SongListingVo();
			songListing.setId(UUID.randomUUID().toString());
			songListing.setIsValid("1");
			songListing.setName(listingName);
			songListing.setCreateDate(DateTools.getCurrentDate("yyyy-MM-dd"));
			songListing.setUserId(userLogined.getId());
			songListing.setImage("images/listing/default_songlisting.png");
			songListingService.insert(songListing);
			
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
	 * 开始搜索
	 * @return
	 * @throws Exception
	 */
	public String toSearch() throws Exception {
		//获取传入的搜索关键字
		getHttpSession().setAttribute("key", songListingForm.getKey());
		return "toSearch";
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

	public void setSysDicService(SysDicService sysDicService) {
		this.sysDicService = sysDicService;
	}

	public void setSongService(SongService songService) {
		this.songService = songService;
	}

	public void setRemarkService(RemarkService remarkService) {
		this.remarkService = remarkService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setListingSongService(ListingSongService listingSongService) {
		this.listingSongService = listingSongService;
	}

	public void setListingCollectionService(
			ListingCollectionService listingCollectionService) {
		this.listingCollectionService = listingCollectionService;
	}

	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	
}
