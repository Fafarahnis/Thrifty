package thrifty.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Payment {
    private String paymentId;
    private String rentId;
    private String custId;
    private String paymentMethod;
    private BigDecimal paymentAmount;
    private Date payDate;
    private boolean isRefunded;
    private BigDecimal refundAmount;

    // Default constructor
    public Payment() {}

    // Getters and Setters for all fields
    public String getPaymentId() {
        return paymentId;
    }
    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }
    public String getRentId() {
        return rentId;
    }
    public void setRentId(String rentId) {
        this.rentId = rentId;
    }
    public String getCustId() {
        return custId;
    }
    public void setCustId(String custId) {
        this.custId = custId;
    }
    public String getPaymentMethod() {
        return paymentMethod;
    }
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    public BigDecimal getPaymentAmount() {
        return paymentAmount;
    }
    public void setPaymentAmount(BigDecimal paymentAmount) {
        this.paymentAmount = paymentAmount;
    }
    public Date getPayDate() {
        return payDate;
    }
    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }
    public boolean isRefunded() {
        return isRefunded;
    }
    public void setRefunded(boolean isRefunded) {
        this.isRefunded = isRefunded;
    }
    public BigDecimal getRefundAmount() {
        return refundAmount;
    }
    public void setRefundAmount(BigDecimal refundAmount) {
        this.refundAmount = refundAmount;
    }
}