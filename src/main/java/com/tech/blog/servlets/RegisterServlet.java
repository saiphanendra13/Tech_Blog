package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class RegisterServlet
 */

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		
		try(PrintWriter out=response.getWriter()){
		
			
		//fetching form data
		
				
		String check=request.getParameter("check");
		
		if(check==null) {
			out.println("please agree terms and conditions");
		}
		else {
		
		
		String name=request.getParameter("user_name");
		String email=request.getParameter("user_email");
		String password=request.getParameter("user_password");
		String gender=request.getParameter("user_gender");
		String about=request.getParameter("user_about");
		Part part = request.getPart("profile_pic");
		String profilePath=part.getSubmittedFileName();
		
		
		
		if(about.trim().isEmpty()) {
			about="Hey! I am using TechBlog";
		}
		if(profilePath.isEmpty() || profilePath==null) {
			profilePath="default.png";
		}
		
		
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		
		User user = new User(name, email, password, gender, about, profilePath);
		
		String msg="";
		if(dao.saveUser(user)) {
			
			if(! profilePath.equals("default.png")) {
				String folderPath="C:/Users/BSP/eclipse-workspace/TechnicalBlog/src/main/webapp/profile_pics/";
				if (Helper.saveFile(part.getInputStream(), folderPath+profilePath)) {
					//out.println("profile picture saved");
					msg="Success";
				}
			}
			
			msg="Success";
			
		}
		else {
			msg="Error ! Please enter valid details...";
		}
		out.println(msg);
		}	
					
	}
	}

}
