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
		// https://search.naver.com/search.naver?where=post&sm=tab_pge&query= &st=sim&date_option=0&date_from=&date_to=&dup_remove=1&post_blogurl=&post_blogurl_without=&srchby=all&nso=&ie=utf8&start=11
		// sh_blog_title _sp_each_url _sp_each_title => attr("title")
		try{
			
			Document doc = Jsoup.connect("https://search.naver.com/search.naver?sm=tab_hty.top&where=post&oquery="+query+"&ie=utf8&query="+query).get();
			Elements total = doc.select("span.title_num");
			/*System.out.println(total.size());
			System.out.println(total.text());*/
			
			
			String arg = total.text().substring(total.text().lastIndexOf('/')+1).trim();
			arg = arg.substring(0, arg.lastIndexOf('건'));
			arg = arg.replaceAll(",", "");
			
			num = Integer.parseInt(arg);
			
			
			
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}
		
		
		
		return num;
	}
	
	
	
	
}
