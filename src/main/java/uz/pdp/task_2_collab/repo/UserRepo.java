package uz.pdp.task_2_collab.repo;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import uz.pdp.task_2_collab.entity.User;

import java.util.List;
import java.util.Optional;

public class UserRepo extends BaseRepo<User, Integer> {

    public Optional<User> findByName(String name) {
        List<User> all = findAll();
        return all.stream().filter(u -> u.getName().equals(name)).findFirst();
    }

    public Optional<User> getUserByCookie(HttpServletRequest request) {
        if (request.getCookies() == null) {
            return Optional.empty();
        }

        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("currentUser")) {
                return Optional.of(findById(Integer.parseInt(cookie.getValue())));
            }
        }
        return Optional.empty();
    }
}
