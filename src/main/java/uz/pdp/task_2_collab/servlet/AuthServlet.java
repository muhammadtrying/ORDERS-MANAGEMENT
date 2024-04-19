package uz.pdp.task_2_collab.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import uz.pdp.task_2_collab.entity.User;
import uz.pdp.task_2_collab.repo.UserRepo;

import java.io.IOException;
import java.util.Objects;
import java.util.Optional;

@WebServlet(name = "auth servlet", value = "/authServlet")
public class AuthServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String rememberMe = req.getParameter("rememberMe");
        UserRepo userRepo = new UserRepo();
        Optional<User> optionalUser = userRepo.findByName(name);

        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            if (user.getPassword().equals(password)) {
                HttpSession session = req.getSession();
                session.setAttribute("currentUser", user);

                if (Objects.equals(rememberMe, "on")) {
                    Cookie cookie = new Cookie(
                            "currentUser", user.getId().toString()
                    );

                    cookie.setPath("/");
                    cookie.setSecure(false);
                    cookie.setMaxAge(60 * 60);
                    resp.addCookie(cookie);
                }
                resp.sendRedirect("/");
                return;
            }
        }
        resp.sendRedirect("/login.jsp");
    }
}
