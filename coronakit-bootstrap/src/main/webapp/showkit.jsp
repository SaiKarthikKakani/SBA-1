<%@page import="com.iiht.evaluation.coronokit.model.KitDetail"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Corona Kit-My Kit(user)</title>
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
		<h3 align="center">Kit Details</h3>
		<%
			List<KitDetail> allKitDetails = (List<KitDetail>) request.getAttribute("kitDetails");

		if (allKitDetails.size() != 0) {
		%>
		<table border="1" class="table-striped">
			<thead>
				<tr>
					<th>Product Name</th>
					<th>Quantity</th>
					<th>Amount</th>
					<th/>
				</tr>
			</thead>
			<tbody>
				<%
					for (KitDetail eachKitDetail : allKitDetails) {
				%>
				<tr>
					<td><%=eachKitDetail.getProductName()%></td>
					<td><%=eachKitDetail.getQuantity()%></td>
					<td><%=eachKitDetail.getAmount()%></td>
					<td><a
						href="user?action=deleteitem&id=<%=eachKitDetail.getId()%>"><button>Delete</button></a></td>
				</tr>
				<%
					}
				%>
				<tr>
					<th />
					<th>Total Amount</th>
					<th><%=session.getAttribute("totalAmount")%></th>
					<th />
				</tr>
			</tbody>
		</table>
		<div align="right">
			<a href="user?action=showproducts"> <input type="submit"
				value="Back" />
			</a> <a href="user?action=placeorder"> <input type="submit"
				value="Place Order" />
			</a>
		</div>
		<%
			} else {
		%>
		<p>
			<font color="red">Your kit is empty. Please add items!!!</font>
		</p>
		<div align="right">
			<a href="user?action=showproducts"> <input type="submit"
				value="Back" />
			</a>
		</div>
		<%
			}
		%>
		<hr />
		<div style="clear: both;"></div>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>