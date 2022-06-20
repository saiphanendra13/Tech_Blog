<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Comment"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%
User currentUser=(User)session.getAttribute("currentUser");
UserDao udao=new UserDao(ConnectionProvider.getConnection());
CommentDao comDao=new CommentDao(ConnectionProvider.getConnection());
int postId=Integer.parseInt(request.getParameter("pid"));
List<Comment> comments=comDao.getCommentsByPostId(postId);

if(comments.size()>0){
for(Comment com:comments){
	User commentedBy=udao.getUserByuserId(com.getUserId());
	%>
	
	
	<div class="card mt-2">
		<div class="card-body">
			<p>Commented by : <%=commentedBy.getName()%></p>
			<p>On: <%=com.getComDateTime() %></p>
			<p><%=com.getCommentDesc()%></p>
			<% if (com.getUserId()==currentUser.getId()){
				%>
				<div class="text-right">
					<a href="#!" onclick="deleteComment(<%=com.getCommentId()%>, <%=com.getPostId()%>)" class="btn btn-outline-primary btn-sm">Delete</a>
				</div>
			<%
			}
			%>
		</div>
	</div>


<%}
}else{
	out.println("<h5>No comments</h5>");
}
%>

