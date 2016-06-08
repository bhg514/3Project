package com.sist.mapred;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class MovieReduce extends Reducer<Text, IntWritable, Text, IntWritable>{

	private IntWritable res = new IntWritable();

	
	/**
	 *  aa aa aa     aa[1,1,1]
	 *  		aa 1
	 *  		aa 1
	 *  		aa 1
	 * 
	 */
	
	@Override
	protected void reduce(Text key, Iterable<IntWritable> values,
			Reducer<Text, IntWritable, Text, IntWritable>.Context context) throws IOException, InterruptedException {
		
		int sum = 0;
		for(IntWritable v:values){
			sum += v.get(); // 정수형으로 받음
		}
		res.set(sum); // 다시 IntWritable로
		
		context.write(key, res);
		
		
	}
	
	
	
}
