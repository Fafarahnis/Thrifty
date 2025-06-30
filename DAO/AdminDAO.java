package thrifty.DAO;

import java.sql.*;
import  thrifty.model.Admin;
import thrifty.connection.DBConnectionManager;

public class AdminDAO {
    public Admin validateAdmin(String username, String password) {
        Admin admin = null;
        String sql = "SELECT * FROM Admin WHERE adminUsername = ? AND adminPassword = ?";
        try (Connection conn = DBConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    admin = new Admin();
                    admin.setAdminId(rs.getString("adminId"));
                    admin.setAdminName(rs.getString("adminName"));
                    admin.setAdminUsername(rs.getString("adminUsername"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }
}