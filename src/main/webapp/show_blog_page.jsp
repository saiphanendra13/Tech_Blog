<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.entities.Like"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>



<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>

<%
int postId = Integer.parseInt(request.getParameter("postId"));

PostDao pdao = new PostDao(ConnectionProvider.getConnection());

Post post = pdao.getPostByPostId(postId);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=post.getpTitle()%></title>
<!-- Css -->

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="css/mystyle.css" type="text/css" />

<style type="text/css">
.banner-background {
	clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 86%, 74% 100%, 35% 91%, 0 100%, 0%
		30%);
}
</style>

<style>
.post_title {
	font-weight: 450;
	font-size: 30px;
}

.post_content {
	font-weight: 400;
	font-size: 15px;
}

.post_code {
	font-weight: 300;
	font-size: 13px;
}

.post_user_info {
	font-weight: 360;
	font-size: 18px;
}

.post_date {
	font-weight: 300;
	font-style: italic;
}

.post_user_row {
	border: 0.5px solid #bdbdbd;
	padding-top: 15px;
}

body {
	background-color: #b0bec5;
}
</style>

</head>
<body>


	<!-- NavBar start -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span
			class="fa fa-asterisk"></span>Tech Blog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="profile_page.jsp"><span
						class="fa fa-bell-o"></span> Posts <span class="sr-only">(current)</span></a>
				</li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarCategoriesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="fa fa-check-circle-o"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarCategoriesDropdown">
						<%
        		PostDao p=new PostDao(ConnectionProvider.getConnection());
        		
        		ArrayList<Category> c = p.getAllCategories();
        		
        		for(Category category:c){
        		%>						
						<a href="#!" onclick="getPosts(<%=category.getCid()%>,this)" class="main_cat_link list-group-item list-group-item-action"><%=category.getcName() %></a> 
					<%
        		}
					%>
					</div></li>

				<li class="nav-item"><a class="nav-link" href="#"><span
						class="fa fa-address-book-o"></span> Contact</a></li>

				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#do_post_modal"><span
						class="fa fa-edit"></span> Do Post</a></li>

			</ul>
			<ul class="navbar-nav mr-right">

				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#profile_Modal"><span
						class="fa fa-user-o"></span> <%=user.getName()%> </a></li>

				<li class="nav-item"><a class="nav-link" href="Logout"><span
						class="fa fa-sign-out"></span> Logout</a></li>

			</ul>


		</div>
	</nav>

	<!-- NavBar End  -->

	<!--  Invalid details error message  -->
	<%
	Message msg = (Message) session.getAttribute("msg");
	if (msg != null) {
	%>
	<div class="alert <%=msg.getCssClass()%>" role="alert">
		<%=msg.getContent()%>
	</div>
	<%
	session.removeAttribute("msg");
	}
	%>


	<!-- Main content of body -->

	<div class="container">
		<div class="row py-4">
			<div class="col-md-8 offset-md-2">
				<div class="card">
					<div class="card-header text-white"
						style="background-color: #0277bd">
						<h4 class="post_title"><%=post.getpTitle()%></h4>
					</div>
					<div class="card-body">
						<div class="container text-center mb-4">
							<img class="card-img-top img-fluid"
								src="post_pics/<%=post.getpPic()%>" alt="Card image cap"
								style="width: 500px; height: 400px;"> <br>

						</div>

						<div class="row post_user_row mb-3">
							<div class="col-md-8">
								<%
								UserDao udao = new UserDao(ConnectionProvider.getConnection());
								User postedByUser = udao.getUserByuserId(post.getUserId());
								%>
								<p class="post_user_info">
									Posted By :
									<%=postedByUser.getName()%>
									<a href="#!" data-toggle="modal"
										data-target="#posted_by_user_profile_Modal">(details)</a>
								</p>
							</div>
							<div class="col-md-4">
								<p class="post_date">
									On:
									<%=DateFormat.getDateTimeInstance().format(post.getpDate())%></p>
							</div>
						</div>


						<p style="color: blue;">
							<i class="fa fa-star-o"></i> Description : <br>
						</p>
						<p class="post_content"><%=post.getpContent()%></p>
						<br>

						<div class="post_code">
							<p style="color: blue;">
								<i class="fa fa-code"></i> Code : <br>
							</p>
							<pre><%=post.getpCode()%></pre>
						</div>
					</div>
					<div class="card-footer" style="">
						<%
						
						LikeDao likedao = new LikeDao(ConnectionProvider.getConnection());
						Like like = new Like(post.getPid(), user.getId());
						boolean flag = likedao.isLikedByUser(like);

						if (flag) {
						%>
						<a href="#!" id="like"
							onclick="doLike(<%=post.getPid()%>, <%=user.getId()%>,this)"
							class="btn btn-outline-primary btn-sm text-white"
							style="background-color: blue"><i class="fa fa-thumbs-o-up"><span>
									<%=likedao.countLikeOnPost(post.getPid())%></span></i></a> 
							
							<a href="#!"
							id="unlike"
							onclick="doLike(<%=post.getPid()%>, <%=user.getId()%>, this)"
							class="btn btn-outline-primary btn-sm" style="display: none"><i
							class="fa fa-thumbs-o-up"><span> <%=likedao.countLikeOnPost(post.getPid()) - 1%></span></i></a>
						<%
						} else {
						%>
						<a href="#!" id="unlike"
							onclick="doLike(<%=post.getPid()%>, <%=user.getId()%>, this)"
							class="btn btn-outline-primary btn-sm" style=""><i
							class="fa fa-thumbs-o-up"><span> <%=likedao.countLikeOnPost(post.getPid())%></span></i></a>
						<a href="#!" id="like"
							onclick="doLike(<%=post.getPid()%>, <%=user.getId()%>,this)"
							class="btn btn-outline-primary btn-sm text-white"
							style="background-color: blue; display: none"><i
							class="fa fa-thumbs-o-up"><span> <%=likedao.countLikeOnPost(post.getPid()) + 1%></span></i></a>
						<%
						}
						CommentDao cdao=new CommentDao(ConnectionProvider.getConnection());
						%>
						<a href="#!" id="post_comments"
							onclick="showComments(<%=post.getPid()%>)"
							class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"> <span class="comment_count"> <%=cdao.countCommentOnPost(post.getPid())%></span></i></a>
						<% if (post.getUserId()==user.getId()){
						%>
						<div class="text-right">
						<a href="#!" onclick="deletePost(<%=post.getPid() %>, '<%=post.getpPic()%>')" class="btn btn-outline-primary btn-sm">Delete Post</a>
						</div>
						<%} %>
						
						</div>


				</div>
			</div>

		</div>
		<div class="container">
			<div class="row py-5">
				<div class="col-md-8 offset-md-2">
					<div class="card">

						<div class="card-body">
							<label>Add Comment : </label>
							<textarea id="newComment" rows="2" cols="" class="form-control"
								placeholder="write your comments here"></textarea>
							<div class="text-right">
								<a href="#!" onclick="addComment(<%=post.getPid()%>, <%=user.getId()%>)" class="btn btn-outline-primary btn-sm">Add
									Comment</a>
							</div>
						</div>
						<div id="comments_display" class="card-footer py-5"></div>
					</div>
				</div>
			</div>
		</div>
</div>


		<!-- end of Main content of body -->

		<!-- posted by user details modal -->


		<!-- Modal -->
		<div class="modal fade" id="posted_by_user_profile_Modal"
			tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
			aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header primary-background text-white">
						<h5 class="modal-title" id="exampleModalLabel">Technical Blog</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="container text-center">
							<img alt="" src="profile_pics/<%=postedByUser.getProfile()%>"
								width="150" height="150" style="border-radius: 50%">
							<h5 class="modal-title" id="exampleModalLabel"><%=postedByUser.getName()%></h5>
							<!-- Details table -->
							<table class="table">

								<tbody>

									<tr>
										<th scope="row">Email :</th>
										<td><%=postedByUser.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=postedByUser.getGender()%></td>

									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=postedByUser.getAbout()%></td>

									</tr>
									<tr>
										<th scope="row">Registered On :</th>
										<td><%=postedByUser.getDateTime()%></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button"
							class="btn btn-secondary form-control btn-sm"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>



		<!-- End of posted by user details -->


		<!-- Profile modal -->

		<!-- Modal -->
		<div class="modal fade" id="profile_Modal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header primary-background text-white">
						<h5 class="modal-title" id="exampleModalLabel">Technical Blog</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="container text-center">
							<img alt="" src="profile_pics/<%=user.getProfile()%>" width="150"
								height="150" style="border-radius: 50%">
							<h5 class="modal-title" id="exampleModalLabel"><%=user.getName()%></h5>
							<br>
							<!-- Details table -->
							<div id="profile_details">
								<table class="table">

									<tbody>
										<tr>
											<th scope="row">ID :</th>
											<td><%=user.getId()%></td>

										</tr>
										<tr>
											<th scope="row">Email :</th>
											<td><%=user.getEmail()%></td>

										</tr>
										<tr>
											<th scope="row">Gender :</th>
											<td><%=user.getGender()%></td>

										</tr>
										<tr>
											<th scope="row">Status :</th>
											<td><%=user.getAbout()%></td>

										</tr>
										<tr>
											<th scope="row">Registered On :</th>
											<td><%=user.getDateTime()%></td>
										</tr>
									</tbody>
								</table>
							</div>

							<!-- Profile edit -->

							<div id="profile_edit" style="display: none">

								<h4>Please Edit Carefully</h4>

								<form action="EditProfileDetails" method="post"
									enctype="multipart/form-data">

									<table class="table">

										<tr>
											<td>ID :</td>
											<td><%=user.getId()%></td>

										</tr>
										<tr>
											<td>Email :</td>
											<td><%=user.getEmail()%></td>

										</tr>
										<tr>
											<td>Name :</td>
											<td><input type="text" class="form-control"
												name="user_name" value="<%=user.getName()%>"></td>

										</tr>
										<tr>
											<td>Password :</td>
											<td><input type="password" class="form-control"
												name="user_password" value="<%=user.getPassword()%>"></td>

										</tr>

										<tr>
											<td>Gender :</td>
											<td><%=user.getGender().toUpperCase()%></td>
										</tr>

										<tr>
											<td>About :</td>
											<td><textarea rows="4" class="form-control"
													name="user_about"><%=user.getAbout()%></textarea></td>
										</tr>

										<tr>
											<td>New Profile:</td>
											<td><input type="file" name="user_profile"
												class="form-control"></td>
										</tr>



									</table>

									<div class="container">
										<button type="submit" class="btn btn-outline-primary">Save</button>
									</div>
								</form>

							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button id="profile_edit_button" type="button"
							class="btn btn-primary">Edit</button>
					</div>
				</div>
			</div>
		</div>

		<!-- end of Profile modal -->


		<!-- Do Post Modal -->


		<!-- Modal -->
		<div class="modal fade" id="do_post_modal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header primary-background">
						<h5 class="modal-title" id="exampleModalLabel">Provide the
							post details</h5>
						<button id="dopost_close" type="button" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form id="dopost_form" action="DoPost" method="post">
							<div class="form-group">
								<select class="form-control" name="dopost_cid" required>
									<option value="">-- Select Category --</option>

									<%
									PostDao pd = new PostDao(ConnectionProvider.getConnection());

									ArrayList<Category> categories = pd.getAllCategories();

									for (Category cat : categories) {
									%>
									<option value="<%=cat.getCid()%>"><%=cat.getcName()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="form-group">
								<input name="dopost_title" type="text"
									placeholder="Enter Post Title" class="form-control" required />
							</div>
							<div class="form-group">
								<textarea name="dopost_content" rows="" cols=""
									class="form-control" placeholder="Post Description"
									style="height: 200px" required></textarea>
							</div>

							<div class="form-group">
								<textarea name="dopost_code" rows="" cols=""
									class="form-control" placeholder="Enter Your Code (if any)"
									style="height: 150px"></textarea>
							</div>

							<div class="form-group">
								<label>Select your pic : </label> <input type="file"
									class="form-control" name="dopost_pic">
							</div>

							<div class="container text-center">
								<button type="submit" class="btn btn-outline-primary">Post</button>
							</div>

						</form>
					</div>

				</div>
			</div>
		</div>

		<!-- end of Do post Modal -->




		<!-- java Script -->

		<script src="https://code.jquery.com/jquery-3.6.0.min.js"
			integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
			crossorigin="anonymous"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
			integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
			crossorigin="anonymous"></script>
		<script
			src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
			integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
			crossorigin="anonymous"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


		<script src="js/myjs.js" type="text/javascript"></script>


		<!-- like system -->
		<script type="text/javascript">
	
	function doLike(pid, uid, refer){
		
		let likeId=refer.getAttribute("id");
		let val={};
		//to unlike post 
		if(likeId=='like'){
			val={
					pid: pid,
					uid:uid,
					operation:'unlike'
				}
			
		}
		//to like post
		else{
			val={
					pid: pid,
					uid:uid,
					operation:'like'
				}
		}
		
		$.ajax({
			url:"LikeServlet",
			type:"POST",
			data: val,
			success: function(data, textStatus, jqXHR){
				
				if(data.trim()==='unliked'){
					$("#like").hide();
					$("#unlike").show();
					
				}else if(data.trim()==='liked'){
					$("#unlike").hide();
					$("#like").show();
					
		
				}
				else{
					
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				
			}
		})
		
	}
	</script>

		<script type="text/javascript">
	
	//Profile details editing  button
	
		$(document).ready(function() {

			let editStatus = false;

			$('#profile_edit_button').click(function() {

				if (editStatus == false) {
					$('#profile_details').hide()
					$('#profile_edit').show()
					editStatus = true
					$(this).text('Back')
				} else {
					$('#profile_details').show()
					$('#profile_edit').hide()
					editStatus = false
					$(this).text('Edit')
				}

			})

		})
	</script>

		<!-- Add post script -->

		<script type="text/javascript">
	
	$(document).ready(function(e){
		
		$('#dopost_form').on("submit", function(event){
			//after form submitted
			event.preventDefault();
			let form=new FormData(this);
			
			$.ajax({
				url:"DoPost",
				type:"POST",
				data: form,
				
				success: function(data, textStatus, jqXHR){
					if(data.trim()==='success'){
					swal("Good job!", "Post Saved Successfully", "success");
					$('#dopost_form')[0].reset();
					$('#dopost_close').click();
					}
					else{
						swal("Error!!", "Something went wrong" , "error");
					}
						
				}, 
				error: function(jqXHR, textStatus, errorThrown){
					swal("Error!!", "Post Not Saved..." , "error");
				},
				
				processData:false,
				contentType:false
				
			})
			
		})
		
		
	})
	
	function deletePost(pid,postPic){
		$.ajax({
			url:"DeletePostServlet",
			type:"POST",
			data: {pid:pid,
				postPic:postPic
				},
			success: function(data, textStatus, jqXHR){
				if(data.trim()==='success'){
					swal("Post Deleted Successfully...")
					.then((value) => {
					  window.location="profile_page.jsp"; });
				}else{
					swal(data);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				swal("Error ! Something Went Wrong..");
			}
		})
	}
	
	</script>
	
	<!-- Comments -->
	<script type="text/javascript">
	function showComments(pid){
		
		$.ajax({
			url:"load_comments.jsp",
			data: {pid:pid},
			success: function(data, textStatus, jqXHR){
					$('#comments_display').html(data);
					$('#comments_display').show();
					
				
			},
			error: function(jqXHR, textStatus, errorThrown){
				
			}
		})
	}
	
	showComments(<%=post.getPid()%>);
	
	function addComment(pid, userId){
		let comElement=document.getElementById("newComment");
		let val=comElement.value;
		if((val.trim().length)>0){
			let obj={
					pid:pid,
					userId:userId,
					description:val
			}
			$.ajax({
				url:"CommentServlet",
				type:"POST",
				data: obj,
				success: function(data, textStatus, jqXHR){
					if(data.trim()==='success'){
						showComments(pid);
						comElement.value='';
						let c=$('.comment_count').html();
						c++;
						$('.comment_count').html(c);
						swal("Comment Added Successfully..");
					}else{
						swal(data);
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					swal("Error ! Something Went Wrong..");
				}
			})
		}
		else{
			comElement.value='';
		}
		
	}
	
	function deleteComment(comId,pid){
		$.ajax({
			url:"CommentServlet",
			type:"GET",
			data: {commentId:comId},
			success: function(data, textStatus, jqXHR){
				if(data.trim()==='success'){
					showComments(pid);
					let c = $('.comment_count').html();
					c--;
					$('.comment_count').html(c);
					swal("Comment Deleted Successfully..");
				}else{
					swal(data);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				swal("Error ! Something Went Wrong..");
			}
		})
	}
	</script>
	<script>
	function getPosts(pid,this) {
        updateSubContent("profile_page.jsp");
    });
	
	</script>
	
</body>
</html>