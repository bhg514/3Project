package com.sist.member;
/*
 *   ID
PWD
NAME
SEX
BIRTH
TEL
POST
ADDR1
ADDR2
LOGCOUNT
REGDATE
 */
import java.util.*;
public class MemberDTO {
  private String id;
  private String pwd;
  private String name;
  private String sex;
  private String birth;
  private String tel;
  private String post;
  private String addr1;
  private String addr2;
  private Date regdate;
  private int logcount;
  private String tel1;
  private String tel2;
  private String tel3;
  private String post1;
  private String post2;
  private int admin;
  
	public int getAdmin() {
	return admin;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getLogcount() {
		return logcount;
	}
	public void setLogcount(int logcount) {
		this.logcount = logcount;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getPost1() {
		return post1;
	}
	public void setPost1(String post1) {
		this.post1 = post1;
	}
	public String getPost2() {
		return post2;
	}
	public void setPost2(String post2) {
		this.post2 = post2;
	}
	public String getTel() {
		return tel1+"-"+tel2+"-"+tel3;
	}
	public String getPost() {
		return post1+"-"+post2;
	}
	  
  
}





