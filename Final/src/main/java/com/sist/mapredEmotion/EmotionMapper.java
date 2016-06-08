package com.sist.mapredEmotion;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class EmotionMapper extends Mapper<LongWritable, Text, Text, IntWritable>{

	
	private final IntWritable one = new IntWritable(1);
	private Text result = new Text();
	
	String[] feel = {"사랑","로맨스","매력","즐거움","스릴",
			"소름","긴장","공포","유머","웃음","개그",
			"행복","전율","경이","우울","절망","신비",
			"여운","희망","긴박","감동","감성","휴머니즘",
			"자극","재미","액션","반전","비극","미스테리",
			"판타지","꿈","설레임","흥미","풍경","일상",
			"순수","힐링","눈물","그리움","호러","충격","잔혹",
			"드라마","판타지","공포","멜로","애정",
			"로맨스","모험","느와르","다큐멘터리","코미디"	
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
