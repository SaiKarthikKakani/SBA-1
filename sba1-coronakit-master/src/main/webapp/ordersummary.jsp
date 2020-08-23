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
<title>Corona Kit-Order Summary(user)</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<hr/>
<h3 align="right">User: <%=session.getAttribute("userName") %></h3>
<h2 align="center"><font color="green">Get Well Soon...Hope not to see you again</font></h2>
<h2>Order Summary Details</h2>
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
	<table border="1">
		<thead>
			<tr>
				<th>Product Name</th>
				<th>Quantity</th>
				<th>Amount</th>
			</tr>
		</thead>
		<%		
			for(KitDetail eachKitDetail : allKitDetails) {
		%>
		<tbody>
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
				<td><%=orderSummary.getCoronaKit().getTotalAmount()%></td>
			</tr>
		</tbody>
	</table>
	<div align="right">
		<a href="admin?action=logout"><button>Back to Home</button></a>
	</div>
<hr/>	
	<jsp:include page="footer.jsp"/>
</body>
</html>