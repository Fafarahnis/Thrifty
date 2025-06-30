package thrifty.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.concurrent.TimeUnit;

import thrifty.DAO.CarDAO;
import thrifty.DAO.RentalDAO;
import thrifty.model.Car;
import thrifty.model.Customer;
import thrifty.model.Rental;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/bookingForm", "/bookNow", "/bookingHistory", "/cancelBooking", "/updateBookingForm", "/updateBookingAction"})
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CarDAO carDAO;
    private RentalDAO rentalDAO;

    public void init() {
        carDAO = new CarDAO();
        rentalDAO = new RentalDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        
        // Security check for all actions
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/signinup.jsp");
            return;
        }
        
        switch (action) {
            case "/bookingForm":
                showBookingForm(request, response);
                break;
            case "/bookingHistory":
                showBookingHistory(request, response);
                break;
            case "/cancelBooking":
                cancelBooking(request, response);
                break;
            case "/updateBookingForm":
                showUpdateBookingForm(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect(request.getContextPath() + "/signinup.jsp");
            return;
        }
        
        switch (action) {
            case "/bookNow":
                processBooking(request, response);
                break;
            case "/updateBookingAction":
                processBookingUpdate(request, response);
                break;
        }
    }

    private void showBookingForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carId = request.getParameter("carId");
        Car car = carDAO.getCarById(carId);
        request.setAttribute("car", car);
        request.getRequestDispatcher("booking.jsp").forward(request, response);
    }

    private void processBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        String carId = request.getParameter("carId");
        String rentDateStr = request.getParameter("rentDate");
        String returnDateStr = request.getParameter("returnDate");

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date rentDate = new Date(sdf.parse(rentDateStr).getTime());
            Date returnDate = new Date(sdf.parse(returnDateStr).getTime());
            
            if (returnDate.before(rentDate)) {
                request.setAttribute("errorMessage", "Return date cannot be before the pickup date.");
                showBookingForm(request, response); // Reshow form with error
                return;
            }

            if (!rentalDAO.isCarAvailable(carId, rentDate, returnDate)) {
                 request.setAttribute("errorMessage", "Sorry, the selected dates are unavailable for this car.");
                 showBookingForm(request, response); // Reshow form with error
                 return;
            }

            Car car = carDAO.getCarById(carId);
            long diffInMillies = returnDate.getTime() - rentDate.getTime();
            long rentalDays = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
            if (rentalDays == 0) rentalDays = 1;

            BigDecimal totalPrice = car.getPricePerDay().multiply(new BigDecimal(rentalDays));

            Rental rental = new Rental();
            rental.setCustId(customer.getCustId());
            rental.setCarId(carId);
            rental.setRentDate(rentDate);
            rental.setReturnDate(returnDate);
            rental.setTotalPrice(totalPrice);
            rental.setCar(car);
            rental.setCustomer(customer);

            session.setAttribute("pendingRental", rental);
            response.sendRedirect("payment.jsp");
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect("carList?error=date_format");
        }
    }

    private void showBookingHistory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Customer customer = (Customer) request.getSession().getAttribute("customer");
        List<Rental> rentalHistory = rentalDAO.getRentalsByStatus(customer.getCustId());
        request.setAttribute("rentalHistory", rentalHistory);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String rentId = request.getParameter("rentId");
        Rental rental = (Rental) rentalDAO.getRentalsByStatus(rentId); // You need to implement getRentalById

        // Check if cancellation is allowed (more than 2 days before pickup)
        long diffInMillies = rental.getRentDate().getTime() - System.currentTimeMillis();
        long diffInDays = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);

        if (diffInDays >= 2) {
            rentalDAO.updateRentalStatus(rentId, "Cancelled", null, "Cancelled by user.");
            // Here you would trigger the 95% refund logic by calling the PaymentDAO
            // Payment payment = paymentDAO.getPaymentByRentalId(rentId);
            // BigDecimal refundAmount = payment.getPaymentAmount().multiply(new BigDecimal("0.95"));
            // paymentDAO.processRefund(payment.getPaymentId(), refundAmount);
            response.sendRedirect("bookingHistory?status=cancelled");
        } else {
            response.sendRedirect("bookingHistory?error=cancel_too_late");
        }
    }

    private void showUpdateBookingForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rentId = request.getParameter("rentId");
        Rental rental = (Rental) rentalDAO.getRentalsByStatus(rentId);
        request.setAttribute("rental", rental);
        request.getRequestDispatcher("updateBooking.jsp").forward(request, response);
    }

    private void processBookingUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String rentId = request.getParameter("rentId");
        String returnDateStr = request.getParameter("newReturnDate");
        
        // Fetch original rental to get carId and original dates
        Rental originalRental = (Rental) rentalDAO.getRentalsByStatus(rentId);
        
        try {
            Date newReturnDate = new Date(new SimpleDateFormat("yyyy-MM-dd").parse(returnDateStr).getTime());

            // Check availability for the extended period
            // You need to check from original return date + 1 day up to the new return date
            if (!rentalDAO.isCarAvailable(originalRental.getCarId(), originalRental.getReturnDate(), newReturnDate)) {
                 response.sendRedirect("updateBookingForm?rentId=" + rentId + "&error=unavailable");
                 return;
            }
            
            // Recalculate price and update the rental record
            // Then redirect to booking history
            response.sendRedirect("bookingHistory?status=updated");

        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}