<%@page import="com.iiht.evaluation.coronokit.model.ProductMaster"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Corona Kit-All Products(user)</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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
	margin-bottom: 5pt;
	margin-left: auto;
	margin-right: auto;
}
</style>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp" />
		<hr />
		<h4 align="right">
			User:
			<%=session.getAttribute("userName")%></h4>
		<h3 align="center">Choose the items</h3>
		<p class="text-danger">${errorMessage}</p>
		<table border="1" class="table-striped">
			<thead>
				<tr>
					<th>Product Name</th>
					<th>Product Cost</th>
					<th>Quantity</th>
				</tr>
			</thead>
			<tbody>
				<%
					List<ProductMaster> allProductList = (List<ProductMaster>) request.getAttribute("productMasterList");
				for (ProductMaster eachProduct : allProductList) {
				%>
				<tr>
					<td><%=eachProduct.getProductName()%></td>
					<td><%=eachProduct.getCost()%></td>
					<td><input type="text" id="pqty<%=eachProduct.getId()%>"
						oninput="this.value=this.value.replace(/[^0-9.]/, '').replace(/\./, '').replace(/-/, '')" />
						<a href="javascript:;"
						onclick="this.href='user?action=addnewitem&id=<%=eachProduct.getId()%>&qty=' + 
					document.getElementById('pqty<%=eachProduct.getId()%>').value">
							<button>Add to Kit</button>
					</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<div align="right">
			<a href="admin?action=logout"><button>Cancel</button></a> <a
				href="user?action=showkit"><button>Show Kit</button></a>
		</div>
		<div style="clear: both"></div>
		<hr />
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>