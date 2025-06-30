package thrifty.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Rental {
    private String rentId;
    private String custId;
    private String carId;
    private String adminId;
    private String rentStatus;
    private String rejectionReason;
    private Date rentDate;
    private Date returnDate;
    private Date actualReturnDate;
    private BigDecimal totalPrice;
    
    // For holding joined data
    private Customer customer;
    private Car car;

    // Getters and Setters
    public String getRentId() { return rentId; }
    public void setRentId(String rentId) { this.rentId = rentId; }
    public String getCustId() { return custId; }
    public void setCustId(String custId) { this.custId = custId; }
    public String getCarId() { return carId; }
    public void setCarId(String carId) { this.carId = carId; }
    public String getAdminId() { return adminId; }
    public void setAdminId(String adminId) { this.adminId = adminId; }
    public String getRentStatus() { return rentStatus; }
    public void setRentStatus(String rentStatus) { this.rentStatus = rentStatus; }
    public String getRejectionReason() { return rejectionReason; }
    public void setRejectionReason(String rejectionReason) { this.rejectionReason = rejectionReason; }
    public Date getRentDate() { return rentDate; }
    public void setRentDate(Date rentDate) { this.rentDate = rentDate; }
    public Date getReturnDate() { return returnDate; }
    public void setReturnDate(Date returnDate) { this.returnDate = returnDate; }
    public Date getActualReturnDate() { return actualReturnDate; }
    public void setActualReturnDate(Date actualReturnDate) { this.actualReturnDate = actualReturnDate; }
    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }
    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }
    public Car getCar() { return car; }
    public void setCar(Car car) { this.car = car; }
}