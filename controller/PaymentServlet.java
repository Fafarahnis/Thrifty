package thrifty.controller;

import java.io.IOException;
import java.sql.Date;
import thrifty.DAO.RentalDAO;
import thrifty.DAO.PaymentDAO; // Assuming you create this DAO
import thrifty.model.Rental;
import thrifty.model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/processPayment")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Rental pendingRental = (Rental) session.getAttribute("pendingRental");
        
        if (pendingRental == null) {
            response.sendRedirect("carList");
            return;
        }

        // Simulate successful payment
        
        RentalDAO rentalDAO = new RentalDAO();
        String rentId = rentalDAO.createRental(pendingRental); // Assume create() returns the new ID

        if (rentId != null) {
            PaymentDAO paymentDAO = new PaymentDAO();
            Payment payment = new Payment();
            payment.setRentId(rentId);
            payment.setCustId(pendingRental.getCustId());
            payment.setPaymentAmount(pendingRental.getTotalPrice());
            payment.setPaymentMethod(request.getParameter("paymentMethod")); // from form
            payment.setPayDate(new Date(System.currentTimeMillis()));
            paymentDAO.create(payment);

            session.removeAttribute("pendingRental");
            session.setAttribute("confirmedRental", rentalDAO.getRentalsByStatus(rentId));
            response.sendRedirect("confirmation.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to finalize booking. Please try again.");
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        }
    }
}