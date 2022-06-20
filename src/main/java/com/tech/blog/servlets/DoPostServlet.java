package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class DoPostServlet
 */

@MultipartConfig
public class DoPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DoPostServlet() {
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
			
			int cid=Integer.parseInt(request.getParameter("dopost_cid"));
			String pTitle=request.getParameter("dopost_title");
			String pContent=request.getParameter("dopost_content");
			String pCode=request.getParameter("dopost_code");
			Part part=request.getPart("dopost_pic");
			String pPic=part.getSubmittedFileName();
			
			if(pPic.isEmpty() || pPic==null) {
				pPic="default.png";
			}
			
			HttpSession session=request.getSession();
			
			User user=(User) session.getAttribute("currentUser");
			
			Post post=new Post(pTitle, pContent, pCode, pPic, cid, user.getId());
			
			PostDao dao=new PostDao(ConnectionProvider.getConnection());
			
			
			String msg="";
			
			if(dao.savePost(post)) {
				
				
				if(! pPic.equals("default.png")) {
					String filePath="C:/Users/BSP/eclipse-workspace/TechnicalBlog/src/main/webapp/post_pics/";
					if(Helper.saveFile(part.getInputStream(), filePath+pPic)) {
						//post pic saved
						msg="success";
					}
				}
				msg="success";
				
			}
			else {
				msg="Post Not Saved...";
			}
		out.println(msg);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
