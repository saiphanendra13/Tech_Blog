<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register page</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="css/mystyle.css" type="text/css" />

<style type="text/css">
.banner-background {
	clip-path: polygon(0% 15%, 0 0, 15% 0%, 85% 0%, 100% 0, 100% 15%, 100% 85%, 87% 90%
		, 73% 100%, 25% 100%, 15% 91%, 0% 85%);
}
</style>


</head>
<body>

	<!-- Navbar  -->
	<%@include file="normal_navbar.jsp"%>

	<!-- Register Module -->

	<main class="primary-background banner-background py-3 p-4" style="">
		<div class="container">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card">
						<div class="card-header text-center text-white primary-background">
							<span class="fa fa-user-plus fa-3x"></span>
							<p>Register Here</p>
						</div>
						<div class="card-body">
							<form id="RegisterForm" action="Register" method="post" enctype="multipart/form-data">

								<div class="form-group">
									<label for="user_name">User Name</label> <input
										name="user_name" type="text" class="form-control"
										id="user_name" placeholder="Enter Name" required>

								</div>

								<div class="form-group">
									<label for="user_email">Email address</label> <input
										name="user_email" type="email" class="form-control"
										id="user_email" aria-describedby="emailHelp"
										placeholder="Enter email" required> <small id="emailHelp"
										class="form-text text-muted">We'll never share your
										email with anyone else.</small>
								</div>
								<div class="form-group">
									<label for="password">Password</label> <input
										name="user_password" type="password" class="form-control"
										id="password" placeholder="Password" required>
								</div>

								<div class="form-group">
									<label for="gender">Select Gender :</label> <input type="radio"
										name="user_gender" value="Male"> Male <input
										type="radio" name="user_gender" value="Female"> Female
								</div>

								<div class="form-group">
									<textarea name="user_about" id="about" rows="5"
										class="form-control"
										placeholder="Enter Something About Yourself"></textarea>
								</div>
								<div class="form-group">
									<label for="profile_pic">Profile Picture: </label> 
									<input name="profile_pic" type="file" class="form-control"
										id="profile_pic">
								</div>
								<br>
								<div class="form-check">
									<input name="check" type="checkbox" class="form-check-input"
										id="Check"> <label class="form-check-label"
										for="Check">Agree terms & Conditions</label>
								</div>
								<br>
								<div class="container text-center" id="loader"
									style="display: none">
									<span class="fa fa-refresh fa-spin fa-3x"></span>
									<h4>Please wait...</h4>
								</div>
								<button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
							</form>
						</div>

					</div>
				</div>
			</div>
		</div>



	</main>
	<br>
	<br>



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

	<script src="js/myjs.js" type="text/javascript"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<script>
	
	
	$(document).ready(function(){
		
		
		$('#RegisterForm').on('submit', function (event) {
			event.preventDefault();
			
			let form=new FormData(this);
			
			$('#submit-btn').hide();
			$('#loader').show();
			
			//send form to reg servlet
			
			$.ajax({
				url:"Register",
				type:"POST",
				data:form,				
				success:function(data, textStatus, jqXHR){
					console.log(data)
					$('#submit-btn').show();
					$('#loader').hide();
					
					if(data.trim() === 'Success'){
					swal("Registered Successfully...We are going to redirect to Login page")
					.then((value) => {
					  window.location="login_page.jsp"; });
						}
					
					else
					{
						swal(data)
					}
									
				},				
				error:function(jqXHR, textStatus, errorThrown){
				console.log(jqXHR)
				$('#submit-btn').hide();
				$('#loader').show();
				
				swal("Something went wrong...try again")
				},
				processData:false,
				contentType:false
					
				})
		})
		
		
		
	})
	
	</script>



</body>
</html>