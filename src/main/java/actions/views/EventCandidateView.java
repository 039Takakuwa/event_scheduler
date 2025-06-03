package actions.views;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * イベント候補のDTO（Viewモデル）
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EventCandidateView implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;

    private EventView event;

    private Date date;

    private Time startTime;

    private Time endTime;
}
