package com.sist.search;
import java.util.*;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;
import com.mongodb.*;
import java.net.*;
import java.io.*;

public class NewsDAO {
	public static List<Item> newsAllData(String title){
		List<Item> list=new ArrayList<Item>();
		try{
			System.out.println("타이틀 받는다 디에이오:"+title);
			URL url=new URL("http://newssearch.naver.com/search.naver?where=rss&query="+URLEncoder.encode(title,"UTF-8"));
			JAXBContext jc=JAXBContext.newInstance(Rss.class);
			Unmarshaller um=jc.createUnmarshaller();
			Rss rss=(Rss)um.unmarshal(url);
			list=rss.getChannel().getItem();
			int count=0;
			for(Item item:list){
				Item vo=new Item();
				vo.setTitle(item.getTitle());
				vo.setLink(item.getLink());
				String desc=item.getDescription();
				desc=desc.replace(".", "");
				desc=desc.replace("'", "");
				desc=desc.replaceAll("[A-Za-z]", "");
				vo.setDescription(desc);
				list.set(count++, vo);
			}
		}catch(Exception ex){
			System.out.println("NewsDAO:"+ex.getMessage());
		}
		return list;
	}
}
