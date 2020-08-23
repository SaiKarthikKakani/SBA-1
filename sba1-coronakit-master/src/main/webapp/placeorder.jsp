<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Corona Kit-Place Order(user)</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<hr/>
<h3 align="right">User: <%=session.getAttribute("userName") %></h3>
<p>
	<font color="green">${orderSuccess}</font>
</p>
<form action="user?action=saveorder" method="post">
	<h3>You are placing an order for the amount: <%=session.getAttribute("totalAmount") %></h3>
	<label>Enter your address</label> : <input style="height: 200px;width: 200px" type="text" name="address" />
	<div align="right">
		<%
			if(request.getAttribute("orderSuccess") == null) {
		%>
		<input type="submit" value="Save Order" />
		<%
			}
		%>
	</div>
	<br/>
</form>
	<div align="right">
		<%
			if(request.getAttribute("orderSuccess") == null) {
		%>
		<a href="user?action=showkit"><button>Review the order</button></a>
		<%
			} else if(request.getAttribute("orderSuccess") != null) {
		%>
		<a href="user?action=ordersummary"><input type="submit" value="View Order Summary" /></a>
		<%
			}
		%>
	</div>
<hr/>	
	<jsp:include page="footer.jsp"/>
</body>
</html>