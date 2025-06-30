package thrifty.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import thrifty.model.Payment;
import thrifty.connection.DBConnectionManager;

public class PaymentDAO {

    /**
     * Creates a new payment record in the database. This should be called after a successful transaction.
     * @param payment The Payment object containing all transaction details.
     * @return true if the payment record was created successfully, false otherwise.
     */
    public boolean create(Payment payment) {
        String sql = "INSERT INTO Payment (paymentId, rentId, custId, paymentMethod, paymentAmount, payDate, isRefunded, refundAmount) VALUES (?, ?, ?, ?, ?, ?, 0, NULL)";
        
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Generate a unique ID for the payment
            ps.setString(1, "PAY" + System.currentTimeMillis());
            ps.setString(2, payment.getRentId());
            ps.setString(3, payment.getCustId());
            ps.setString(4, payment.getPaymentMethod());
            ps.setBigDecimal(5, payment.getPaymentAmount());
            ps.setDate(6, payment.getPayDate());
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Error creating payment record: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates a payment record to mark it as refunded.
     * @param paymentId The ID of the payment to be refunded.
     * @param refundAmount The amount that was refunded (e.g., 95% of the original).
     * @return true if the update was successful, false otherwise.
     */
    public boolean processRefund(String paymentId, java.math.BigDecimal refundAmount) {
        String sql = "UPDATE Payment SET isRefunded = 1, refundAmount = ? WHERE paymentId = ?";
        
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBigDecimal(1, refundAmount);
            ps.setString(2, paymentId);

            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error processing refund: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // You can add other methods here if needed, like getPaymentByRentalId(), etc.
}