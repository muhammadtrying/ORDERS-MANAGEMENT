package uz.pdp.task_2_collab.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.task_2_collab.entity.User;
import uz.pdp.task_2_collab.repo.UserRepo;

import java.io.IOException;

@WebServlet(name = "user servlet", value = "/userServlet")
public class UserServlet extends HttpServlet {
    private final UserRepo userRepo = new UserRepo();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String cameFrom = req.getParameter("cameFrom");
        if (cameFrom.equals("/userCreate.jsp")) {
            String name = req.getParameter("name");
            if (name.isBlank()) {
                resp.sendRedirect("http://localhost:8080/userCreate.jsp");
                return;
            }
            User user = User.builder()
                    .name(name)
                    .build();
            userRepo.save(user);
        } else if (cameFrom.equals("/userUpdate.jsp")) {
            String name = req.getParameter("name");
            Integer userId = Integer.parseInt(req.getParameter("userId"));
            if (name.isBlank()) {
                resp.sendRedirect("http://localhost:8080/userUpdate.jsp?userId="+userId);
                return;
            }
            User user = userRepo.findById(userId);
            userRepo.begin();
            user.setName(name);
            userRepo.commit();
        }
        resp.sendRedirect("http://localhost:8080/userCrud.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        User user = userRepo.findById(userId);
        userRepo.deleteById(user.getId());
        resp.sendRedirect("http://localhost:8080/userDelete.jsp");
    }
}
