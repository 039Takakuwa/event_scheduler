package actions.views;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor 
public class UserView {
    private Integer id;

    private String username;

    private String email;

    private String password_hash;

    private Timestamp createdAt;
}
