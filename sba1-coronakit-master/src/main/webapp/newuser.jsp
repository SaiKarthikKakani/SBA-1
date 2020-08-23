<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Corona Kit-New User(user)</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<hr/>
	<form action="user?action=insertuser" method="post">
		<label>Name</label> : <input type="text" name="pname" />
		<br/>
		<label>Email Address</label> : <input type="email" name="pemail" />
		<br/>
		<label>Phone Number</label> : <input type="tel" name="pcontact" />
		<br/>
		<div align="right">
			<a href="admin?action=logout">
				<input type="button" value="Cancel" />
			</a>
			<input type="submit" value="Add New User">
		</div>
	</form>
<hr/>	
	<jsp:include page="footer.jsp"/>
</body>
</html>