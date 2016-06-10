package com.sist.movie;

import java.io.File;
import java.io.FileWriter;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.hadoop.mapred.analysejobhistory_jsp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.bestorworst.BestOrWorstDriver;
import com.sist.data.*;
import com.sist.mapred.*;
import com.sist.mapredEmotion.EmotionDriver;
import com.sist.mapredWhen.WhenDriver;
import com.sist.mapredWhen.WhenVO;
import com.sist.mapredWho.WhoDriver;
import com.sist.r.*;
import com.sist.mongo.*;
import com.sist.naver.Naver;
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
	private WhoDriver 		wd;
	@Autowired
	private MovieRManager	mr;
	
	@Autowired
	private WhenDriver		whend;
	
	@Autowired
	private Naver				naverparse;
	
	@Autowired
	private NaverManager		naver;
	
	@Autowired
	private MovieDAO			dao;
	@Autowired
	private BestOrWorstDriver bwd;
	@RequestMapping("main/main.do")
	public String movie_list(String title, Model model){
		List<MovieDTO> list = mgr.movieAllData();
		for(int i=0;i<list.size();i++){
			list.get(i).getImage();
		}
		List<String> raList = mgr.movieRank();
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
		file = new File("/home/sist/git/3Project/Final/src/main/webapp/text/output/emotion/part-r-00000");
		if(file.exists()) file.delete();
				
		MovieNavDTO vo = mgr.movieDetail(no); 	/* 1.영화상세정보 */
		
		for(int i=1;i<=3;i++){				 //2.댓글수집 60개 
			String json = mgr.review_data(vo.getTitle(), i);
			mgr.jsonParse(json);
		}
												/* 3.하둡 */
		//naver.totalCount(vo.getTitle());
		ed.jobCall();
		wd.jobCall();
		bwd.jobCall();
		
	   String[] movieFeel=new String[6];
	   movieFeel=mr.feel();		//  감정 6
	   int[] feelCount=new int[6];
	   feelCount=mr.count();
	   
	   String[] movieWho=new String[6];
	   int[] whoCount=new int[6];
	   movieWho=mr.who();
	   whoCount=mr.who_count();
	   
	  /* for(int i=0; i<feelCount.length; i++){
			if(feelCount[i]>=3){
				MovieVO mv = new MovieVO();
				mv.setTitle(vo.getTitle());
				mv.setFeel(movieFeel[i]);
				mv.setCount(feelCount[i]);
				dao.recommandInsert(mv);
			}
		}*/  												 /* 몽고디비 돌리지 않기 */
		int top=feelCount[0];
		int j=0;
		String mf="[";
		for(String s:movieFeel)
		{
			if(j>5)
				break;
			mf+="'"+s+"',";
			j++;
		}
		mf=mf.substring(0,mf.lastIndexOf(","));
		mf+="];";
	   
		
		String fc="[";
		j=0;
		for(int s:feelCount)
		{
			if(j>5)
				break;
			fc+="'"+((s*100)/(top+0.1))+"',";  
			j++;
		}
		fc=fc.substring(0,fc.lastIndexOf(","));
		fc+="];";
	   /////////////////////////////////////////////////////////////////////////////감정
	   
	   String[] movieBoW=new String[6];
	   int[] BoWCount=new int[6];
	   movieBoW=mr.bestorworst();
	   BoWCount=mr.bestorworst_count();
	   int bestCount=0;
	   int wortCount=0;
	   for(int i=0;i<BoWCount.length;i++){
		   if(movieBoW[i].equals("힘든")||movieBoW[i].equals("힘듦")||movieBoW[i].equals("힘듬")||movieBoW[i].equals("힘든")||movieBoW[i].equals("싫다")||movieBoW[i].equals("싫어")||
				   movieBoW[i].equals("귀찮")||movieBoW[i].equals("현기증")||movieBoW[i].equals("괜히")||movieBoW[i].equals("포기")||movieBoW[i].equals("어려움")||movieBoW[i].equals("노잼")||movieBoW[i].equals("재미없음")||
				   movieBoW[i].equals("열받아")||movieBoW[i].equals("짜증")||movieBoW[i].equals("아쉬운")||movieBoW[i].equals("고생")||movieBoW[i].equals("후회")||movieBoW[i].equals("아깝")||movieBoW[i].equals("비추")){
			   wortCount+=BoWCount[i];
		   }else {
			   bestCount+=BoWCount[i];
		}
	   }

		   //"귀찮","현기증","포기","어려움","아쉬움","열받아","짜증","아쉬운","고생",
	   
	   String[] whoKey={"애인","가족","친구"};
	   int[] who4Count={0,0,0};
	   for(int i=0;i<whoCount.length;i++){
		    if(movieWho[i].equals("여자친구")||movieWho[i].equals("남자친구")||movieWho[i].equals("남친")||movieWho[i].equals("여친")||movieWho[i].equals("오빠")||movieWho[i].equals("애인")||movieWho[i].equals("자기")){
		    	who4Count[0]+=whoCount[i];
		    }else if(movieWho[i].equals("가족")||movieWho[i].equals("엄마")||movieWho[i].equals("아빠")){
		    	who4Count[1]+=whoCount[i];
		    }else{
		    	who4Count[2]+=whoCount[i];
		    }
	   
	   }
	 
		String whoText="";
		for(int i=0;i<3;i++)
		{
	
			whoText+="{\"label\":'"+whoKey[i]+"',"+" \"value\":'"+who4Count[i]+"'},";
			
		}
		whoText=whoText.substring(0,whoText.lastIndexOf(","));

		int bestValue=(bestCount/(bestCount+wortCount))*100;

		
		// 조조 야간 오전 오후 심야
		String[] timeshow = {"조조","오전","오후","야간","심야"};
		String query = "";
		int[] times = new int[5];
		int sum = 0;
		for(int i=0; i<times.length; i++){
			query = timeshow[i]+" "+vo.getTitle();   // 조조 아가씨
			
			times[i] = naver.totalCount(query); 
			System.out.println(times[i]);
			sum += times[i];
		}
		for(int i=0; i<times.length; i++){
			double a = (times[i]/(double)sum)*100;
			times[i] = (int)(Math.round(a));
			//System.out.println(times[i]);
		}
		
		
		model.addAttribute("vo",vo);

		model.addAttribute("whoText",whoText);
		
		model.addAttribute("bestValue",bestValue);
		model.addAttribute("times",times);

		//model.addAttribute("movieFeel",movieFeel);
		model.addAttribute("fc",fc);
		model.addAttribute("mf",mf);
		model.addAttribute("feelCount",feelCount);
		model.addAttribute("movieWho",movieWho);
		model.addAttribute("whoCount",whoCount);
		
		return "pages/detail";
	}
	
	
	
	
	
	
	
	
	@RequestMapping("main/recommand.do")											/* 추천페이지 _ 84개 데이터 */
	public String movie_recommand(String feel,Model model){

		List<String> flist = dao.recommandFeelData();			//1. 84개의 몽고디비의 중복없는 감정 값 들고오기
		List<MovieNavDTO> movielist = mgr.navermovielist();	//2. 84개의 영화 데이터 목록 
		
		if(feel==null) 	feel="재미";
			
		model.addAttribute("movielist",movielist);
		model.addAttribute("feel",feel);
		model.addAttribute("flist",flist);

		return "pages/recommand";
	}
																								
	@RequestMapping("main/recommandEmotion.do")										/* 추천페이지 _ 감정 */
	public String movie_recommand_Emotion(Model model, String feel){
				
		List<String> flist = dao.recommandFeelData();				//감정 리스트		
		List<String> mlist = dao.recommandTitleData(feel);			//감정영화리스트
		List<Integer> mlist2 = dao.recommandTitleData2(feel);			//감정영화리스트count
		
		List<MovieNavDTO> mndto=new ArrayList<MovieNavDTO>();
		
		int i=0;
		for(String title:mlist){
			if(i<3){
				mndto.add(mgr.movieDetail(title));
				mndto.get(i).setCount(mlist2.get(i));
			}	
			i++;
		}
		
		model.addAttribute("feel",feel);			//감정
		model.addAttribute("flist",flist);		//감정리스트
		model.addAttribute("mndto",mndto);		//감정영화리스트 3개
		
		return "pages/recEmotion";
	}
	
	
	
	
	@RequestMapping("main/time.do")
	public String movie_time(String showtime,Model model) throws Exception{
		
		/*List<WhenVO> volist = new ArrayList<WhenVO>();
		String query = "";
		
		List<MovieNavDTO> movielist = mgr.navermovielist();
		
		for(int i=0; i<3; i++){ // movielist 만큼 돌려준다. 일단은 top3 실험...
			//WhenDriver whend = new WhenDriver();
			query = movielist.get(i).getTitle();
			System.out.println(query);
		
			List<String> list = naverparse.naver(query);
			
			File file=new File("/home/sist/git/3Project/Final/src/main/webapp/text/movieTime.txt");
			if(file.exists())
				file.delete();
			FileWriter fw =new FileWriter(file);
			
			for(String text:list){
				fw.write(text);
			}
			fw.close();
			
			
			whend.jobCall();
			
			WhenVO vo = mr.whenInfo();
			vo.setNo(i+1);
			volist.add(vo);
		}
		System.out.println(volist.size());*/
		List<String> flist = dao.recommandFeelData();				//감정 리스트	
		List<MovieVO> list = dao.recomTimeData(showtime);
		List<MovieNavDTO> movielist = new ArrayList<MovieNavDTO>();
		
		int ind = 0;
		for(MovieVO v:list){
			movielist.add(mgr.movieDetail(v.getTitle()));
			movielist.get(ind++).setCount(v.getCount());
		}
		for(MovieVO vk:list){
			System.out.println(vk.getTitle()+" "+vk.getCount());
		}
		
		model.addAttribute("movielist",movielist);
		model.addAttribute("flist",flist);
		
		return "pages/recTime";
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
