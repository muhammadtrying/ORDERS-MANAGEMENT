package uz.pdp.task_2_collab.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import uz.pdp.task_2_collab.entity.Order;
import uz.pdp.task_2_collab.entity.Status;
import uz.pdp.task_2_collab.entity.User;

@WebListener
public class MyListener implements ServletContextListener {
    public static EntityManagerFactory emf;
    public static EntityManager em;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        emf = Persistence.createEntityManagerFactory("default");
        em = emf.createEntityManager();
        init();
        ServletContextListener.super.contextInitialized(sce);
    }

    private void init() {
        em.getTransaction().begin();

        User user = User.builder()
                .name("Muhammad")
                .password("1")
                .build();
        em.persist(user);

        Order order1 = Order.builder()
                .userId(user)
                .status(Status.OPEN)
                .build();
        Order order2 = Order.builder()
                .userId(user)
                .status(Status.IN_PROGRESS)
                .build();
        Order order3 = Order.builder()
                .userId(user)
                .status(Status.COMPLETED)
                .build();

        em.persist(order1);
        em.persist(order2);
        em.persist(order3);

        em.getTransaction().commit();
    }
}
