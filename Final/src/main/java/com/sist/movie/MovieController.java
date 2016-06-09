package com.sist.movie;

import java.io.File;
import java.util.*;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.data.*;
import com.sist.mapred.*;
import com.sist.mapredEmotion.EmotionDriver;
import com.sist.r.*;
import com.sist.mongo.*;
import com.sist.naver.NaverManager;
import com.sist.search.*;
@Controller
public class MovieController {
	@Autowired
	private MovieManager		mgr;
	/*@Autowired
	private MovieDriver		md;*/
	
	@Autowired
	private EmotionDriver 	ed;  //감정
	
	@Autowired
	private MovieRManager	mr;
	
	@Autowired
	private NaverManager		naver;
	
	@Autowired
	private MovieDAO			dao;
	
	@RequestMapping("main/main.do")
	public String movie_list(String title, Model model){
		//List<MovieDTO> list = mgr.movieAllData();
		
		List<String> reList = mgr.movieReserve();
		List<MovieNavDTO> nlist = mgr.navermovielist();
		List<MovieNavDTO> nList = new ArrayList<MovieNavDTO>();
		for(int i=0; i<7; i++){
			MovieNavDTO d = new MovieNavDTO();
			d.setNo(nlist.get(i).getNo());
			d.setPoster(nlist.get(i).getPoster());
			d.setTitle(nlist.get(i).getTitle());
			nList.add(d);
		}
		
		
		
		
		// 뉴스 읽기
		if(title==null){
		title="영화";
		}
		
		List<Item> newslist=NewsDAO.newsAllData(title);
		model.addAttribute("newslist", newslist);
		model.addAttribute("reList",reList);
		
		//model.addAttribute("list",list);
		model.addAttribute("nList",nList);
		return "main";
	}
	
	@RequestMapping("main/detail.do")
	public String movie_detail(int no,Model model) throws Exception{
		
		File file = new File("/home/sist/git/3Project/Final/src/main/webapp/text/movieDetail.txt");
		if(file.exists()) file.delete();
				
		MovieNavDTO vo = mgr.movieDetail(no); 	/* 1.영화상세정보 */
		
		for(int i=1;i<=3;i++){				/* 2.댓글수집 60개 */
			String json = mgr.review_data(vo.getTitle(), i);
			mgr.jsonParse(json);
		}
												/* 3.하둡 */
		ed.jobCall();
		
	   String[] movieFeel=new String[6];
	   movieFeel=mr.feel();		//  감정 6

	   int[] feelCount=new int[6];
	   feelCount=mr.count();
		//필요한 데이터를 MongoDB에 3개이상 저장(추천)
		for(int i=0; i<feelCount.length; i++){
			if(feelCount[i]>=3){
				MovieVO mv = new MovieVO();
				mv.setTitle(vo.getTitle());
				mv.setFeel(movieFeel[i]);
				mv.setCount(feelCount[i]);
				dao.recommandInsert(mv);
			}
		}
		
		model.addAttribute("vo",vo);
		model.addAttribute("movieFeel",movieFeel);
		model.addAttribute("feelCount",feelCount);
		
		return "pages/detail";
	}
	
	@RequestMapping("main/recommand.do")
	public String movie_recommand(String feel,Model model){
		
		if(feel==null) feel="재미";
		
		List<String> flist = dao.recommandFeelData();
		List<String> mlist = dao.recommandTitleData(feel);
		List<MovieNavDTO> list = new ArrayList<MovieNavDTO>();

		for(String title:mlist){
			MovieNavDTO d = mgr.movieDetail(title);
			list.add(d);
		}
		
		List<MovieVO> mflist = dao.recommandMovieFeelData(feel);
		
		List<MovieNavDTO> movielist = mgr.navermovielist();
		
		
		model.addAttribute("movielist",movielist);
		model.addAttribute("feel",feel);
		model.addAttribute("flist",flist);
		model.addAttribute("list",list);
		model.addAttribute("mflist",mflist);
		return "pages/recommand";
	}
	
	@RequestMapping("main/time.do")
	public String movie_time(String showtime,Model model){
		
		String query = "";
		
		List<MovieNavDTO> list = mgr.navermovielist();
		
		
		for(MovieNavDTO d:list){
			
			query = showtime+" "+d.getTitle();
			int count = naver.totalCount(query);
			//System.out.println(query+" >> "+count);
		}
		
		
		
		
		return "pages/recommand";
	}
	
	
	
	
	@RequestMapping("main/total.do")
	public String main_total(Model model){
		
		List<MovieDTO> list = mgr.movieAllData();
		
		/**
		 * [
	            ['Firefox', 45.0],
	            ['IE', 26.8],
	            {
	                name: 'Chrome',
	                y: 12.8,
	                sliced: true,
	                selected: true
	            },
	            ['Safari', 8.5],
	            ['Opera', 6.2],
	            ['Others', 0.7]
	        ]
		 * 
		 */
		
		// 하이차트 쓸때 주의할점 (d3도 비슷) 
		// 1. forEach가 되지 않음!
		//  2. ${}에 '' 를 인식을 못함!
		
		String data="[";
		int i=0;
		for(MovieDTO d:list){
			if(i==2){
				data += "{"
					  +"name: '"+d.getTitle()+"',"
	                +"y: "+d.getStar()+","
	                +"sliced: true,"
	                +"selected: true"
	                   +"},";
			}else{
				data += "['"+d.getTitle()+"',"+d.getStar()+"],";
			}
			i++;
		}
		data = data.substring(0,data.lastIndexOf(','));
		data += "]";
		
		model.addAttribute("data",data);
		model.addAttribute("list",list);
		return "pages/total";
	}
	
	
	
	
}
