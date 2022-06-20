package com.tech.blog.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Like;

public class LikeDao {
	
	private Connection con;

	public LikeDao(Connection con) {
		this.con = con;
	}

	public boolean insertLike(Like like) {
		boolean flag=false;
		try {
			String query="insert into tech_like(pid, userid) values(?,?)";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, like.getPid());
			pst.setInt(2, like.getUserId());
			
			
			
			pst.executeUpdate();
			
			flag=true;
			
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return flag;
	}
	
	public int countLikeOnPost(int pid) {
		int count=0;
		try {
			String query="select count(*) from tech_like where pid=?";
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
	
	public boolean isLikedByUser(Like like) {
		boolean flag=false;
		try {
			String query="select * from tech_like where pid=? and userid=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, like.getPid());
			pst.setInt(2, like.getUserId());
			
			ResultSet result =pst.executeQuery();
			while(result.next()) {
				flag=true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public boolean deleteLike(Like like) {
		boolean flag=false;
		try {
			String query="delete from tech_like where pid=? and userid=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, like.getPid());
			pst.setInt(2, like.getUserId());
			
			pst.executeUpdate();
			flag=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
		
	}
	
	public List<Like> getLikesByUserId(int userId){
		List<Like> userLikes =new ArrayList<Like>();
		try {
			String query="select * from tech_like where userid=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, userId);
			
			
			ResultSet result =pst.executeQuery();
			while(result.next()) {
				int lid=result.getInt("lid");
				int pid=result.getInt("pid");
				int userid=result.getInt("userid");
				
				Like like=new Like(lid, pid, userid);
				
				userLikes.add(like);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userLikes;
	}
}
