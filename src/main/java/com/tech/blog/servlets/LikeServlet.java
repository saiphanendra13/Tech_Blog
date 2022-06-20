package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.entities.Like;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class LikeServlet
 */
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikeServlet() {
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
			String operation=request.getParameter("operation");
			
			int postId=Integer.parseInt(request.getParameter("pid"));
			int userId=Integer.parseInt(request.getParameter("uid"));
			
			Like like=new Like(postId,userId);
			
			
			LikeDao dao=new LikeDao(ConnectionProvider.getConnection());
			String msg="";
			if(operation.equals("unlike")) {
				if(dao.deleteLike(like)) {
					msg="unliked";
				}
				
			}else if(operation.equals("like")){
				if(dao.insertLike(like)) {
					msg="liked";
					
				}
			}
			else {
				msg="error";
			}
			
			out.println(msg);
		}
	}

}
