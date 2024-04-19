package uz.pdp.task_2_collab.config;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.task_2_collab.entity.User;
import uz.pdp.task_2_collab.repo.UserRepo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@WebFilter(urlPatterns = "/*")
public class MyFilter implements Filter {
    private final List<String> openUrls = new ArrayList<>(List.of(
            "/",
            "http://localhost:8080/login.jsp",
            "/order/servlet",
            "/login.jsp",
            "/authServlet"
    ));

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String requestURI = request.getRequestURI();
        if (openUrls.contains(requestURI)) {
            filterChain.doFilter(request, servletResponse);
            return;
        }
        Object object = request.getSession().getAttribute("currentUser");

        if (object == null) {
            Optional<Cookie> optionalCookie = Arrays.stream(request.getCookies()).filter(cookie -> cookie.getName().equals("currentUser")).findFirst();
            if (optionalCookie.isPresent()) {
                Cookie cookie = optionalCookie.get();
                Integer userId = Integer.parseInt(cookie.getValue());
                UserRepo userRepo = new UserRepo();
                User user = userRepo.findById(userId);
                request.getSession().setAttribute("currentUser", user);
                filterChain.doFilter(servletRequest, servletResponse);
            } else {
                response.sendRedirect("/404__HE-HE-HE");
            }
            return;
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }
}
