package com.sist.data;

public class MovieNavDTO {
	
	private int			no;
	private String		poster;
	private String		title;
	private String		genre;
	private double		reserve;
	private double		star;
	private int			movietime;
	
	
	
	public int getMovietime() {
		return movietime;
	}
	public void setMovietime(int movietime) {
		this.movietime = movietime;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public double getReserve() {
		return reserve;
	}
	public void setReserve(double reserve) {
		this.reserve = reserve;
	}
	public double getStar() {
		return star;
	}
	public void setStar(double star) {
		this.star = star;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	
	
	
}
