package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class EditProfileDetailsServlet
 */

@MultipartConfig
public class EditProfileDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditProfileDetailsServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");

		try (PrintWriter out = response.getWriter()) {
			// fetch to be updated data
			String name = request.getParameter("user_name");
			String password = request.getParameter("user_password");
			String about = request.getParameter("user_about");
			Part part = request.getPart("user_profile");
			String profileName = part.getSubmittedFileName();

			// fetch current user

			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("currentUser");

			User temp = new User();

			temp.setName(name);
			temp.setPassword(password);
			temp.setAbout(about);

			temp.setEmail(user.getEmail());
			temp.setGender(user.getGender());
			temp.setDateTime(user.getDateTime());
			temp.setId(user.getId());

			if (!profileName.isEmpty()) {
				temp.setProfile(profileName);
			} else {
				temp.setProfile(user.getProfile());
			}

			UserDao dao = new UserDao(ConnectionProvider.getConnection());
			
			String msgContent = "";
			String msgCss="";
			String msgType="";

			if (dao.updateUser(temp)) {

				/*
				 * String prevPath=request.getContextPath()+"/profile_pics"+File.separator+user.
				 * getProfile(); String
				 * newPath=request.getRealPath("/")+"profile_pics"+File.separator+temp.
				 * getProfile();
				 */
				
				String folderPath="C:/Users/BSP/eclipse-workspace/TechnicalBlog/src/main/webapp/profile_pics/";

				String prevPath = folderPath+user.getProfile();
				String newPath = folderPath+temp.getProfile();
				
				
				if (! temp.getProfile().equals(user.getProfile())) {
					if (Helper.saveFile(part.getInputStream(), newPath)) {
						msgContent+="profile picture and ";
								
						if (!user.getProfile().equals("default.png")) {
							if(! Helper.deleteFile(prevPath)) {
								
								//msgContent+="Previous profile not deleted...";
								
								}
							}
						}
					else 
					{
							msgContent +="Pic not Updated !!! ";
							msgCss="alert-danger";
					}
				} 
				msgContent+="Details are updated ...";
				msgCss="alert-success";
				msgType="success";
				session.setAttribute("currentUser", temp);
			}
			else {
				msgContent+="profile details not updated...";
				msgCss="alert-danger";
				msgType="error";
			}
			
			
			Message msg=new Message(msgContent, msgType, msgCss);
			session.setAttribute("msg", msg);
			
			response.sendRedirect("profile_page.jsp");

		}
	}

}
