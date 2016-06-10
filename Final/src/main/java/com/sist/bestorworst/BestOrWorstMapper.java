package com.sist.bestorworst;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class BestOrWorstMapper extends Mapper<LongWritable, Text, Text, IntWritable>{

	
	private final IntWritable one = new IntWritable(1);
	private Text result = new Text();
	
	String[] feel = {
			"좋다","좋은","좋아","행복","재미","즐거움","상쾌","유쾌","통쾌","가고싶은","그리운","이쁜",
			"흐뭇","무서움","뿌듯","보람","기쁨","지루","대견","조오타","죽겠다","죽겟다","주글거",
			"존좋","아름다움","이쁘","이쁨","들떠","기분업","기대","탁 트이다","탁트이다","트이다",
			"뻥뚫","매료","최고","환상","설렘",
			
			"힘든","힘듦","힘듬","싫음","싫어","별로","다시는","괜히","망설","귀찮","현기증","포기","어려움","아쉬움","열받아","짜증","아쉬운","고생","싫다","싫어",
			"노잼",	"재미없음","비추","아깝","후회"
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
