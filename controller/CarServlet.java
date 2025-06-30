package thrifty.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import thrifty.DAO.CarDAO;
import thrifty.model.Admin;
import thrifty.model.Car;

@WebServlet(urlPatterns = {
    "/carList", 
    "/carDetails", 
    "/admin/viewCars", 
    "/admin/addCarForm", 
    "/admin/addCarAction",
    "/admin/editCarForm", 
    "/admin/updateCarAction", 
    "/admin/deleteCarAction"
})
public class CarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CarDAO carDAO;

    public void init() {
        carDAO = new CarDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        try {
            switch (action) {
                case "/admin/addCarAction":
                    addCarAction(request, response);
                    break;
                case "/admin/updateCarAction":
                    updateCarAction(request, response);
                    break;
                case "/admin/deleteCarAction":
                     deleteCarAction(request, response);
                     break;
                default:
                    doGet(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        try {
            switch (action) {
                case "/carList":
                    listCarsForCustomer(request, response);
                    break;
                case "/carDetails":
                    showCarDetailsForCustomer(request, response);
                    break;
                case "/admin/viewCars":
                    listCarsForAdmin(request, response);
                    break;
                case "/admin/addCarForm":
                    request.getRequestDispatcher("/admin/add-car.jsp").forward(request, response);
                    break;
                case "/admin/editCarForm":
                    showEditCarForm(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/home.jsp");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // --- Customer Methods ---
    private void listCarsForCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Car> carList = carDAO.getAllCars();
        request.setAttribute("carList", carList);
        request.getRequestDispatcher("carList.jsp").forward(request, response);
    }

    private void showCarDetailsForCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carId = request.getParameter("carId");
        Car car = carDAO.getCarById(carId);
        request.setAttribute("car", car);
        request.getRequestDispatcher("car-details.jsp").forward(request, response);
    }
    
    // --- Admin Methods ---
    private void listCarsForAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Car> carList = carDAO.getAllCars();
        request.setAttribute("carList", carList);
        request.getRequestDispatcher("/admin/view-car.jsp").forward(request, response);
    }

    private void showEditCarForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carId = request.getParameter("carId");
        Car existingCar = carDAO.getCarById(carId);
        request.setAttribute("car", existingCar);
        request.getRequestDispatcher("/admin/update-car.jsp").forward(request, response);
    }

    private void addCarAction(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        Car newCar = new Car();
        newCar.setAdminId(admin.getAdminId());
        newCar.setCarBrand(request.getParameter("carBrand"));
        newCar.setCarType(request.getParameter("carType"));
        newCar.setCarColour(request.getParameter("carColour"));
        newCar.setCarPlateNum(request.getParameter("plateNumber"));
        newCar.setPricePerDay(new BigDecimal(request.getParameter("pricePerDay")));
        newCar.setCarDescription(request.getParameter("carDescription"));
        newCar.setCarImage("images/" + request.getParameter("carImage")); // Assuming images are in WebContent/images
        
        carDAO.addCar(newCar);
        response.sendRedirect(request.getContextPath() + "/admin/viewCars");
    }

    private void updateCarAction(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Car car = new Car();
        car.setCarId(request.getParameter("carId"));
        car.setCarBrand(request.getParameter("carBrand"));
        car.setCarType(request.getParameter("carType"));
        car.setCarColour(request.getParameter("carColour"));
        car.setCarPlateNum(request.getParameter("plateNumber"));
        car.setPricePerDay(new BigDecimal(request.getParameter("pricePerDay")));
        car.setCarDescription(request.getParameter("carDescription"));
        car.setCarImage(request.getParameter("carImage"));
        car.setCarStatus(request.getParameter("carStatus"));

        carDAO.updateCar(car);
        response.sendRedirect(request.getContextPath() + "/admin/viewCars");
    }

    private void deleteCarAction(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String carId = request.getParameter("carId");
        carDAO.deleteCar(carId);
        response.sendRedirect(request.getContextPath() + "/admin/viewCars");
    }
}