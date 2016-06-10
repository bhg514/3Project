package com.sist.naver;
import org.springframework.stereotype.Component;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import java.io.File;
import java.io.FileWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
@Component
public class Naver  {

	 public List<String> naver(String search){			
		 List<String> list=new ArrayList<String>();
		 
		try{
			int page=1;
				while(page<=501){					//30개 블로그 글
					String key = "197d457a077b8a11007af85847f73ac1";					
					String searchWord  = URLEncoder.encode(search ,"utf-8");
					
					XPath xpath = XPathFactory.newInstance().newXPath();
					Document documentInfo = DocumentBuilderFactory.newInstance().newDocumentBuilder()
									.parse("http://openapi.naver.com/search?key="+key+"&target=blog&start="+page+"&display="+10+"&query="+searchWord);
					
					NodeList items = (NodeList) xpath.evaluate("//item", documentInfo, XPathConstants.NODESET );					
					NodeList description = (NodeList) xpath.evaluate("//item/description", documentInfo, XPathConstants.NODESET );
/*					File file=new File("/home/sist/git/3Project/Final/src/main/webapp/text/movieDetail.txt");
					if(file.exists())
						file.delete();
					FileWriter fw =new FileWriter(file);*/					
					for(int i = 0; i < items.getLength(); i++)	{			
						//fw.write(description.item(i).getTextContent());
						list.add(description.item(i).getTextContent());
					}
					//fw.close();
					page=page+10;
				}
			}catch(Exception ex){
				System.out.println("naver="+ex.getMessage());
			}
		return list;
		}
	
}


