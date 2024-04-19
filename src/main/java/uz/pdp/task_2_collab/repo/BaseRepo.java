package uz.pdp.task_2_collab.repo;

import jakarta.persistence.EntityManager;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import static uz.pdp.task_2_collab.config.MyListener.emf;

public class BaseRepo<T, I> {
    private final EntityManager em = emf.createEntityManager();
    public Class<T> persistenceClass;

    public BaseRepo() {
        Type type = getClass().getGenericSuperclass();
        ParameterizedType paramType = (ParameterizedType) type;
        this.persistenceClass = (Class<T>) paramType.getActualTypeArguments()[0];
    }

    public void deleteById(I id) {
        begin();
        em.remove(em.find(persistenceClass, id));
        commit();
    }

    public T findById(I id) {
        return em.find(persistenceClass, id);
    }

    public List<T> findAll() {
        return em.createQuery("from " + persistenceClass.getSimpleName(), persistenceClass).getResultList();
    }

    void save(T t) {
        begin();
        em.persist(t);
        commit();
    }

    void begin() {
        em.getTransaction().begin();
    }

    void commit() {
        em.getTransaction().commit();
    }
}
