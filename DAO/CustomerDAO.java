package thrifty.DAO;

import java.sql.*;
import thrifty.model.Customer;
import thrifty.connection.DBConnectionManager;
import java.util.UUID;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    // validateCustomer
	public Customer validateCustomer(String username, String password) {
        Customer customer = null;
        String sql = "SELECT * FROM Customer WHERE custUsername = ? AND custPassword = ?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customer = new Customer();
                customer.setCustId(rs.getString("custId"));
                customer.setCustName(rs.getString("custName"));
                customer.setCustUsername(rs.getString("custUsername"));
                customer.setCustEmail(rs.getString("custEmail"));
                customer.setCustPhone(rs.getString("custPhone"));
                customer.setCustAdd(rs.getString("custAdd"));
                customer.setRewardPoints(rs.getInt("rewardPoints"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }
	
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM Customer ORDER BY custName";
        try (Connection conn = DBConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustId(rs.getString("custId"));
                customer.setCustName(rs.getString("custName"));
                customer.setCustUsername(rs.getString("custUsername"));
                customer.setCustEmail(rs.getString("custEmail"));
                customer.setCustPhone(rs.getString("custPhone"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public boolean deleteCustomer(String custId) {
        String sql = "DELETE FROM Customer WHERE custId = ?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, custId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
	
    public boolean isUsernameOrEmailTaken(String username, String email) {
        String sql = "SELECT COUNT(*) FROM Customer WHERE custUsername = ? OR custEmail = ?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true; // Assume taken on error to be safe
    }
    
    public boolean registerCustomer(Customer customer, String referrerCode) {
        String insertSql = "INSERT INTO Customer (custId, custName, custEmail, custUsername, custPassword, refCode, rewardPoints, custAdd, custPhone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String updateReferrerSql = "UPDATE Customer SET rewardPoints = rewardPoints + 50 WHERE refCode = ?";
        String checkReferrerSql = "SELECT COUNT(*) FROM Customer WHERE refCode = ?";
        Connection conn = null;
        
        try {
            conn = DBConnectionManager.getConnection();
            conn.setAutoCommit(false); // Start transaction

            if (referrerCode != null && !referrerCode.trim().isEmpty()) {
                try (PreparedStatement psCheck = conn.prepareStatement(checkReferrerSql)) {
                    psCheck.setString(1, referrerCode);
                    ResultSet rs = psCheck.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                         try (PreparedStatement psUpdate = conn.prepareStatement(updateReferrerSql)) {
                            psUpdate.setString(1, referrerCode);
                            psUpdate.executeUpdate();
                        }
                    } else {
                        // Optional: Handle invalid referral code, maybe just ignore it
                        System.out.println("Invalid referrer code provided: " + referrerCode);
                    }
                }
            }

            try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                String newCustId = "CUST" + System.currentTimeMillis() % 100000;
                String newRefCode = "REF" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
                
                psInsert.setString(1, newCustId);
                psInsert.setString(2, customer.getCustName());
                psInsert.setString(3, customer.getCustEmail());
                psInsert.setString(4, customer.getCustUsername());
                psInsert.setString(5, customer.getCustPassword());
                psInsert.setString(6, newRefCode);
                psInsert.setInt(7, 0); // New users start with 0 points
                psInsert.setString(8, customer.getCustAdd());
                psInsert.setString(9, customer.getCustPhone());
                
                psInsert.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}