package uz.pdp.task_2_collab.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;

@WebServlet(name = "log out servlet", value = "/logOutServlet")
public class LogOutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().invalidate();

        String currentUserCookieName = "currentUser";
        Cookie currentUserCookie = Arrays.stream(req.getCookies())
                .filter(cookie -> cookie.getName().equals(currentUserCookieName))
                .findFirst().orElse(null);

        if (currentUserCookie != null) {
            currentUserCookie.setMaxAge(0);
            currentUserCookie.setPath("/");
            currentUserCookie.setSecure(false);
            resp.addCookie(currentUserCookie);
        }
        resp.sendRedirect("/");
    }
}
