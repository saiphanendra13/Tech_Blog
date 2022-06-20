package com.tech.blog.dao;

import java.sql.*;

import com.tech.blog.entities.User;

public class UserDao {

	private Connection con;

	public UserDao(Connection con) {
		this.con = con;
	}

	// To insert user to database

	public boolean saveUser(User user) {
		boolean saved = false;
		try {

			String query = "insert into tech_user(name,email,password,gender,about,profile) values(?,?,?,?,?,?)";

			PreparedStatement pst = this.con.prepareStatement(query);

			pst.setString(1, user.getName());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPassword());
			pst.setString(4, user.getGender());
			pst.setString(5, user.getAbout());
			pst.setString(6, user.getProfile());

			pst.executeUpdate();
			saved = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return saved;

	}

	public User getUserByEmailAndPassword(String email, String Password) {
		User user = null;

		try {
			String query = "select * from tech_user where email=? and password=?";
			PreparedStatement pst = this.con.prepareStatement(query);

			pst.setString(1, email);
			pst.setString(2, Password);

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				user = new User();

				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("rdate"));
				user.setProfile(rs.getString("profile"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;
	}

	public boolean updateUser(User user) {
		boolean f = false;

		try {
			String query = "update tech_user set name=?, email=?, password=?, gender=?, about=?, profile=? where id=?";

			PreparedStatement pst = this.con.prepareStatement(query);

			pst.setString(1, user.getName());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPassword());
			pst.setString(4, user.getGender());
			pst.setString(5, user.getAbout());
			pst.setString(6, user.getProfile());
			pst.setInt(7, user.getId());

			pst.executeUpdate();

			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;

	}

	public User getUserByuserId(int userId) {
		User user = null;

		try {
			String query = "select * from tech_user where id=?";
			PreparedStatement pst = this.con.prepareStatement(query);

			pst.setInt(1, userId);

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				user = new User();

				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setGender(rs.getString("gender"));
				user.setAbout(rs.getString("about"));
				user.setDateTime(rs.getTimestamp("rdate"));
				user.setProfile(rs.getString("profile"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;

	}
}
