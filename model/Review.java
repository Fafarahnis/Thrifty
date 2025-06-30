package thrifty.model;

import java.sql.Date;

public class Review {
    private int reviewId;
    private String custId;
    private String carId;
    private String adminId;
    private int ratings;
    private String comments;
    private Date reviewDate;

    // Getters and Setters

	public int getReviewId() {
		return reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	
    public void setCarId(String carId) { 
    	this.carId = carId; 
    	}
    
    public String getCarId() { 
    	return carId; 
    	}
    
    public void setAdminId(String adminId) { 
    	this.adminId = adminId; 
    	}
    
    public String getAdminId() { 
    	return adminId; 
    	}
    
    public void setRatings(int ratings) {
    	this.ratings = ratings; 
    	}
    
    public int getRatings() { 
    	return ratings; 
    	}

    public void setComments(String comments) {
    	this.comments = comments; 
    	}
    
    public String getComments() { 
    	return comments; 
    	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public Date getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}

}