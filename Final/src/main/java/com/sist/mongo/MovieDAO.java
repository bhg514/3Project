package com.sist.mongo;

import java.util.*;

import org.springframework.stereotype.Repository;

import com.mongodb.*;
import java.net.*;

@Repository
public class MovieDAO {

	private MongoClient		mc;
	private DB					db;
	private DBCollection		dbc;
	
	public MovieDAO(){
		try{	
			mc = new MongoClient(new ServerAddress("211.238.142.77",27017));
			db = mc.getDB("mydb");
			dbc = db.getCollection("recommand");
			
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}
	}
	
	// 저장
	public void recommandInsert(MovieVO vo){
		try{
			int max = 0;
			DBCursor cursor = dbc.find();
			while(cursor.hasNext()){
				BasicDBObject obj = (BasicDBObject)cursor.next();
				int no = obj.getInt("no");
				if(max<no) max=no;
			}
			cursor.close();
			
			cursor = dbc.find();
			boolean bCheck = false;
			int i = 0;
			while(cursor.hasNext()){
				BasicDBObject obj = (BasicDBObject)cursor.next();
				String title = obj.getString("title");
				String feeling = obj.getString("feel");
				i = obj.getInt("no");
				if(title.equals(vo.getTitle()) && feeling.equals(vo.getFeel())){
					bCheck = true;
					break;
				}
			}
			cursor.close();
			
			if(bCheck){	// update
				BasicDBObject where = new BasicDBObject();
				where.put("no", i);
				BasicDBObject obj = (BasicDBObject)dbc.findOne(where);
				
				BasicDBObject up = new BasicDBObject();
				up.put("no", obj.getInt("no"));
				up.put("title", obj.getString("title"));
				up.put("feel", vo.getFeel());
				up.put("count", vo.getCount());
				dbc.update(where, new BasicDBObject("$set",up));
				
			}else{	// insert
				BasicDBObject in = new BasicDBObject();
				in.put("no", max+1);
				in.put("title", vo.getTitle());
				in.put("feel", vo.getFeel());
				in.put("count", vo.getCount());
				dbc.insert(in);
			}
			
			
		}catch(Exception ex){
			System.out.println(ex.getMessage());
		}
	}
	
	// 감성 (중복없이)
	public List<String> recommandFeelData(){
		List<String> list = new ArrayList<String>();
		try{
			list = dbc.distinct("feel");
		}catch(Exception ex){System.out.println(ex.getMessage());}
		
		return list;
	}
	
	// 감성 => 영화제목
	public List<String> recommandTitleData(String feel){
		List<String> list = new ArrayList<String>();
		try{
			BasicDBObject where = new BasicDBObject();
			where.put("feel", feel);
			
			DBCursor cursor = dbc.find(where);
			while(cursor.hasNext()){
				BasicDBObject obj = (BasicDBObject)cursor.next();
				list.add(obj.getString("title"));
			}
			cursor.close();
		}catch(Exception ex){System.out.println(ex.getMessage());}
		
		return list;
	}
	
	public List<MovieVO> recommandMovieFeelData(String feel){
		
		List<MovieVO> list = new ArrayList<MovieVO>();
		try{
			BasicDBObject where = new BasicDBObject();
			where.put("feel", feel);
			DBCursor cursor = dbc.find(where);
			while(cursor.hasNext()){
				BasicDBObject obj = (BasicDBObject)cursor.next();
				
				MovieVO vo = new MovieVO();
				vo.setTitle(obj.getString("title"));
				vo.setCount(obj.getInt("count"));
				list.add(vo);
			}
			cursor.close();
		}catch(Exception ex){System.out.println(ex.getMessage());}
		
		return list;
	}
	
}
