<%@page import="com.iiht.evaluation.coronokit.model.ProductMaster"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Corona Kit-All Products(Admin)</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
th {
	text-align: center;
	background-color: lightgray;
	font-weight: bold;
	text-transform: uppercase;
}
td {
	text-align: center;
}
table {
	margin-top: 5pt;
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<body>
<div class="container">
	<jsp:include page="header.jsp" />
	<div align="right">
		<span><a href="admin?action=logout"><button>Logout</button></a></span>
	</div>
	<hr />

	<a href="admin?action=list">
		<button>Show All Products</button>
	</a>

	<a href="admin?action=newproduct">
		<button>Add New Product</button>
	</a>
	
	<%
		List<ProductMaster> allProductsList = (List<ProductMaster>) request.getAttribute("productMasterList");
	
		if(allProductsList != null) {
	%>

	<table border="1" class="table-striped">
		<thead>
			<tr>
				<th>Product Name</th>
				<th>Cost</th>
				<th>Product Description</th>
				<th colspan="2" />
			</tr>
		</thead>
		<tbody>
		<%
			for (ProductMaster eachProduct : allProductsList) {
		%>
			<tr>
				<td><%=eachProduct.getProductName()%></td>
				<td><%=eachProduct.getCost()%></td>
				<td><%=eachProduct.getProductDescription()%></td>
				<td colspan="2"><a href="admin?action=editproduct&id=<%=eachProduct.getId()%>"><button>Edit</button></a>
				<a href="admin?action=deleteproduct&id=<%=eachProduct.getId()%>"><button>Delete</button></a></td>
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<%
		}
	%>
	<hr />
	<jsp:include page="footer.jsp" />
</div>
</body>
</html>