package thrifty.controller;

import java.io.IOException;
import thrifty.DAO.AdminDAO;
import thrifty.DAO.CustomerDAO;
import thrifty.model.Admin;
import thrifty.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/login", "/logout", "/register"})
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;
    private AdminDAO adminDAO;

    public void init() {
        customerDAO = new CustomerDAO();
        adminDAO = new AdminDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if ("/login".equals(action)) {
            loginUser(request, response);
        } else if ("/register".equals(action)) {
            registerUser(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        logoutUser(request, response);
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        Customer customer = customerDAO.validateCustomer(username, password);
        if (customer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            session.setAttribute("userType", "customer");
            response.sendRedirect("dashboard.jsp");
            return;
        }
        
        Admin admin = adminDAO.validateAdmin(username, password);
        if (admin != null) {
             HttpSession session = request.getSession();
             session.setAttribute("admin", admin);
             session.setAttribute("userType", "admin");
             response.sendRedirect("admin/viewCars");
             return;
        }
        
        request.setAttribute("loginError", "Invalid username or password.");
        request.getRequestDispatcher("signinup.jsp").forward(request, response);
    }
    
    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (customerDAO.isUsernameOrEmailTaken(username, email)) {
            request.setAttribute("registerError", "Username or Email is already taken.");
            request.getRequestDispatcher("signinup.jsp").forward(request, response);
            return;
        }
        
        Customer newCustomer = new Customer();
        newCustomer.setCustName(name);
        newCustomer.setCustEmail(email);
        newCustomer.setCustUsername(username);
        newCustomer.setCustPassword(password);
        
        boolean success = customerDAO.registerCustomer(newCustomer, request.getParameter("referrerCode"));
        
        if (success) {
            response.sendRedirect("signinup.jsp?registration=success");
        } else {
            request.setAttribute("registerError", "Registration failed. Please try again.");
            request.getRequestDispatcher("signinup.jsp").forward(request, response);
        }
    }

    private void logoutUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("home.jsp");
    }
}