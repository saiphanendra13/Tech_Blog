<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Like"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<%
User user=(User)session.getAttribute("currentUser");
int userId=user.getId();
%>

<style>
 .scrl {
                margin:5px;
                padding:5px;
                width: 110%;
                height: 800px;
                overflow: auto;
                text-align:justify;
            }
            
            
body{
background-color: #cfd8dc;
}
</style>


<div class="container scrl">
<div class="row">


<%
Thread.sleep(500);
PostDao pdao=new PostDao(ConnectionProvider.getConnection());
String check=request.getParameter("flag");

List<Post> posts=new ArrayList<Post>();

if(check.equals("postedByMe")){
	posts=pdao.getPostsByUserId(userId);
}
else if(check.equals("likedByMe")){
	LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
	List<Like> myLikes=ld.getLikesByUserId(userId);
	for(Like lik:myLikes){
		Post p=pdao.getPostByPostId(lik.getPid());
		posts.add(p);
	}
} 

if(posts.size()==0){
	out.println("<h3 class='display-2 text-center mt-5'>No Posts available to dispaly...</h3>");
	return;
}

for(Post post:posts){
%>
<div class="col-md-6 mt-3">
	<div class="card">
	<img class="card-img-top" src="post_pics/<%=post.getpPic()%>" alt="Card image cap" style="height:200px">
		<div class="card-body">
			<b><%=post.getpTitle()%></b>
			<%
			String dis="";
			String content=post.getpContent().trim();
			if(!content.isEmpty()){
				if(content.length()>45){
					dis=content.substring(0,45)+" ...";
				}
				else{
					dis=content;
				}
			} %>
			<p><%=dis%></p>
			
					
		</div>
		<div class="card-footer bg-light" style="">
			<%
			
			LikeDao likedao=new LikeDao(ConnectionProvider.getConnection());
			Like like=new Like(post.getPid(),user.getId());
			boolean flag=likedao.isLikedByUser(like);
			if(flag){
				%>
				<a href="#!" class="btn btn-outline-primary btn-sm text-white" style="background-color: blue"><i class="fa fa-thumbs-o-up"><span> <%=likedao.countLikeOnPost(post.getPid()) %></span></i></a>
				<%
				} else{
					%>
					<a href="#!" class="btn btn-outline-primary btn-sm" style=""><i class="fa fa-thumbs-o-up"><span> <%=likedao.countLikeOnPost(post.getPid()) %></span></i></a>	
					<%
				}
			CommentDao cdao=new CommentDao(ConnectionProvider.getConnection());
			%>
			<a href="#!" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"><span> <%=cdao.countCommentOnPost(post.getPid()) %></span></i></a>
			<a href="show_blog_page.jsp?postId=<%=post.getPid() %>" class="btn btn-outline-primary btn-sm">Read More..</a>
		
		</div>
	
	</div>

</div>

<%
}
%>

</div>
</div>