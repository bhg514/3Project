package com.sist.r;

/*
 *  1) 전체 영화 수집 => Jsoup
 *  ========================
 *  		MovieManger <= MovieDTO
 *  2) 분석 => MapReduce (Hadoop)
 *     =================
 *     		Mapper,Reduce,Driver => part-r-00000
 *  3) 시각화 => R (feel,count)  => Graph
 *     =================
 *     		MovieRManager <= FeelVO
 *  4) MongoDB <== FeelVO
 * 
 * 
 */


public class FeelVO {

	private String		feel;
	private int			count;
	
	public String getFeel() {
		return feel;
	}
	public void setFeel(String feel) {
		this.feel = feel;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
	
	
	
}
