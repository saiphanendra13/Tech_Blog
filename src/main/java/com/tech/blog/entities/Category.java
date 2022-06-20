package com.tech.blog.entities;

public class Category {
	
	private int cid;
	private String cName;
	private String cDescription;
	
	
	public Category() {
		super();
	}


	public Category(String cName, String cDescription) {
		super();
		this.cName = cName;
		this.cDescription = cDescription;
	}


	public Category(int cid, String cName, String cDescription) {
		
		this.cid = cid;
		this.cName = cName;
		this.cDescription = cDescription;
	}


	public int getCid() {
		return cid;
	}


	public void setCid(int cid) {
		this.cid = cid;
	}


	public String getcName() {
		return cName;
	}


	public void setcName(String cName) {
		this.cName = cName;
	}


	public String getcDescription() {
		return cDescription;
	}


	public void setcDescription(String cDescription) {
		this.cDescription = cDescription;
	}
	

}
