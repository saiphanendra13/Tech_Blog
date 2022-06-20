package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.CommentDao;
import com.tech.blog.dao.LikeDao;
import com.tech.blog.entities.Comment;
import com.tech.blog.entities.Like;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class CommentServlet
 */

public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		try(PrintWriter out=response.getWriter()){
			
			
			int commentId=Integer.parseInt(request.getParameter("commentId"));
			
			CommentDao dao=new CommentDao(ConnectionProvider.getConnection());
			String msg="";
			
			if(dao.deleteComment(commentId)) {
				msg="success";
			}
			else {
				msg="Comment not Deleted";
			}
			
			out.println(msg);
	}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		try(PrintWriter out=response.getWriter()){
			String desc=request.getParameter("description");
			
			int postId=Integer.parseInt(request.getParameter("pid"));
			int userId=Integer.parseInt(request.getParameter("userId"));
			
			Comment com=new Comment(desc, postId, userId);
			
			CommentDao dao=new CommentDao(ConnectionProvider.getConnection());
			String msg="";
			if(dao.addComment(com)) {
				msg="success";
			}
			else {
				msg="Comment not updated";
			}
			
			out.println(msg);
	}

}
}
