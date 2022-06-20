<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Profile</title>

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


</head>
<body>
	<%
	// Getting login User Details
	User user = (User) session.getAttribute("currentUser");
	if (user == null) {
		response.sendRedirect("login_page.jsp");
	}
	%>

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
						class="fa fa-bell-o"></span> Learn Code <span class="sr-only">(current)</span></a>
				</li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="fa fa-check-circle-o"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
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
						Message msg=(Message)session.getAttribute("msg");
						if(msg!=null){
							%>
	<div class="alert <%= msg.getCssClass() %>" role="alert">
		<%= msg.getContent() %>
	</div>
	<%
							session.removeAttribute("msg");
							}
							%>



	<!-- Main Body of the page -->
	<main>
		<div class="container">
			<div class="row mt-5">
				<!-- First column -->
				<div class="col-md-3">
					<!-- Show all categories -->
					<div class="list-group text-center">
						<a href="#" onclick="getPosts(0,this)" class="main_cat_link list-group-item list-group-item-action active">All Posts</a>
						<%
        		PostDao p=new PostDao(ConnectionProvider.getConnection());
        		
        		ArrayList<Category> c = p.getAllCategories();
        		
        		for(Category category:c){
        		%>						
						<a href="#" onclick="getPosts(<%=category.getCid()%>,this)" class="main_cat_link list-group-item list-group-item-action"><%=category.getcName() %></a> 
					<%
        		}
					%>
					
					</div>
					
			<div class="row mt-5">
			<div class="col-md-12 text-center">
			
			<hr>
			<h5>Go To :</h5>
			<div class="list-group">
  		<a href="#" onclick="myPosts('postedByMe',this)" class="main_cat_link list-group-item list-group-item-action">My Posts</a>
  		<a href="#" onclick="myPosts('likedByMe',this)" class="main_cat_link list-group-item list-group-item-action">Posts you've Liked</a>
  	</div>
			
			</div>
			</div>
				</div>

				<!-- Second column -->
				<div class="col-md-9">
					<!-- Show posts -->
					<div class="container text-center mt-5" id="show_post_loader" style="">
						<i class="fa fa-refresh fa-spin fa-4x"></i>
						<h3> Loading..</h3>
					</div>
					
					<div class="container-fluid" id="show_posts_container"></div>					

				</div>

			</div>


		</div>
		
	</main>

	<!--end of Main Body of the page -->


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
        		PostDao pdao=new PostDao(ConnectionProvider.getConnection());
        		
        		ArrayList<Category> categories = pdao.getAllCategories();
        		
        		for(Category cat:categories){
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
							<textarea name="dopost_code" rows="" cols="" class="form-control"
								placeholder="Enter Your Code (if any)" style="height: 150px"></textarea>
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
	
	
	</script>
	
	<!-- Load posts using ajax -->
	<script type="text/javascript">
	
	function getPosts(catid, temp) {
		//temp having reference of the class
		
		$('#show_post_loader').show();
		$('#show_posts_container').hide();
		
		$('.main_cat_link').removeClass("active");
		
		$.ajax({
			url:"load_posts.jsp",
			data:{cid:catid},
			success:function(data, textStatus, jqXHR){
				$('#show_post_loader').hide();
				$('#show_posts_container').show();
				$('#show_posts_container').html(data);
				$(temp).addClass("active");
			},
			error: function(jqXHR, textStatus, errorThrown){
				
			}
		})
		
	}
	
	$(document).ready(function(e){
		//all posts reference
		let allPostRef=$('.main_cat_link')[0]
		getPosts(0, allPostRef);
	})
	//flag postedByMe for posts by current user and 
	//flag likedByMe for posts liked by current user 
	function myPosts(flag, temp){
		$('#show_post_loader').show();
		$('#show_posts_container').hide();
		
		$('.main_cat_link').removeClass("active");
		
		$.ajax({
			url:"load_currentuser_posts.jsp",
			data:{flag:flag},
			success:function(data, textStatus, jqXHR){
				$('#show_post_loader').hide();
				$('#show_posts_container').show();
				$('#show_posts_container').html(data);
				$(temp).addClass("active");
			},
			error: function(jqXHR, textStatus, errorThrown){
				
			}
		})
	}
	
	
	
	</script>

</body>
</html>