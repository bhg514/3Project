package com.sist.mongo;
/*
 *    SELECT * FROM board
 *    db.board.find()
 *    
 *    SELECT * FROM board WHERE no=1
 *    db.board.find({no:1})
 *    
 *    SELECT * FROM board WHERE no>10
 *    db.board.find({"$gt",{no:10}}
 *    <  $lt
 *    >  $gt
 *    <= $le
 *    >= $ge
 *    == $eq
 *    != $ne
 *    ==> ����  ==> $set
 *    ==> LIKE ==> $regex
 *    SELECT COUNT(*) FROM board
 *    db.board.count() 
 *    
 *    SELECT * FROM board
 *    WHERE rownum BETWEEN 1 AND 10
 *            skip(0).limit(10)
 *    ORDER BY no DESC => sort("no",-1)
 *    ORDER BY no ASC  => sort("no", 1)
 *    
 *    ORDER BY no DESC,name ASC
 *      sort("no",-1).append("name",1)
 *      
 *    JSON {key:value}
 */
public class BoardVO {
    private int no;
    private String name;
    private String subject;
    private String content;
    private String pwd;
    private String regdate;
    private int hit;
    private int group_id;
    private int group_step;
    private int group_tab;
    private int root;
    private int depth;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getGroup_id() {
		return group_id;
	}
	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}
	public int getGroup_step() {
		return group_step;
	}
	public void setGroup_step(int group_step) {
		this.group_step = group_step;
	}
	public int getGroup_tab() {
		return group_tab;
	}
	public void setGroup_tab(int group_tab) {
		this.group_tab = group_tab;
	}
	public int getRoot() {
		return root;
	}
	public void setRoot(int root) {
		this.root = root;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	  
  
}
