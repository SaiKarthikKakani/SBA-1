package com.iiht.evaluation.coronokit.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.iiht.evaluation.coronokit.model.CoronaKit;
import com.iiht.evaluation.coronokit.model.KitDetail;

public class KitDao {

	private String jdbcURL;
	private String jdbcUsername;
	private String jdbcPassword;
	private Connection jdbcConnection;

	public KitDao(String jdbcURL, String jdbcUsername, String jdbcPassword) {
		this.jdbcURL = jdbcURL;
		this.jdbcUsername = jdbcUsername;
		this.jdbcPassword = jdbcPassword;
	}

	protected void connect() throws SQLException {
		if (jdbcConnection == null || jdbcConnection.isClosed()) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				throw new SQLException(e);
			}
			jdbcConnection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		}
	}

	protected void disconnect() throws SQLException {
		if (jdbcConnection != null && !jdbcConnection.isClosed()) {
			jdbcConnection.close();
		}
	}

	public void insertCoronaKitDetails(String userName, String email, String contactNumber) throws SQLException {
		this.connect();
		boolean isUserExists = false;
		
		String preCheckSql = "select count(*) as count from coronakitdb.coronakitinfo where personname = ?";
		PreparedStatement preCheckStmt = this.jdbcConnection.prepareStatement(preCheckSql);
		preCheckStmt.setString(1, userName);
		
		ResultSet preCheckRs = preCheckStmt.executeQuery();
		while(preCheckRs.next()) {
			isUserExists = preCheckRs.getInt("count") == 0;
		}

		if(isUserExists) {
			String sql = "insert into coronakitdb.coronakitinfo (personname, email, contactnumber)" + "values(?, ?, ?)";
	
			PreparedStatement pStmt = this.jdbcConnection.prepareStatement(sql);
			pStmt.setString(1, userName);
			pStmt.setString(2, email);
			pStmt.setString(3, contactNumber);
	
			pStmt.executeUpdate();
	
			pStmt.close();
		}
		
		preCheckRs.close();
		preCheckStmt.close();
		this.disconnect();
	}

	public boolean insertItemToKit(int id, int quantity, String userName) throws SQLException {
		boolean isInserted = false;
		String productCost = "";
		String productName = "";
		
		this.connect();

		String preCheckSql = "select count(*) as count from coronakitdb.kitdetails where productid = ? and coronakitid = "
				+ "(select id from coronakitdb.coronakitinfo where personname = ?)";
		PreparedStatement preCheckStmt = this.jdbcConnection.prepareStatement(preCheckSql);
		preCheckStmt.setInt(1, id);
		preCheckStmt.setString(2, userName);

		ResultSet preCheckRs = preCheckStmt.executeQuery();

		int preCheckCount = 0;
		while (preCheckRs.next()) {
			preCheckCount = preCheckRs.getInt("count");
		}
		
		String sql = "select productname, cost from coronakitdb.productmaster where id = ?";
		PreparedStatement pStmt = this.jdbcConnection.prepareStatement(sql);

		pStmt.setInt(1, id);

		ResultSet rs = pStmt.executeQuery();

		while (rs.next()) {
			productCost = rs.getString("cost").split("\\.")[0];
			productName = rs.getString("productname");
		}

		if (preCheckCount == 0) {

			String insertSql = "insert into coronakitdb.kitdetails (coronakitid, productid, quantity, amount, productname)"
					+ "values ((select id from coronakitdb.coronakitinfo where personname = ?), ?, ?, ?, ?)";
			PreparedStatement insertStmt = this.jdbcConnection.prepareStatement(insertSql);

			insertStmt.setString(1, userName);
			insertStmt.setInt(2, id);
			insertStmt.setInt(3, quantity);
			insertStmt.setInt(4, quantity * Integer.parseInt(productCost));
			insertStmt.setString(5, productName);

			insertStmt.executeUpdate();

			rs.close();
			pStmt.close();
			insertStmt.close();
			
			isInserted = true;
		} else {
			int existingQuantity = 0;
			
			String selectSql = "select quantity from coronakitdb.kitdetails where coronakitid = "  
					+ "(select id from coronakitdb.coronakitinfo where personname = ?) and productid = ?";
			PreparedStatement selectStmt = this.jdbcConnection.prepareStatement(selectSql);

			selectStmt.setString(1, userName);
			selectStmt.setInt(2, id);

			ResultSet selectRs = selectStmt.executeQuery();

			while (selectRs.next()) {
				existingQuantity = selectRs.getInt("quantity");
			}
			
			String updateSql = "update coronakitdb.kitdetails set quantity = ?, amount = ? where coronakitid = "
					+ "(select id from coronakitdb.coronakitinfo where personname = ?) and productid = ?";
			PreparedStatement updateStmt = this.jdbcConnection.prepareStatement(updateSql);
			updateStmt.setInt(1, quantity + existingQuantity);
			updateStmt.setInt(2, (quantity + existingQuantity) * Integer.parseInt(productCost));
			updateStmt.setString(3, userName);
			updateStmt.setInt(4, id);
			
			updateStmt.executeUpdate();
			
			selectRs.close();
			selectStmt.close();
			
			updateStmt.close();
			this.disconnect();
		}
		preCheckRs.close();
		preCheckStmt.close();
		this.disconnect();
		
		return isInserted;
	}

	public List<KitDetail> getKitDetails(String userName) throws SQLException {
		this.connect();
		List<KitDetail> kitDetails = new ArrayList<KitDetail>();
		
		String sql = "select * from coronakitdb.kitdetails where coronakitid = "
				+ "(select id from coronakitdb.coronakitinfo where personname = ?)";
		PreparedStatement stmt = this.jdbcConnection.prepareStatement(sql);
		stmt.setString(1, userName);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			KitDetail kitDetail = new KitDetail(rs.getInt("id"), rs.getInt("coronakitid"), rs.getInt("productid"),
					rs.getInt("quantity"), rs.getInt("amount"), rs.getString("productname"));
			
			kitDetails.add(kitDetail);
		}
		
		rs.close();
		stmt.close();		
		return kitDetails;
	}

	public void deleteItemFromKit(int id) throws SQLException {
		this.connect();

		String sql = "delete from coronakitdb.kitdetails where id=?";
		PreparedStatement pStmt = this.jdbcConnection.prepareStatement(sql);
		pStmt.setInt(1, id);

		pStmt.executeUpdate();

		pStmt.close();
		this.disconnect();
	}

	public void updateCoronaKitDetails(String userName, String address, int finalAmount, String strDate) throws SQLException {
		this.connect();
		
		String sql = "update coronakitdb.coronakitinfo set deliveryaddress = ?, totalamount = ?, orderdate = ?, "
				+ "orderfinalized = true where personname = ?";
		PreparedStatement pStmt = this.jdbcConnection.prepareStatement(sql);
		pStmt.setString(1, address);
		pStmt.setInt(2, finalAmount);
		pStmt.setString(3, strDate);
		pStmt.setString(4, userName);
		
		pStmt.executeUpdate();
		
		pStmt.close();
		this.disconnect();
	}
	
	public CoronaKit getCoronaKitDetails(String userName) throws SQLException {
		CoronaKit coronaKit = null;
		
		this.connect();
		
		String sql = "select * from coronakitdb.coronakitinfo where personname = ?";
		PreparedStatement pStmt = this.jdbcConnection.prepareStatement(sql);
		pStmt.setString(1, userName);
		
		ResultSet rs = pStmt.executeQuery();
		
		while(rs.next()) {
			coronaKit = new CoronaKit(rs.getInt("id"), rs.getString("personname"), rs.getString("email"),
					rs.getString("contactnumber"), rs.getInt("totalAmount"), rs.getString("deliveryaddress"),
					rs.getString("orderdate"), rs.getBoolean("orderfinalized"));
		}
		
		rs.close();
		pStmt.close();
		this.disconnect();
		
		return coronaKit;
	}

}