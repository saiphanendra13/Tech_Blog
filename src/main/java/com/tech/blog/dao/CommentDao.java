package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Comment;

public class CommentDao {
	
	private Connection con;

	public CommentDao(Connection con) {
		this.con = con;
	}
	
	public List<Comment> getCommentsByPostId(int postId){
		List<Comment> comments=new ArrayList<Comment>();
		try {
			String query="select * from tech_comment where pid=? order by pid asc";
			PreparedStatement pst=this.con.prepareStatement(query);
			
			pst.setInt(1, postId);
			
			ResultSet result=pst.executeQuery();
			
			while(result.next()) {
				
				int commentId=result.getInt("comid");
				String commentDesc=result.getString("comdesc");
				int pId=result.getInt("pid");
				int userId=result.getInt("userid");
				Timestamp dateTime=result.getTimestamp("comdate");
				
				Comment com=new Comment(commentId, commentDesc,dateTime, pId, userId);
				
				comments.add(com);
				
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return comments;
		
	}
	
	public boolean addComment(Comment comment) {
		boolean flag=false;
		try {
			String query="insert into tech_comment(comdesc,pid,userid) values(?,?,?)";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setString(1, comment.getCommentDesc());
			pst.setInt(2, comment.getPostId());
			pst.setInt(3, comment.getUserId());
			
			pst.executeUpdate();
			
			flag=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return flag;
		
	}
	
	public boolean deleteComment(int commentId) {
		boolean flag=false;
		try {
			String query="delete from tech_comment where comid=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, commentId);
			
			
			pst.executeUpdate();
			flag=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
		
	}
	public int countCommentOnPost(int pid) {
		int count=0;
		try {
			String query="select count(*) from tech_comment where pid=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, pid);
			
			ResultSet result =pst.executeQuery();
			while(result.next()) {
				count=result.getInt("count(*)");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

}
