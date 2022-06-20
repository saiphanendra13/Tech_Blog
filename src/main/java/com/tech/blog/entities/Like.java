package com.tech.blog.entities;

public class Like {
	
	private int lid;
	private int pid;
	private int userId;
	
	
	public Like(int lid, int pid, int userId) {
		
		this.lid = lid;
		this.pid = pid;
		this.userId = userId;
	}


	public Like(int pid, int userId) {
		
		this.pid = pid;
		this.userId = userId;
	}
	
	public Like() {
		
	}


	public int getLid() {
		return lid;
	}


	public void setLid(int lid) {
		this.lid = lid;
	}


	public int getPid() {
		return pid;
	}


	public void setPid(int pid) {
		this.pid = pid;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}
	

}
