package com.iiht.evaluation.coronokit.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.iiht.evaluation.coronokit.dao.KitDao;
import com.iiht.evaluation.coronokit.dao.ProductMasterDao;
import com.iiht.evaluation.coronokit.model.CoronaKit;
import com.iiht.evaluation.coronokit.model.KitDetail;
import com.iiht.evaluation.coronokit.model.OrderSummary;
import com.iiht.evaluation.coronokit.model.ProductMaster;

@WebServlet("/user")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private KitDao kitDAO;
	private ProductMasterDao productMasterDao;
	private String userName = "";

	public void setKitDAO(KitDao kitDAO) {
		this.kitDAO = kitDAO;
	}

	public void setProductMasterDao(ProductMasterDao productMasterDao) {
		this.productMasterDao = productMasterDao;
	}

	public void init(ServletConfig config) {
		String jdbcURL = config.getServletContext().getInitParameter("jdbcUrl");
		String jdbcUsername = config.getServletContext().getInitParameter("jdbcUsername");
		String jdbcPassword = config. getServletContext().getInitParameter("jdbcPassword");
		
		this.kitDAO = new KitDao(jdbcURL, jdbcUsername, jdbcPassword);
		this.productMasterDao = new ProductMasterDao(jdbcURL, jdbcUsername, jdbcPassword);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		
		String viewName = "";
		try {
			switch (action) {
			case "newuser":
				viewName = showNewUserForm(request, response);
				break;
			case "insertuser":
				viewName = insertNewUser(request, response);
				break;
			case "showproducts":
				viewName = showAllProducts(request, response);
				break;	
			case "addnewitem":
				viewName = addNewItemToKit(request, response);
				break;
			case "deleteitem":
				viewName = deleteItemFromKit(request, response);
				break;
			case "showkit":
				viewName = showKitDetails(request, response);
				break;
			case "placeorder":
				viewName = showPlaceOrderForm(request, response);
				break;
			case "saveorder":
				viewName = saveOrderForDelivery(request, response);
				break;	
			case "ordersummary":
				viewName = showOrderSummary(request, response);
				break;	
			default : viewName = "notfound.jsp"; break;	
			}
		} catch (Exception ex) {
			
			throw new ServletException(ex.getMessage());
		}
			RequestDispatcher dispatch = 
					request.getRequestDispatcher(viewName);
			dispatch.forward(request, response);
	
	}

	private String showOrderSummary(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		CoronaKit coronaKitInfo = kitDAO.getCoronaKitDetails(userName);
		List<KitDetail> kitDetails = kitDAO.getKitDetails(userName);
		
		OrderSummary orderSummary = new OrderSummary(coronaKitInfo, kitDetails);
		request.setAttribute("orderSummary", orderSummary);
		
		return "ordersummary.jsp";
	}

	private String saveOrderForDelivery(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		Date date = Calendar.getInstance().getTime();  
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");  
		
		String address = request.getParameter("address");
		int finalAmount = (int) request.getSession().getAttribute("totalAmount");
		String strDate = dateFormat.format(date);
		
		if(!address.isEmpty()) {
			request.setAttribute("orderSuccess", "Your order is successfully registered!!!");
			kitDAO.updateCoronaKitDetails(userName, address, finalAmount, strDate);
		} else {
			request.setAttribute("addressEmpty", "Please enter valid address!!!");
		}
		
		return "placeorder.jsp";
	}

	private String showPlaceOrderForm(HttpServletRequest request, HttpServletResponse response) {
		return "placeorder.jsp";
	}

	private String showKitDetails(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		List<KitDetail> kitDetails = kitDAO.getKitDetails(userName);
		request.setAttribute("kitDetails", kitDetails);
		
		int totalAmount = 0;
		for(KitDetail eachKitDetail : kitDetails) {
			totalAmount = totalAmount + eachKitDetail.getAmount();
		}
		
		request.getSession().setAttribute("totalAmount", totalAmount);
		
		return "showkit.jsp";
	}

	private String deleteItemFromKit(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		int id = Integer.parseInt(request.getParameter("id"));
		kitDAO.deleteItemFromKit(id);
		
		List<KitDetail> kitDetails = kitDAO.getKitDetails(userName);
		request.setAttribute("kitDetails", kitDetails);
		
		int totalAmount = 0;
		for(KitDetail eachKitDetail : kitDetails) {
			totalAmount = totalAmount + eachKitDetail.getAmount();
		}
		
		request.getSession().setAttribute("totalAmount", totalAmount);
		
		return "showkit.jsp";
	}

	private String addNewItemToKit(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		int id = Integer.parseInt(request.getParameter("id"));
		String qtyStr = request.getParameter("qty");
		boolean isInserted = true;
		int quantity;
		
		if(!qtyStr.isEmpty()) {
			quantity = Integer.parseInt(qtyStr);
			isInserted = kitDAO.insertItemToKit(id, quantity, userName);
		} else
			request.setAttribute("errorMessage", "Quantity should not be empty!!! Add items");
		
		if(!isInserted)
			request.setAttribute("errorMessage", "Already added item to the kit. Updated the quantity");
		
		List<ProductMaster> masterProductList = productMasterDao.getList();
		request.setAttribute("productMasterList", masterProductList);
		
		return "showproductstoadd.jsp";
	}

	private String showAllProducts(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		List<ProductMaster> masterProductList = productMasterDao.getList();
		request.setAttribute("productMasterList", masterProductList);
		
		return "showproductstoadd.jsp";
	}

	private String insertNewUser(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		userName = request.getParameter("pname");
		String email = request.getParameter("pemail");
		String contactNumber = request.getParameter("pcontact");
		
		request.getSession().setAttribute("userName", userName);
		
		kitDAO.insertCoronaKitDetails(userName, email, contactNumber);
		
		List<ProductMaster> masterProductList = productMasterDao.getList();
		request.setAttribute("productMasterList", masterProductList);
		
		return "showproductstoadd.jsp";
	}

	private String showNewUserForm(HttpServletRequest request, HttpServletResponse response) {
		return "newuser.jsp";
	}
}