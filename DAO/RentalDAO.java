package thrifty.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import thrifty.model.*;
import thrifty.connection.DBConnectionManager;

public class RentalDAO {

    public boolean isCarAvailable(String carId, Date startDate, Date endDate) {
        String sql = "SELECT COUNT(*) FROM Rental WHERE carId = ? AND rentStatus NOT IN ('Cancelled', 'Rejected', 'Completed') AND ? < returnDate AND ? > rentDate";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, carId);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String createRental(Rental rental) {
        String newRentId = "RENT" + System.currentTimeMillis();
        String sql = "INSERT INTO Rental (rentId, custId, carId, rentStatus, rentDate, returnDate, totalPrice) VALUES (?, ?, ?, 'Pending', ?, ?, ?)";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newRentId);
            ps.setString(2, rental.getCustId());
            ps.setString(3, rental.getCarId());
            ps.setDate(4, rental.getRentDate());
            ps.setDate(5, rental.getReturnDate());
            ps.setBigDecimal(6, rental.getTotalPrice());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                // Also update car status to 'Booked'
                new CarDAO().updateCarStatus(rental.getCarId(), "Booked");
                return newRentId;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    public List<Rental> getAllRentals() {
        List<Rental> rentals = new ArrayList<>();
        String sql = "SELECT r.*, c.custName, cr.carBrand, cr.carPlateNum FROM Rental r " +
                     "JOIN Customer c ON r.custId = c.custId " +
                     "JOIN Car cr ON r.carId = cr.carId " +
                     "ORDER BY r.rentDate DESC";
        try (Connection conn = DBConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                rentals.add(mapResultSetToRental(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rentals;
    }
    
    public Rental getRentalById(String rentId) {
        Rental rental = null;
        String sql = "SELECT r.*, c.*, cr.* FROM Rental r " +
                     "JOIN Customer c ON r.custId = c.custId " +
                     "JOIN Car cr ON r.carId = cr.carId " +
                     "WHERE r.rentId = ?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                rental = mapResultSetToRental(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rental;
    }

    public boolean updateRentalStatus(String rentId, String status, String adminId, String reason) {
        String sql = "UPDATE Rental SET rentStatus=?, adminId=?, rejectionReason=? WHERE rentId=?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, adminId);
            ps.setString(3, reason);
            ps.setString(4, rentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Rental mapResultSetToRental(ResultSet rs) throws SQLException {
        Rental rental = new Rental();
        rental.setRentId(rs.getString("rentId"));
        rental.setRentStatus(rs.getString("rentStatus"));
        rental.setRentDate(rs.getDate("rentDate"));
        rental.setReturnDate(rs.getDate("returnDate"));
        rental.setTotalPrice(rs.getBigDecimal("totalPrice"));

        Customer customer = new Customer();
        customer.setCustId(rs.getString("custId"));
        customer.setCustName(rs.getString("custName"));
        // map other customer fields...
        rental.setCustomer(customer);

        Car car = new Car();
        car.setCarId(rs.getString("carId"));
        car.setCarBrand(rs.getString("carBrand"));
        car.setCarPlateNum(rs.getString("carPlateNum"));
        // map other car fields...
        rental.setCar(car);

        return rental;
    }
}