package com.johnf.app.music.web.app;

import java.util.List;

import com.johnf.app.music.service.AlbumService;
import com.johnf.app.music.service.SingerService;
import com.johnf.app.music.service.SongListingService;
import com.johnf.app.music.service.SongService;
import com.johnf.app.music.vo.AlbumVo;
import com.johnf.app.music.vo.SingerVo;
import com.johnf.app.music.vo.SongListingVo;
import com.johnf.app.music.vo.SongVo;
import com.johnf.app.music.web.common.BaseAction;

/**
 * 前台首页Action
 * @author xuxc
 */
@SuppressWarnings(value={"rawtypes","unchecked"})
public class IndexAction extends BaseAction {
	private static final long serialVersionUID = -3994797377680219969L;

	private SongListingService songListingService;
	private AlbumService albumService;
	private SongService songService;
	private SingerService singerService;
	
	/**
	 * 前台首页
	 * @return
	 * @throws Exception
	 */
	public String index() throws Exception {
		try {
			//查询最热门的指定数目的歌单
			int playListToGet = 8;
			SongListingVo tmpListingVo = new SongListingVo();
			tmpListingVo.setOrderBy("order by playCount desc");		
			List songListing = 
					songListingService.listByPage(tmpListingVo, 1, playListToGet);
		
			//查询指定数目的热门专辑
			int albumToGet = 10;
			AlbumVo tmpAlbumVo = new AlbumVo();
			tmpAlbumVo.setOrderBy("order by playCount desc");
			List albumList = albumService.listByPage(tmpAlbumVo, 1, albumToGet);
			
			//查询指定数目歌曲的热歌榜
			int songsForHotToGet = 10;
			SongVo tmpSongVo = new SongVo(); 
			tmpSongVo.setOrderBy("order by playCount desc");
			List<SongVo> hotSongList = songService.listByPage(tmpSongVo, 1, songsForHotToGet);
			
			//查询指定数目歌曲的新歌榜
			int songsForNewToGet = 10;
			tmpSongVo.setOrderBy("left join ("
					+" select al.publishDate, als.songId from album al, album_song als where al.id=als.albumId "
					+" )b on b.songId=a.id order by b.publishDate desc");
			List<SongVo> newSongList = songService.listByPage(tmpSongVo, 1, songsForNewToGet);
			
			//查询指定数目的歌手
			int singersToGet = 10;
			List singerList = singerService.listByPage(new SingerVo(), 1, singersToGet);
			
			//将数据放入request
			putValue("songListing", songListing);
			putValue("albumList", albumList);
			putValue("hotSongList", hotSongList);
			putValue("newSongList", newSongList);
			putValue("singerList", singerList);
		} catch(Exception e) {
			e.printStackTrace();
			return "exceptions";
		}
		
		return SUCCESS;
	}

	public void setSongListingService(SongListingService songListingService) {
		this.songListingService = songListingService;
	}

	public void setAlbumService(AlbumService albumService) {
		this.albumService = albumService;
	}

	public void setSongService(SongService songService) {
		this.songService = songService;
	}

	public void setSingerService(SingerService singerService) {
		this.singerService = singerService;
	}
	
}