package com.sist.data;

import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.*;
import org.jsoup.select.Elements;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.*;

/*
 * 	String[] feel = {"사랑","로맨스","매력","즐거움","스릴",
				"소름","긴장","공포","유머","웃음","개그",
				"행복","전율","경이","우울","절망","신비",
				"여운","희망","긴박","감동","감성","휴머니즘",
				"자극","재미","액션","반전","비극","미스테리",
				"판타지","꿈","설레임","흥미","풍경","일상",
				"순수","힐링","눈물","그리움","호러","충격","잔혹"};
	String[] genre = {
			"드라마","판타지","공포","멜로","애정",
			"로맨스","모험","스릴러","느와르","다큐멘터리",
			"코미디","미스터리","범죄","SF","액션","애니메이션"	
	};
 * 
 * 
 */

@Component
public class MovieManager {

	public static void main(String[] args){
		
		MovieManager m = new MovieManager();
		//m.movieAllData();
		///home/actif/javaStudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/MovieProject/movie_main.jsp
		File file = new File("/home/actif/git/final/Final/src/main/webapp/text/desc.txt");
		if(file.exists()) file.delete();
		
		
		for(int i=1;i<=3;i++){
			String json = m.review_data("곡성", i);
			//System.out.println(json);
			m.jsonParse(json);
		}
	}
	
	public List<MovieDTO> movieAllData(){
		
		List<MovieDTO> list = new ArrayList<MovieDTO>();
		
		try{
			
			Document doc = Jsoup.connect("http://www.cgv.co.kr/movies/").get();			
			
			//System.out.println(doc);
			Elements titleElem = doc.select("div.box-contents strong.title");
			Elements imageElem = doc.select("div.box-image a span.thumb-image img");
			Elements percentElem = doc.select("div.box-contents div.score strong.percent span");
			Elements likeElem = doc.select("div.box-contents span.like span.count strong i");
			Elements starElem = doc.select("div.box-contents div.score span.percent ");
			Elements dayElem = doc.select("div.box-contents span.txt-info strong");
			Elements rankElem = doc.select("div.box-image strong.rank");
			Elements gradeElem = doc.select("div.box-image a span.thumb-image span");
			String[] color = {"#b87333","silver","gold","#e5e4e2","#ccffcc","#ccccff","#EDEDED"};			
			
			for(int i=0; i<percentElem.size(); i++){
				Element telem = titleElem.get(i);
				Element pelem = percentElem.get(i);
				Element delem = dayElem.get(i);
				Element lkelem = likeElem.get(i);
				Element stelem = starElem.get(i);
				Element imelem = imageElem.get(i);
				Element rkelem = rankElem.get(i);
				Element grelem = gradeElem.get(i);
				
				String img = imelem.attr("src");
				//System.out.println(telem.text()+"\t"+pelem.text()+"\t"+delem.text()+"\t"+lkelem.text()+"\t"+stelem.text()+"\t"+img+"\t"+rkelem.text()+"\t"+grelem.text());
				
				MovieDTO d = new MovieDTO();
				d.setNo(i+1);
				d.setTitle(telem.text());
				d.setReserve((Double.parseDouble(pelem.text().substring(0, pelem.text().lastIndexOf('%')))));
				d.setImage(img);
				d.setLike(Integer.parseInt(lkelem.text().replace(",", "")));
				d.setRegdate(delem.text().substring(0, delem.text().indexOf("개봉")));
				d.setStar(Integer.parseInt(stelem.text().substring(0, stelem.text().lastIndexOf('%'))));
				d.setRank(Integer.parseInt(rkelem.text().substring(3)));
				d.setGrade(grelem.text());
				d.setColor(color[i]);
				list.add(d);
			}
			
		}catch(Exception ex){
			System.out.println("movie All : "+ex.getMessage());
		}
		
		return list;
	} // movieAllData()
	
	public MovieDTO movieDetail(int no){
		MovieDTO d = new MovieDTO();
		
		List<MovieDTO> list = movieAllData();
		d = list.get(no-1);
		
		return d;
	} // movieDetail(int no)
	
	public MovieDTO movieDetail(String title){
		MovieDTO d = new MovieDTO();
		
		List<MovieDTO> list = movieAllData();
		for(MovieDTO dd:list){
			if(title.equals(dd.getTitle())){
				d = dd;
				break;
			}
		}
		
		return d;
	} // movieDetail(int no)

	public List<MovieNavDTO> navermovielist(){
		
		List<MovieNavDTO> list = new ArrayList<MovieNavDTO>();
		
		try{
			
			Document navdoc = Jsoup.connect("http://movie.naver.com/movie/running/current.nhn?order=reserve").get();
			
			Elements navTitleAndImg = navdoc.select("div.lst_wrap ul.lst_detail_t1 li div.thumb img");
			//Elements navThemes = navdoc.select("div.lst_wrap ul.lst_detail_t1 li span.link_txt a");
	
			for(int i=0; i<navTitleAndImg.size(); i++){
				Element navti = navTitleAndImg.get(i);
				
				String titleOfnaver = navti.attr("alt");
				String imgOfnaver = navti.attr("src");
				
				MovieNavDTO nmd = new MovieNavDTO();
				nmd.setPoster(imgOfnaver);
				nmd.setTitle(titleOfnaver);
				list.add(nmd);
			}
			
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}
		
		return list;
		
	}
	
	
	public List<String> movieRank(){
		
		List<String> list = new ArrayList<String>();
		
		try{
			
			Document doc = Jsoup.connect("http://movie.naver.com/movie/sdb/rank/rmovie.nhn").get();
			Elements elems = doc.select("td.title div.tit3");
			
			for(int i=0; i<10; i++){
				Element elem = elems.get(i);
				list.add(elem.text());
			}
			
		}catch(Exception ex){
			System.out.println("rank : "+ex.getMessage());
		}
		
		return list;
		
	} // movieRank()

	public List<String> movieReserve(){
		
		List<String> list = new ArrayList<String>();
		
		try{
			
			Document doc = Jsoup.connect("http://movie.naver.com/movie/sdb/rank/rreserve.nhn").get();
			Elements elems = doc.select("td.title div.tit4");
			
			for(int i=0; i<10; i++){
				Element elem = elems.get(i);
				list.add(elem.text());
			}
			
		}catch(Exception ex){
			System.out.println("reserve : "+ex.getMessage());
		}
		
		return list;
		
	} // movieReserve()
	
	public List<String> movieBoxoffice(){
		
		List<String> list = new ArrayList<String>();
		
		try{
			
			Document doc = Jsoup.connect("http://movie.naver.com/movie/sdb/rank/rboxoffice.nhn").get();
			Elements elems = doc.select("td.title div.tit1");
			
			for(int i=0; i<10; i++){
				Element elem = elems.get(i);
				list.add(elem.text());
			}
			
		}catch(Exception ex){
			System.out.println("boxoffice : "+ex.getMessage());
		}
		
		return list;
		
	} // movieBoxoffice()
	
	
	//C:\\springDev\\springStudy\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WebFinalProject\\images
	public String review_data(String title, int page){
		
		StringBuffer sb = new StringBuffer();
		try{
			String key = "88cd0292e24e787284b453c36c772445";		// daum API key
			
			URL url = new URL("https://apis.daum.net/search/blog?apikey="+key
							+"&result=20&output=json&q="+URLEncoder.encode(title,"UTF-8")+"&pageno="+page);	
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			String data = "";
			if(conn!=null){
				BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				while(true){
					data = in.readLine();
					if(data==null) break;
					sb.append(data+"\n");
				}
				
			}
			
		}catch(Exception ex){
			System.out.println("review_data : "+ex.getMessage());
		}
		
		return sb.toString();
	}
	
	// JSON{key:value}, XML, TXT, CSV

	public List<String> jsonParse(String json){
		
		List<String> list = new ArrayList<String>();
		try{
			
			JSONParser jp = new JSONParser();
			JSONObject jo = (JSONObject)jp.parse(json);
			// {}JSONObject		[]JSONArray
			// {channel:{....   item:[{},{},{},......{}] .... }}
			JSONObject channel = (JSONObject)jo.get("channel");		
			JSONArray item = (JSONArray)channel.get("item");
			
			String desc = "";
			for(int i=0; i<item.size(); i++){
				
				JSONObject obj = (JSONObject)item.get(i);
				String data = (String)obj.get("description");
				data = data.replaceAll("[A-Za-z0-9]", "");
				data = data.replace("&", "");
				data = data.replace(";", "");
				data = data.replace("/", "");
				data = data.replace(".", "");
				data = data.replace("#", "");
				data = data.replace("!", "");
				data = data.replace("?", "");
				data = data.replace(",", "");
				data = data.replace("*", "");
				data = data.replace("~", "");
				data = data.replace("^", "");
				data = data.replace(":", "");
				data = data.replace("+", "");				
				data = data.replace("(", "");
				data = data.replace(")", "");
				data = data.replace("_", "");
				list.add(data);
				desc += data+"\n";
			}
			
			// true는 append
			FileWriter fw = new FileWriter("/home/actif/git/3Project/Final/src/main/webapp/text/movieDetail.txt",true);
			fw.write(desc);
			fw.close();
			
			
		}catch(Exception ex){
			System.out.println("jsonParse : "+ex.getMessage());
		}
		
		return list;
	}
	
	
	
}
