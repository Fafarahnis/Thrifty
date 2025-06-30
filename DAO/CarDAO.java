package thrifty.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import thrifty.model.Car;
import thrifty.connection.DBConnectionManager;

public class CarDAO {

    /**
     Retrieves a list of all cars from the database.
     */
    public List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        String sql = "SELECT * FROM Car ORDER BY carBrand, carType";
        try (Connection conn = DBConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                cars.add(mapResultSetToCar(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }

    /**
     * Retrieves a single car by its ID.
     */
    public Car getCarById(String carId) {
        Car car = null;
        String sql = "SELECT * FROM Car WHERE carId = ?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, carId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    car = mapResultSetToCar(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return car;
    }

    public boolean addCar(Car car) {
        String sql = "INSERT INTO Car (carId, adminId, carType, carBrand, carColour, carStatus, carPlateNum, carImage, pricePerDay, carDescription) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "CAR" + System.currentTimeMillis() % 100000);
            ps.setString(2, car.getAdminId());
            ps.setString(3, car.getCarType());
            ps.setString(4, car.getCarBrand());
            ps.setString(5, car.getCarColour());
            ps.setString(6, car.getCarStatus());
            ps.setString(7, car.getCarPlateNum());
            ps.setString(8, car.getCarImage());
            ps.setBigDecimal(9, car.getPricePerDay());
            ps.setString(10, car.getCarDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCar(Car car) {
        String sql = "UPDATE Car SET carType=?, carBrand=?, carColour=?, carStatus=?, carPlateNum=?, pricePerDay=?, carDescription=?, carImage=? WHERE carId=?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, car.getCarType());
            ps.setString(2, car.getCarBrand());
            ps.setString(3, car.getCarColour());
            ps.setString(4, car.getCarStatus());
            ps.setString(5, car.getCarPlateNum());
            ps.setBigDecimal(6, car.getPricePerDay());
            ps.setString(7, car.getCarDescription());
            ps.setString(8, car.getCarImage());
            ps.setString(9, car.getCarId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCar(String carId) {
        String sql = "DELETE FROM Car WHERE carId = ?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, carId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // Could fail due to foreign key constraints if car is in a rental.
            // Handle this gracefully in a real application.
            e.printStackTrace();
            return false;
        }
    }

    /**
     * A specialized method to quickly update only the car's status (e.g., during booking).
     */
    public boolean updateCarStatus(String carId, String status) {
        String sql = "UPDATE Car SET carStatus = ? WHERE carId = ?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, carId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Helper method to map a ResultSet row to a Car object to avoid code duplication.
     */
    private Car mapResultSetToCar(ResultSet rs) throws SQLException {
        Car car = new Car();
        car.setCarId(rs.getString("carId"));
        car.setAdminId(rs.getString("adminId"));
        car.setCarType(rs.getString("carType"));
        car.setCarBrand(rs.getString("carBrand"));
        car.setCarColour(rs.getString("carColour"));
        car.setCarStatus(rs.getString("carStatus"));
        car.setCarPlateNum(rs.getString("carPlateNum"));
        car.setCarImage(rs.getString("carImage"));
        car.setPricePerDay(rs.getBigDecimal("pricePerDay"));
        car.setCarDescription(rs.getString("carDescription"));
        return car;
    }
}