package com.sist.search;
/*
 *  �ڹ� => ����Ŭ(DDL,DML) => Html,css => JSP
 *  =======================================
 *  
 *  MVC(XML,Anontation) => html5,jquery => Spring
 *                 => DB (VIEW,PS/SQL) , MYBATIS
 *  
 *  BigData(MapReduce,Hive,Pig) => ���� => �м� => ���� => �ð�ȭ
 *  
 */
public class Item {
	private String title;
	private String link;
	private String description;
	private String pubDate;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPubDate() {
		return pubDate;
	}
	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}
	
}
