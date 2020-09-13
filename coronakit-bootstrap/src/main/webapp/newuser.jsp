<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Corona Kit-New User(user)</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp" />
		<hr />
		<form action="user?action=insertuser" method="post">
			<label>Name</label> : <input type="text" name="pname"
				required="required" placeholder="Guest Name" /> <br /> 
			<label>Email Address</label> : <input type="email" name="pemail" required
				placeholder="Email Address" /> <br /> 
			<label>Phone Number</label>	: <input type="text" name="pcontact" required
				oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/\./, '');"
				placeholder="Mobile Number" maxlength="10"
				pattern="[1-9]{1}[0-9]{9}" /> <br />
			<div align="right">
				<a href="admin?action=logout"> <input type="button"
					value="Cancel" />
				</a> <input type="submit" value="Add New User">
			</div>
		</form>
		<hr />
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>