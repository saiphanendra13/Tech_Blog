<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page isErrorPage="true" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sorry ! Something went wrong</title>

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
<div class="container text-center ">
<img alt="" src="img/error.jpg" class="img-fluid" width="500" height="400">
<p><%= exception %></p>
<h3 class="display-3" >Sorry!!! Something went wrong</h3>
<a href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home</a>
</div>



</body>
</html>