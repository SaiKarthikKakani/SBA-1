<%@page import="com.iiht.evaluation.coronokit.model.ProductMaster"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Corona Kit-All Products(user)</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<hr/>
<h3 align="right">User: <%=session.getAttribute("userName") %></h3>
<h2 align="center">Choose the items</h2>
<p>
	<font color="red">${errorMessage}</font>
</p>
<table border="1" width="100%">
	<thead>
		<tr>
			<th>Product Name</th>
			<th>Product Cost</th>
			<th>Quantity</th>
		</tr>
	</thead>
	<%
		List<ProductMaster> allProductList = (List<ProductMaster>) request.getAttribute("productMasterList");
		for(ProductMaster eachProduct : allProductList) {
	%>
	<tbody>
		<tr>
			<td><%=eachProduct.getProductName()%></td>
			<td><%=eachProduct.getCost()%></td>
			<td>
				<input type="text" id="pqty<%=eachProduct.getId()%>"/>
				<a href="javascript:;" onclick="this.href='user?action=addnewitem&id=<%=eachProduct.getId()%>&qty=' + 
					document.getElementById('pqty<%=eachProduct.getId()%>').value">
					<button>Add to Kit</button>
				</a>
			</td>
		</tr>
	</tbody>
	<%
		}
	%>
</table>
<div align="right">
	<a href="admin?action=logout"><button>Cancel</button></a>
	<a href="user?action=showkit"><button>Show Kit</button></a>
</div>
<hr/>	
	<jsp:include page="footer.jsp"/>
</body>
</html>