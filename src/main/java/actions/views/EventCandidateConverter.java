package actions.views;

import java.util.ArrayList;
import java.util.List;

import models.EventCandidate;

/**
 * EventCandidateのDTO ⇔ Entity 相互変換クラス
 */
public class EventCandidateConverter {

    /**
     * DTO → Entity
     */
    public static EventCandidate toModel(EventCandidateView evcView) {
        return new EventCandidate(
                evcView.getId(),
                EventConverter.toModel(evcView.getEvent()),
                evcView.getDate(),
                evcView.getStartTime(),
                evcView.getEndTime()
        );
    }

    /**
     * Entity → DTO
     */
    public static EventCandidateView toView(EventCandidate evc) {
        if (evc == null) {
            return null;
        }

        return new EventCandidateView(
                evc.getId(),
                EventConverter.toView(evc.getEvent()),
                evc.getDate(),
                evc.getStartTime(),
                evc.getEndTime()
        );
    }

    /**
     * Entityのリスト → DTOのリスト
     */
    public static List<EventCandidateView> toViewList(List<EventCandidate> list) {
        List<EventCandidateView> evcViews = new ArrayList<>();

        for (EventCandidate evc : list) {
            evcViews.add(toView(evc));
        }

        return evcViews;
    }
}
