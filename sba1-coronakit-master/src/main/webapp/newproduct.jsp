<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Corona Kit-Add New Product(Admin)</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<hr />
	<div align="right">
		<a href="admin?action=logout"><button>Logout</button></a>
	</div>
	<form action="admin?action=insertproduct" method="post">
		<label>Enter Product Name</label> : <input type="text" name="pname" />
		<br /> <label>Enter Product Cost</label> : <input type="text"
			name="pcost" /> <br /> <label>Enter Product Description</label> : <input
			type="text" name="pdesc" /> <br />
		<div align="right">
			<a href="admin?action=list"> <input type="button" value="Back" />
			</a> <input type="submit" value="Add" />
		</div>
	</form>
	<hr />
	<jsp:include page="footer.jsp" />
</body>
</html>