package com.iiht.evaluation.coronokit.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.iiht.evaluation.coronokit.model.ProductMaster;

public class ProductMasterDao {

	private String jdbcURL;
	private String jdbcUsername;
	private String jdbcPassword;
	private Connection jdbcConnection;

	public ProductMasterDao(String jdbcURL, String jdbcUsername, String jdbcPassword) {
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

	public List<ProductMaster> getList() throws SQLException {
		List<ProductMaster> productMasterList = new ArrayList<ProductMaster>();
		this.connect();

		String sql = "select * from coronakitdb.productmaster";
		Statement stmt = this.jdbcConnection.createStatement();
		ResultSet rs = stmt.executeQuery(sql);

		while (rs.next()) {
			ProductMaster productMaster = new ProductMaster(rs.getInt("id"), rs.getString("productname"),
					rs.getString("cost"), rs.getString("productdescription"));

			productMasterList.add(productMaster);
		}

		rs.close();
		stmt.close();
		this.disconnect();

		return productMasterList;
	}

	public List<String> getProductInfo(int id) throws SQLException {
		List<String> productDetails = new ArrayList<String>();
		this.connect();

		String sql = "select * from coronakitdb.productmaster where id=?";
		PreparedStatement pStmt = this.jdbcConnection.prepareStatement(sql);
		pStmt.setInt(1, id);

		ResultSet rs = pStmt.executeQuery();

		while (rs.next()) {
			System.out.println(rs.getString("productdescription"));
			productDetails.add(rs.getString("productname"));
			productDetails.add(rs.getString("cost"));
			productDetails.add(rs.getString("productdescription"));
		}

		rs.close();
		pStmt.close();
		this.disconnect();

		return productDetails;
	}

	public void updateProductInfo(int id, String newProductName, String newProductCost, String newProductDesc)
			throws SQLException {
		this.connect();

		String sql = "update coronakitdb.productmaster set productname=?, cost=?, productdescription=? where id=?";
		PreparedStatement pStmt = this.jdbcConnection.prepareStatement(sql);
		pStmt.setString(1, newProductName);
		pStmt.setString(2, newProductCost);
		pStmt.setString(3, newProductDesc);
		pStmt.setInt(4, id);

		pStmt.executeUpdate();

		pStmt.close();
		this.disconnect();
	}

	public void deleteProductInfo(int id) throws SQLException {
		this.connect();

		String sql = "delete from coronakitdb.productmaster where id=?";
		PreparedStatement pStmt = this.jdbcConnection.prepareStatement(sql);
		pStmt.setInt(1, id);

		pStmt.executeUpdate();

		pStmt.close();
		this.disconnect();
	}

	public void insertProductInfo(String newProductName, String newProductCost, String newProductDesc)
			throws SQLException {
		this.connect();

		String sql = "insert into coronakitdb.productmaster (productname, cost, productdescription)"
				+ "values (?, ?, ?)";
		PreparedStatement pStmt = this.jdbcConnection.prepareStatement(sql);
		pStmt.setString(1, newProductName);
		pStmt.setString(2, newProductCost);
		pStmt.setString(3, newProductDesc);

		pStmt.executeUpdate();

		pStmt.close();
		this.disconnect();

	}
}