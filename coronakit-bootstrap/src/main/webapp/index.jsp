<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Corona Kit-Home</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp" />
		<hr />
		<h2>Admin Login</h2>
		<form action="admin?action=login" method="post">
			<p class="text-danger">${errorMessage}</p>
			<div>
				<div>
					<label for="loginid">Enter login Id</label>
				</div>
				<div>
					<input type="text" id="loginid" name="loginid" placeholder="User name">
				</div>
			</div>
			<div>
				<div>
					<label for="password">Enter password</label>
				</div>
				<div>
					<input type="password" id="password" name="password" placeholder="Password">
				</div>
			</div>
			<div>
				<div>
					<input type="submit" value="Login" title="Click to Login">
				</div>
			</div>
		</form>
		<hr />
		<div>
			<a href="user?action=newuser"><button>Create Corona Kit</button></a>
		</div>
		<hr />
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>