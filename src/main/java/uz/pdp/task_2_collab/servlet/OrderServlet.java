package uz.pdp.task_2_collab.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.task_2_collab.entity.Order;
import uz.pdp.task_2_collab.repo.OrderRepo;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "order servlet", value = "/order/servlet")
public class OrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        OrderRepo orderRepo = new OrderRepo();
        List<Order> filteredOrders = orderRepo.findAll().stream().filter(order -> order.getStatus().name().equals(status)).toList();
        req.setAttribute("filteredOrders", filteredOrders);
        req.getRequestDispatcher("/").forward(req, resp);
    }
}
