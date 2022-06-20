package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;


import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
			//session 
			HttpSession session=request.getSession();
			
			String name=request.getParameter("user_email");
			String password=request.getParameter("user_password");
			
			UserDao dao=new UserDao(ConnectionProvider.getConnection());
			
			User user=dao.getUserByEmailAndPassword(name, password);
			
			if(user==null) {
				//login error
				Message msg=new Message("Invalid details!! Try with another", "error", "alert-danger");
				
				session.setAttribute("msg", msg);
				
				response.sendRedirect("login_page.jsp");
			}
			else {
				//login Success
				
				session.setAttribute("currentUser", user);
				
				//Redirecting to profile page
				response.sendRedirect("profile_page.jsp");
			}
			
			
			
			
			
			
		}
	}

}
