package com.tech.blog.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;

public class PostDao {
	
	private Connection con;

	public PostDao(Connection con) {
		this.con = con;
	}
	
	public ArrayList<Category> getAllCategories(){
		ArrayList<Category> categories=new ArrayList<Category>();
		try {
			String query="select * from tech_category";
			Statement st=this.con.createStatement();
			
			ResultSet result=st.executeQuery(query);
			
			while(result.next()) {
				int cid=result.getInt("cid");
				String cName=result.getString("cname");
				String cDesc=result.getString("cdescription");
				
				Category category=new Category(cid, cName, cDesc);
				
				categories.add(category); 
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return categories;
	}

	
	public boolean savePost(Post post) {
		boolean flag=false;
		try {
			
			String query="insert into tech_post(ptitle, pcontent, pcode, ppic, cid, userid) values(?,?,?,?,?,?)";
			
			PreparedStatement pst=this.con.prepareStatement(query);
			
			pst.setString(1, post.getpTitle());
			pst.setString(2, post.getpContent());
			pst.setString(3, post.getpCode());
			pst.setString(4, post.getpPic());
			pst.setInt(5, post.getCid());
			pst.setInt(6, post.getUserId());
			
			pst.executeUpdate();
			
			flag=true;
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	
	public List<Post> getAllPosts() {
		List<Post> posts=new ArrayList<Post>();
		
		try {
			String query="select * from tech_post order by pid desc";
			Statement st=this.con.createStatement();
			
			ResultSet result=st.executeQuery(query);
			while(result.next()) {
				
				int pId=result.getInt("pid");
				String pTitle=result.getString("ptitle");
				String pContent=result.getString("pcontent");
				String pCode=result.getString("pcode");
				String pPic=result.getString("ppic");
				Timestamp pDate=result.getTimestamp("pdate");
				int cId=result.getInt("cid");
				int userId=result.getInt("userid");
				
				Post post=new Post(pId, pTitle, pContent, pCode, pPic, pDate, cId, userId);
				
				posts.add(post);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return posts;
		
	}
	
	public List<Post> getPostsByCategoryId(int cid){
		List<Post> posts=new ArrayList<Post>();
		
		try {
			String query="select * from tech_post where cid=? order by pid desc";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, cid);
			
			ResultSet result=pst.executeQuery();
			
			while(result.next()) {
				
				int pId=result.getInt("pid");
				String pTitle=result.getString("ptitle");
				String pContent=result.getString("pcontent");
				String pCode=result.getString("pcode");
				String pPic=result.getString("ppic");
				Timestamp pDate=result.getTimestamp("pdate");
				int cId=result.getInt("cid");
				int userId=result.getInt("userid");
				
				Post post=new Post(pId, pTitle, pContent, pCode, pPic, pDate, cId, userId);
				
				posts.add(post);
		
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return posts;
	}
		
	
	public Post getPostByPostId(int pid) {
		Post post=null;
		try {
			String query="select * from tech_post where pid=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			
			pst.setInt(1, pid);
			ResultSet result=pst.executeQuery();
			
			while(result.next()) {
				
				int pId=result.getInt("pid");
				String pTitle=result.getString("ptitle");
				String pContent=result.getString("pcontent");
				String pCode=result.getString("pcode");
				String pPic=result.getString("ppic");
				Timestamp pDate=result.getTimestamp("pdate");
				int cId=result.getInt("cid");
				int userId=result.getInt("userid");
				
				post=new Post(pId, pTitle, pContent, pCode, pPic, pDate, cId, userId);
				
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return post;
	}
	
	public List<Post> getPostsByUserId(int userId){
		List<Post> posts=new ArrayList<Post>();
		
		try {
			String query="select * from tech_post where userid=? order by pid desc";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, userId);
			
			ResultSet result=pst.executeQuery();
			
			while(result.next()) {
				
				int pId=result.getInt("pid");
				String pTitle=result.getString("ptitle");
				String pContent=result.getString("pcontent");
				String pCode=result.getString("pcode");
				String pPic=result.getString("ppic");
				Timestamp pDate=result.getTimestamp("pdate");
				int cId=result.getInt("cid");
				int uid=result.getInt("userid");
				
				Post post=new Post(pId, pTitle, pContent, pCode, pPic, pDate, cId, uid);
				
				posts.add(post);
		
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return posts;
	}

	public boolean deletePostByPostId(int postId) {
		boolean flag=false;
		try {
			String query="delete from tech_post where pid=?";
			PreparedStatement pst=this.con.prepareStatement(query);
			pst.setInt(1, postId);
			
			
			pst.executeUpdate();
			flag=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
		
	}
}
