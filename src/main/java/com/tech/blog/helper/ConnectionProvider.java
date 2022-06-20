package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {

	private static Connection con;

	public static Connection getConnection() {

		try {
			if (con == null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				// creating connection
				String user = "root";
				String password = "1313";
				String url = "jdbc:mysql://localhost:3306/TechBlog";

				con = DriverManager.getConnection(url, user, password);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

}
