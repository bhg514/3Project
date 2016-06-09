package com.sist.naver;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Component;

@Component
public class NaverManager {

	
	//<span class="title_num">1-10 / 902건</span>
	// https://search.naver.com/search.naver?sm=tab_hty.top&where=post&oquery= &ie=utf8&query=
	public int totalCount(String query){
		
		int num = 0;
		
		try{
			
			Document doc = Jsoup.connect("https://search.naver.com/search.naver?sm=tab_hty.top&where=post&oquery="+query+"&ie=utf8&query="+query).get();
			Elements total = doc.select("span.title_num");
			/*System.out.println(total.size());
			System.out.println(total.text());*/
			
			String arg = total.text().substring(total.text().lastIndexOf('/')+1).trim();
			arg = arg.substring(0, arg.lastIndexOf('건'));
			arg = arg.replaceAll(",", "");
			System.out.println(arg);
			num = Integer.parseInt(arg);
			
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}
		
		
		
		return num;
	}
	
}
