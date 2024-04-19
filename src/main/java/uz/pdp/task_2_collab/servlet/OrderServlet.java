package uz.pdp.task_2_collab.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.task_2_collab.entity.Order;
import uz.pdp.task_2_collab.entity.Status;
import uz.pdp.task_2_collab.entity.User;
import uz.pdp.task_2_collab.repo.OrderRepo;
import uz.pdp.task_2_collab.repo.UserRepo;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "order servlet", value = "/order/servlet")
public class OrderServlet extends HttpServlet {
    private final OrderRepo orderRepo = new OrderRepo();
    private final UserRepo userRepo = new UserRepo();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer orderId = Integer.parseInt(req.getParameter("orderId"));
        Order order = orderRepo.findById(orderId);
        orderRepo.deleteById(order.getId());
        resp.sendRedirect("http://localhost:8080/orderDelete.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (req.getParameter("status") != null) {
            String status = req.getParameter("status");
            List<Order> filteredOrders = orderRepo.findAll().stream().filter(order -> order.getStatus().name().equals(status)).toList();
            req.getSession().setAttribute("filteredOrders", filteredOrders);
            resp.sendRedirect("http://localhost:8080/");
            return;
        } else if (req.getParameter("cameFrom") != null && req.getParameter("cameFrom").equals("/orderUpdate.jsp")) {
            Integer orderId = Integer.parseInt(req.getParameter("orderId"));
            Integer userId = Integer.parseInt(req.getParameter("userId"));
            String statusName = req.getParameter("statusName");

            Order order = orderRepo.findById(orderId);
            User user = userRepo.findById(userId);
            Status status = Status.valueOf(statusName);
            orderRepo.begin();
            order.setStatus(status);
            order.setUserId(user);
            resp.sendRedirect("http://localhost:8080/orderCrud.jsp");
            orderRepo.commit();
            return;
        } else if (req.getParameter("userId") != null) {
            Integer userId = Integer.parseInt(req.getParameter("userId"));

            User user = userRepo.findById(userId);
            Order order = Order.builder()
                    .userId(user)
                    .status(Status.OPEN)
                    .build();
            orderRepo.save(order);
            resp.sendRedirect("http://localhost:8080/orderCrud.jsp");
            return;
        }
        resp.sendRedirect("http://localhost:8080/orderCreate.jsp");
    }
}
