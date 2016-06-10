package com.sist.mapredWhen;

import javax.annotation.Resource;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapred.jobcontrol.Job;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.hadoop.mapreduce.JobRunner;
import org.springframework.stereotype.Component;


@Component
public class WhenDriver {

	
		@Autowired
	   private Configuration conf;
		
		@Resource(name="whenj")
	   private JobRunner jobRunner;		
		
		
		public synchronized void jobCall(){
		   try{
			   
			   jobRunner.call();
		   }catch(Exception ex){
			   System.out.println(ex.getMessage());
		   }
	   }
	/*Configuration conf = new Configuration();
	Job job = new Job(conf,"MultiMapReduce");
		
	job.setJarByClass(MultiDriver.class);
	job.setMapperClass(MultiMapper.class);
	job.setReducerClass(MultiReducer.class);
	job.setOutputKeyClass(Text.class);
	job.setOutputValueClass(IntWritable.class);
	FileInputFormat.addInputPath(job, new Path("./test"));
	FileOutputFormat.setOutputPath(job, new Path("./output"));
		
	job.waitForCompletion(true);*/
		
	   public void fileDelete(){
		   try{
			    FileSystem fs=FileSystem.get(conf);
			    if(fs.exists(new Path("/input/when")))
			    	fs.delete(new Path("/input/when"),true);
			    
			    if(fs.exists(new Path("/output/when")))
			    	fs.delete(new Path("/output/when"),true);
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
					   new Path("/home/sist/git/3Project/Final/src/main/webapp/text/movieTime.txt"), //영화상세정보
					   new Path("/input/when/when.txt"));	
			   fs1.close();
			   
		   }catch(Exception ex){
			   System.out.println(ex.getMessage());
		   }
	   }
	   

	   public void copyToLocal(){
		   try{
			   FileSystem fs=FileSystem.get(conf);
			   fs.copyToLocalFile(
					   new Path("/output/when/part-r-00000"),
					   new Path("/home/sist/git/3Project/Final/src/main/webapp/text/output/when/part-r-00000")); //영화감정분석
			   fs.close();			   
				
		   }catch(Exception ex)
		   {
			   System.out.println(ex.getMessage());
		   }
	   }
	   
}
