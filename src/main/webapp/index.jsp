<!DOCTYPE html>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Technical Blog</title>

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
	clip-path: polygon(0 0, 100% 0, 100% 30%, 100% 86%, 74% 100%, 35% 91%, 0 100%, 0% 30%);
}
</style>

</head>
<body>


	<!-- nav bar -->
	<%@include file="normal_navbar.jsp"%>

	<!-- banner -->

	<div class="container-fluid m-0 p-0 banner-background">
		<div class="jumbotron primary-background text-white">
			<div class="container">
				<h3 class="display-3">Welcome to Tech Blog</h3>
				<p>Welcome to Technical blog, World of technology</p>
				<p>Technology is the sum of any techniques, skills, methods, and
					processes used in the production of goods or services or in the
					accomplishment of objectives, such as scientific investigation.
					Technology can be the knowledge of techniques, processes, and the
					like, or it can be embedded in machines to allow for operation
					without detailed knowledge of their workings.</p>

				<a href="register_page.jsp" class="btn btn-light btn-lg">
					<span class="fa fa-user-plus"></span> Start Now
				</a>
				<a href="login_page.jsp" class="btn btn-light btn-lg">
					<span class="fa fa-user-circle-o fa-spin"></span> Login
				</a>

			</div>
		</div>
	</div>



	<!-- Cards -->

	<div class="container">

		<div class="row mb-3">

			<div class="col-md-4">
				<div class="card">

					<div class="card-body">
						<h5 class="card-title">Java Programing</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="#" class="btn primary-background text-white">Go
							somewhere</a>
					</div>
				</div>

			</div>
			<div class="col-md-4">
				<div class="card">

					<div class="card-body">
						<h5 class="card-title">Java Programing</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="#" class="btn primary-background text-white">Go
							somewhere</a>
					</div>
				</div>

			</div>
			<div class="col-md-4">
				<div class="card">

					<div class="card-body">
						<h5 class="card-title">Java Programing</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="#" class="btn primary-background text-white">Go
							somewhere</a>
					</div>
				</div>

			</div>

		</div>

		<div class="row mb-5">

			<div class="col-md-4">
				<div class="card">

					<div class="card-body">
						<h5 class="card-title">Java Programing</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="#" class="btn primary-background text-white">Go
							somewhere</a>
					</div>
				</div>

			</div>
			<div class="col-md-4">
				<div class="card">

					<div class="card-body">
						<h5 class="card-title">Java Programing</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="#" class="btn primary-background text-white">Go
							somewhere</a>
					</div>
				</div>

			</div>
			<div class="col-md-4">
				<div class="card">

					<div class="card-body">
						<h5 class="card-title">Java Programing</h5>
						<p class="card-text">Some quick example text to build on the
							card title and make up the bulk of the card's content.</p>
						<a href="#" class="btn primary-background text-white">Go
							somewhere</a>
					</div>
				</div>

			</div>

		</div>



	</div>


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


</body>
</html>