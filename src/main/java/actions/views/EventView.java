package actions.views;

import java.io.Serializable;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EventView implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;
    
    private String title;
    
    private String description;
    
    private UserView organizer;
    
    private Timestamp createdAt;
}
