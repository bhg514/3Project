package com.sist.mapredWho;

import javax.annotation.Resource;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.hadoop.mapreduce.JobRunner;
import org.springframework.stereotype.Component;


@Component
public class WhoDriver {

	
	@Autowired
	   private Configuration conf;
		
		@Resource(name="whoj")
	   private JobRunner jobRunner;		
		
		public void jobCall(){
		   try{
			   jobRunner.call();
		   }catch(Exception ex){
			   System.out.println(ex.getMessage());
		   }
	   }
		
		
	   public void fileDelete(){
		   try{
			    FileSystem fs=FileSystem.get(conf);
			    if(fs.exists(new Path("/input/who")))
			    	fs.delete(new Path("/input/who"),true);
			    
			    if(fs.exists(new Path("/output/who")))
			    	fs.delete(new Path("/output/who"),true);
			    fs.close();
		   }catch(Exception ex){
			   System.out.println(ex.getMessage());
		   }
	   } 
	   
	   public void copyFromLocal(){
		   try{
			   FileSystem fs1=FileSystem.get(conf);
			   // hadoop fs -cat /
			   fs1.copyFromLocalFile(
					   new Path("/home/seo/git/3Project/Final/src/main/webapp/text/movieDetail.txt"), //영화상세정보
					   new Path("/input/who/who.txt"));	
			   fs1.close();
			   
		   }catch(Exception ex){
			   System.out.println(ex.getMessage());
		   }
	   }
	   

	   public void copyToLocal(){
		   try{
			   FileSystem fs=FileSystem.get(conf);
			   fs.copyToLocalFile(
					   new Path("/output/who/part-r-00000"),
					   new Path("/home/seo/git/3Project/Final/src/main/webapp/text/output/who/part-r-00000")); //영화감정분석
			   fs.close();			   
				
		   }catch(Exception ex)
		   {
			   System.out.println(ex.getMessage());
		   }
	   }
	   
}
