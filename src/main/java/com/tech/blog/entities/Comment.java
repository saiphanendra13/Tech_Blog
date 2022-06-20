package com.tech.blog.entities;

import java.sql.Timestamp;

public class Comment {
	
	private int commentId;
	private String commentDesc;
	private Timestamp comDateTime;
	private int postId;
	private int userId;
	
	public Comment(int commentId, String commentDesc,Timestamp comDateTime, int postId, int userId) {
		
		this.commentId = commentId;
		this.commentDesc = commentDesc;
		this.comDateTime = comDateTime;
		this.postId = postId;
		this.userId = userId;
	}
	public Comment(String commentDesc, Timestamp comDateTime,int postId, int userId) {
		
		this.commentDesc = commentDesc;
		this.comDateTime = comDateTime;
		this.postId = postId;
		this.userId = userId;
	}
	
	
	public Comment(String commentDesc, int postId, int userId) {
	
		this.commentDesc = commentDesc;
		this.postId = postId;
		this.userId = userId;
	}
	public Comment() {
		
	}
	public int getCommentId() {
		return commentId;
	}
	public Timestamp getComDateTime() {
		return comDateTime;
	}
	public void setComDateTime(Timestamp comDateTime) {
		this.comDateTime = comDateTime;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public String getCommentDesc() {
		return commentDesc;
	}
	public void setCommentDesc(String commentDesc) {
		this.commentDesc = commentDesc;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	

}
