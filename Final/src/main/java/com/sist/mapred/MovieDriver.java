package com.sist.mapred;

import java.io.*;

import javax.annotation.Resource;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.hadoop.mapreduce.JobRunner;
import org.springframework.stereotype.Component;


@Component
public class MovieDriver {

	
	@Autowired
	   private Configuration conf;
		
		@Resource(name="emotionj")
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
			    if(fs.exists(new Path("/input/emotion")))
			    	fs.delete(new Path("/input/emotion"),true);
			    
			    if(fs.exists(new Path("/output/emotion")))
			    	fs.delete(new Path("/output/emotion"),true);
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
					   new Path("/home/seo/git/3Project/Final/src/main/webapp/text/movieDetail.txt"), 
					   new Path("/input/emotion/emotion.txt"));	
			   fs1.close();
			   
		   }catch(Exception ex){
			   System.out.println(ex.getMessage());
		   }
	   }
	   

	   public void copyToLocal(){
		   try{
			   FileSystem fs=FileSystem.get(conf);
			   fs.copyToLocalFile(
					   new Path("/output/local/part-r-00000"),
					   new Path("/home/seo/git/san/San/src/main/webapp/data/naver/output/local/part-r-00000"));
			   fs.close();			   
				
		   }catch(Exception ex)
		   {
			   System.out.println(ex.getMessage());
		   }
	   }
	   
	   
	   
	   
	   
	   
	public void movieMapReduce(){
		
		try{
			Configuration conf = new Configuration();
			Job job = new Job(conf,"MovieFeelCount");
			
			job.setJarByClass(MovieDriver.class);
			job.setMapperClass(MovieMapper.class);
			job.setReducerClass(MovieReducer.class);
			
			job.setOutputKeyClass(Text.class);
			job.setOutputValueClass(IntWritable.class);
			
			FileInputFormat.addInputPath(job, new Path("/home/seo/git/3Project/Final/src/main/webapp/text/desc.txt"));
			
			File dir= new File("/home/seo/git/3Project/Final/src/main/webapp/output");
			if(dir.exists()){
				File[] files = dir.listFiles();
				for(File f:files){
					f.delete();
				}
				dir.delete();
			} // rm -rf
			
			FileOutputFormat.setOutputPath(job, new Path("/home/seo/git/3Project/Final/src/main/webapp/output"));
			job.waitForCompletion(true);
			
		}catch(Exception ex){System.out.println(ex.getMessage());}
		
	}
	
}
