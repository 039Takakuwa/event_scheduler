package actions.views;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AttendanceView implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;

    private UserView user;

    private EventCandidateView candidate;

    // 出欠ステータス（0=未定, 1=出席, 2=欠席）
    private Integer status;
}