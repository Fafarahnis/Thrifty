package thrifty.DAO;

import thrifty.model.*;
import thrifty.connection.DBConnectionManager;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    // Helper method to map a ResultSet row to a complete Review object
    private Review mapResultSetToReview(ResultSet rs) throws SQLException {
        Review review = new Review();
        review.setReviewId(rs.getInt("reviewId"));
        review.setCustId(rs.getString("custId"));
        review.setCarId(rs.getString("carId"));
        review.setRatings(rs.getInt("ratings"));
        review.setComments(rs.getString("comments"));
        review.setReviewDate(rs.getDate("reviewDate"));

        // Create and set the associated Customer object
        Customer customer = new Customer();
        customer.setCustName(rs.getString("custName"));
        review.setCustomer(customer); // CORRECTED: This now works

        // Create and set the associated Car object
        Car car = new Car();
        car.setCarBrand(rs.getString("carBrand"));
        review.setCar(car); // CORRECTED: This now works

        return review;
    }

    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT rev.*, c.custName, cr.carBrand FROM Review rev " +
                     "JOIN Customer c ON rev.custId = c.custId " +
                     "JOIN Car cr ON rev.carId = cr.carId " +
                     "ORDER BY rev.reviewDate DESC";
        
        try (Connection conn = DBConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                reviews.add(mapResultSetToReview(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public Review getReviewById(String reviewId) {
        Review review = null;
        String sql = "SELECT rev.*, c.custName, cr.carBrand, cr.carPlateNum FROM Review rev " +
                     "JOIN Customer c ON rev.custId = c.custId " +
                     "JOIN Car cr ON rev.carId = cr.carId " +
                     "WHERE rev.reviewId = ?";

        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, reviewId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                review = mapResultSetToReview(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return review;
    }
}