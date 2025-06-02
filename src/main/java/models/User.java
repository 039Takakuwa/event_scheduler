package models;

import java.sql.Timestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@NamedQueries({
        @NamedQuery(name = "getAllUsers", query = "SELECT u FROM User AS u ORDER BY u.id DESC"),
        @NamedQuery(name = "User.getByUsernameAndPassword", query = "SELECT u FROM User u WHERE u.username = :username AND u.password_hash = :password_hash")
})
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "username", length = 50, nullable = false)
    private String username;

    @Column(name = "email", length = 100, nullable = false)
    private String email;

    @Column(name = "password_hash", length = 255, nullable = false)
    private String password_hash;

    @Column(name = "created_at", nullable = false)
    private Timestamp created_at;

}