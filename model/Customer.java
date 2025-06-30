package thrifty.model;

public class Customer {
    private String custId;
    private String custName;
    private String custAdd;
    private String custPhone;
    private String custEmail;
    private String custUsername;
    private String custPassword;
    private String refCode;
    private int rewardPoints;

    // Getters and Setters
    public String getCustId() { return custId; }
    public void setCustId(String custId) { this.custId = custId; }
    public String getCustName() { return custName; }
    public void setCustName(String custName) { this.custName = custName; }
    public String getCustAdd() { return custAdd; }
    public void setCustAdd(String custAdd) { this.custAdd = custAdd; }
    public String getCustPhone() { return custPhone; }
    public void setCustPhone(String custPhone) { this.custPhone = custPhone; }
    public String getCustEmail() { return custEmail; }
    public void setCustEmail(String custEmail) { this.custEmail = custEmail; }
    public String getCustUsername() { return custUsername; }
    public void setCustUsername(String custUsername) { this.custUsername = custUsername; }
    public String getCustPassword() { return custPassword; }
    public void setCustPassword(String custPassword) { this.custPassword = custPassword; }
    public String getRefCode() { return refCode; }
    public void setRefCode(String refCode) { this.refCode = refCode; }
    public int getRewardPoints() { return rewardPoints; }
    public void setRewardPoints(int rewardPoints) { this.rewardPoints = rewardPoints; }
}