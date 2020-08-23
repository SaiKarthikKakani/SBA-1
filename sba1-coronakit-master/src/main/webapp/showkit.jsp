<%@page import="com.iiht.evaluation.coronokit.model.KitDetail"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Corona Kit-My Kit(user)</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<hr/>
	<h3 align="right">User: <%=session.getAttribute("userName") %></h3>
	<h2 align="center">Kit Details</h2>
	<%
		List<KitDetail> allKitDetails = (List<KitDetail>) request.getAttribute("kitDetails");
	
		if(allKitDetails.size() != 0) {
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
				<td><a href="user?action=deleteitem&id=<%=eachKitDetail.getId()%>"><button>Delete</button></a></td>
			</tr>
		<%
			}
		%>
			<tr>
				<th/>
				<th>Total Amount</th>
				<td><%=session.getAttribute("totalAmount") %></td>
				<th/>
			</tr>
		</tbody>
	</table>
	<div align="right">
		<a href="user?action=showproducts">
			<input type="submit" value="Back" />
		</a>
		<a href="user?action=placeorder">
			<input type="submit" value="Place Order" />
		</a>
	</div>
	<%
		} else {
	%>
	<p>
		<font color="red">Your kit is empty. Please add items!!!</font>
	</p>
	<div align="right">
		<a href="user?action=showproducts">
			<input type="submit" value="Back" />
		</a>
	</div>
	<%
		}
	%>
<hr/>	
	<jsp:include page="footer.jsp"/>
</body>
</html>