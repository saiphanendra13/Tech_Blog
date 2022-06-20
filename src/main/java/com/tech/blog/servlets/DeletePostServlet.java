package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Like;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class DeletePostServlet
 */
public class DeletePostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletePostServlet() {
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
			
			
			int postId=Integer.parseInt(request.getParameter("pid"));
			String postPic=request.getParameter("postPic");
			
			
			PostDao dao=new PostDao(ConnectionProvider.getConnection());
			String msg="";
			if(dao.deletePostByPostId(postId)) {
				if (!postPic.equals("default.png")) {
					String folderPath="C:/Users/BSP/eclipse-workspace/TechnicalBlog/src/main/webapp/post_pics/";
					if(Helper.deleteFile(folderPath+postPic)) {
						
						//msg="post pic  deleted...";
						
						}
					msg="success";
				}
			}
			else {
				msg="post not deleted";
			}
			
			out.println(msg);
		}
	}
	

}
