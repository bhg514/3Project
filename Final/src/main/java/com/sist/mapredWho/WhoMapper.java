package com.sist.mapredWho;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class WhoMapper extends Mapper<LongWritable, Text, Text, IntWritable>{

	
	private final IntWritable one = new IntWritable(1);
	private Text result = new Text();
	
	String[] feel = {
			//넣으세요
	};
	Pattern[] pattern = new Pattern[feel.length];
	
	
	@Override
	protected void map(LongWritable key, Text value, Mapper<LongWritable, Text, Text, IntWritable>.Context context)
			throws IOException, InterruptedException {
		
		for(int i=0; i<feel.length; i++){
			pattern[i] = Pattern.compile(feel[i]);
		}
		
		Matcher[] matcher = new Matcher[feel.length];
		for(int i=0; i<feel.length;i++){
			matcher[i] = pattern[i].matcher(value.toString()); // 값에 패턴내용을 갖고온다.(한줄)
			while(matcher[i].find()){ // 한줄에 대해서 루프
				result.set(feel[i]); // 키값 부여
				context.write(result, one); // 단어 하나에 1씩 부여
			}
		}
		
		
	}

	
	
}
