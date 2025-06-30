package thrifty.model;

import java.math.BigDecimal;

public class Car {
    private String carId;
    private String adminId;
    private String carType;
    private String carBrand;
    private String carColour;
    private String carStatus;
    private String carPlateNum;
    private String carImage;
    private BigDecimal pricePerDay;
    private String carDescription;
    
    // Getters and Setters
    public String getCarId() { return carId; }
    public void setCarId(String carId) { this.carId = carId; }
    public String getAdminId() { return adminId; }
    public void setAdminId(String adminId) { this.adminId = adminId; }
    public String getCarType() { return carType; }
    public void setCarType(String carType) { this.carType = carType; }
    public String getCarBrand() { return carBrand; }
    public void setCarBrand(String carBrand) { this.carBrand = carBrand; }
    public String getCarColour() { return carColour; }
    public void setCarColour(String carColour) { this.carColour = carColour; }
    public String getCarStatus() { return carStatus; }
    public void setCarStatus(String carStatus) { this.carStatus = carStatus; }
    public String getCarPlateNum() { return carPlateNum; }
    public void setCarPlateNum(String carPlateNum) { this.carPlateNum = carPlateNum; }
    public String getCarImage() { return carImage; }
    public void setCarImage(String carImage) { this.carImage = carImage; }
    public BigDecimal getPricePerDay() { return pricePerDay; }
    public void setPricePerDay(BigDecimal pricePerDay) { this.pricePerDay = pricePerDay; }
    public String getCarDescription() { return carDescription; }
    public void setCarDescription(String carDescription) { this.carDescription = carDescription; }
}