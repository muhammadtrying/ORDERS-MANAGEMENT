package uz.pdp.task_2_collab.entity;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.sql.Timestamp;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@Entity
@Table(name = "orders")
public class Order extends BaseEntity {
    @ManyToOne
    private User userId;
    @Enumerated(EnumType.STRING)
    private Status status;
    @CreationTimestamp
    private Timestamp createdAt;

    @Builder
    public Order(Integer id, User userId, Status status) {
        super(id);
        this.userId = userId;
        this.status = status;
    }
}
