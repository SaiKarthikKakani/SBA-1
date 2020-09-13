<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Corona Kit-Add New Product(Admin)</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp" />
		<hr />
		<div align="right">
			<a href="admin?action=logout"><button>Logout</button></a>
		</div>
		<form action="admin?action=insertproduct" method="post">
			<label>Enter Product Name</label> : <input type="text" name="pname" required/>
			<br /> <label>Enter Product Cost</label> : <input type="text"
				name="pcost" required/> <br /> <label>Enter Product Description</label> :
			<input type="text" name="pdesc" required/> <br />
			<div align="right">
				<a href="admin?action=list"> <input type="button" value="Back" />
				</a> <input type="submit" value="Add" />
			</div>
		</form>
		<hr />
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>