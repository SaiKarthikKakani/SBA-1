<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Corona Kit-Edit Product(Admin)</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div align="right">
		<a href="admin?action=logout"><button>Logout</button></a>
	</div>
	<hr />
	<%
		List<String> singleProductDetails = (List<String>) request.getAttribute("productDetails");
	%>
	<form action="admin?action=updateproduct&id=${productId}" method="post">
		<div>
			<label>Product Name</label> : <input type="text" name="pname"
				value="<%=singleProductDetails.get(0)%>" /> <br /> <label>Cost</label>
			: <input type="text" name="pcost"
				value="<%=singleProductDetails.get(1)%>" /> <br /> <label>Product
				Description</label> : <input type="text" name="pdesc"
				value="<%=singleProductDetails.get(2)%>" /> <br />
			<div align="right">
				<input type="submit" value="Submit" />
			</div>
		</div>
	</form>
	<div align="right">
		<a href="admin?action=list">
			<input type="submit" value="Back" />
		</a>
	</div>
	<hr />
	<jsp:include page="footer.jsp" />
</body>
</html>