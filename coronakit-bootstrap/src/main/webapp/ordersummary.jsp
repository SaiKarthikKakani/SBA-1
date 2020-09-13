<%@page import="com.iiht.evaluation.coronokit.model.KitDetail"%>
<%@page import="java.util.List"%>
<%@page import="com.iiht.evaluation.coronokit.model.OrderSummary"%>
<%@page import="com.iiht.evaluation.coronokit.model.CoronaKit"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Corona Kit-Order Summary(user)</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
input {
	border-color: transparent;
}
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
<jsp:include page="header.jsp"/>
<hr/>
<h4 align="right">User: <%=session.getAttribute("userName") %></h4>
<h2 align="center"><font color="green">Get Well Soon...Hope not to see you again</font></h2>
<h3>Order Summary Details</h3>
	<%
		OrderSummary orderSummary = (OrderSummary) request.getAttribute("orderSummary");
	%>
	<label>Order ID</label> : <input readonly="readonly" type="text" value="<%=orderSummary.getCoronaKit().getId() %>" /><br/>
	<label>Name</label> : <input readonly="readonly" type="text" value="<%=orderSummary.getCoronaKit().getPersonName() %>" /><br/>
	<label>Email Address</label> : <input readonly="readonly" type="text" value="<%=orderSummary.getCoronaKit().getEmail() %>" /><br/>
	<label>Contact Number</label> : <input readonly="readonly" type="text" value="<%=orderSummary.getCoronaKit().getContactNumber() %>" /><br/>
	<label>Address</label> : <input readonly="readonly" type="text" value="<%=orderSummary.getCoronaKit().getDeliveryAddress() %>" /><br/>
	<label>Order Date</label> : <input readonly="readonly" type="text" value="<%=orderSummary.getCoronaKit().getOrderDate() %>" /><br/><br/>

	<%
		List<KitDetail> allKitDetails = orderSummary.getKitDetails();
	%>
	<table border="1" class="table-striped">
		<thead>
			<tr>
				<th>Product Name</th>
				<th>Quantity</th>
				<th>Amount</th>
			</tr>
		</thead>
		<tbody>
		<%		
			for(KitDetail eachKitDetail : allKitDetails) {
		%>
			<tr>
				<td><%=eachKitDetail.getProductName()%></td>
				<td><%=eachKitDetail.getQuantity()%></td>
				<td><%=eachKitDetail.getAmount()%></td>
			</tr>
		<%
			}
		%>
			<tr>
				<th/>
				<th>Total Amount</th>
				<th><%=orderSummary.getCoronaKit().getTotalAmount()%></th>
			</tr>
		</tbody>
	</table>
	<div align="right">
		<a href="admin?action=logout"><button>Back to Home</button></a>
	</div>
<hr/>	
	<jsp:include page="footer.jsp"/>
</div>
</body>
</html>