<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Corona Kit-Place Order(user)</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp" />
		<hr />
		<h4 align="right">
			User:
			<%=session.getAttribute("userName")%></h4>
		<h3>Place the order</h3>
		<p class="text-success">${orderSuccess}</p>
		<p class="text-danger">${addressEmpty}</p>
		<form action="user?action=saveorder" method="post">
			<h4>
				You are placing an order for the amount:
				<%=session.getAttribute("totalAmount")%></h4>
			<label style="align-items: center;">Enter your address</label> :
			<textarea name="address" rows="20" cols="50"></textarea>
			<br>
			<%
				if (request.getAttribute("orderSuccess") == null) {
			%>
			<input type="submit" value="Save Order" style="float: right;" />
			<%
				}
			%>
		</form>
		<div align="right">
			<%
				if (request.getAttribute("orderSuccess") == null) {
			%>
			<a href="user?action=showkit"><button style="margin-right: 5pt;">Review the order</button></a>
			<%
				} else if (request.getAttribute("orderSuccess") != null) {
			%>
			<a href="user?action=ordersummary"><input type="submit"
				value="View Order Summary" /></a>
			<%
				}
			%>
		</div>
		<div style="clear: both"></div>
		<hr />
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>