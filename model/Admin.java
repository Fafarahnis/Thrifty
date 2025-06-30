package thrifty.model;

public class Admin {
    private String adminId;
    private String adminName;
    private String adminUsername;
    private String adminPassword;

    // Getters and Setters
    public String getAdminId() {
    	return adminId; 
    	}
    public void setAdminId(String adminId) {
    	this.adminId = adminId; 
    	}
    public String getAdminName() {
    	return adminName; 
    	}
    public void setAdminName(String adminName) {
    	this.adminName = adminName; 
    	}
    public String getAdminUsername() {
    	return adminUsername; 
    	}
    public void setAdminUsername(String adminUsername) {
    	this.adminUsername = adminUsername; 
    	}
    public String getAdminPassword() {
    	return adminPassword; 
    	}
    public void setAdminPassword(String adminPassword) {
    	this.adminPassword = adminPassword; 
    	}
}