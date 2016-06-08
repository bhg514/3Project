package com.sist.mapred;

import java.io.*;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.springframework.stereotype.Component;


@Component
public class MovieDriver {

	public void movieMapReduce(){
		
		try{
			Configuration conf = new Configuration();
			Job job = new Job(conf,"MovieFeelCount");
			
			job.setJarByClass(MovieDriver.class);
			job.setMapperClass(MovieMapper.class);
			job.setReducerClass(MovieReduce.class);
			
			job.setOutputKeyClass(Text.class);
			job.setOutputValueClass(IntWritable.class);
			
			FileInputFormat.addInputPath(job, new Path("/home/sist/javaStudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/MovieMapReduceProject/desc.txt"));
			
			File dir= new File("/home/sist/javaStudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/MovieMapReduceProject/output");
			if(dir.exists()){
				File[] files = dir.listFiles();
				for(File f:files){
					f.delete();
				}
				dir.delete();
			} // rm -rf
			
			FileOutputFormat.setOutputPath(job, new Path("/home/sist/javaStudy/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/MovieMapReduceProject/output"));
			job.waitForCompletion(true);
			
		}catch(Exception ex){System.out.println(ex.getMessage());}
		
	}
	
}
