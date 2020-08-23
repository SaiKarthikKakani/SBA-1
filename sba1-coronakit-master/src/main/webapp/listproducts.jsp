<%@page import="com.iiht.evaluation.coronokit.model.ProductMaster"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Corona Kit-All Products(Admin)</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div align="right">
		<a href="admin?action=logout"><button>Logout</button></a>
	</div>
	<hr />
	<a href="admin?action=list">
		<button>Show All Products</button>
	</a>
	<%
		List<ProductMaster> allProductsList = (List<ProductMaster>) request.getAttribute("productMasterList");
	
		if(allProductsList != null) {
	%>
	<a href="admin?action=newproduct">
		<button>Add New Product</button>
	</a>
	<table border="1" width="100%">
		<thead>
			<tr>
				<th>Product Name</th>
				<th>Cost</th>
				<th>Product Description</th>
			</tr>
		</thead>
		<%
			for (ProductMaster eachProduct : allProductsList) {
		%>
		<tbody>
			<tr>
				<td><%=eachProduct.getProductName()%></td>
				<td><%=eachProduct.getCost()%></td>
				<td><%=eachProduct.getProductDescription()%></td>
				<td><a href="admin?action=editproduct&id=<%=eachProduct.getId()%>"><button>Edit</button></a></td>
				<td><a href="admin?action=deleteproduct&id=<%=eachProduct.getId()%>"><button>Delete</button></a></td>
			</tr>
		</tbody>
		<%
			}
		%>
	</table>
	<%
		}
	%>
	<hr />
	<jsp:include page="footer.jsp" />
</body>
</html>