package services;

import java.util.List;

import jakarta.persistence.EntityManager;

import actions.views.EventCandidateConverter;
import actions.views.EventCandidateView;
import actions.views.EventConverter;
import actions.views.EventView;
import models.Event;
import models.EventCandidate;
import utils.DBUtil;

public class EventCandidateService {

    private EntityManager em;

    public EventCandidateService() {
        this.em = DBUtil.createEntityManager();
    }

    /**
     * 指定イベントに紐づく候補日時一覧を取得
     */
    public List<EventCandidateView> getCandidatesByEvent(EventView eventView) {
        Event event = EventConverter.toModel(eventView);
        List<EventCandidate> candidates = em.createNamedQuery("EventCandidate.getByEvent", EventCandidate.class)
            .setParameter("event", event)
            .getResultList();

        return EventCandidateConverter.toViewList(candidates);
    }

    /**
     * 新しい候補日時を登録
     */
    public void create(EventCandidateView evcView) {
        em.getTransaction().begin();
        em.persist(EventCandidateConverter.toModel(evcView));
        em.getTransaction().commit();
    }

    /**
     * 候補日時の削除（物理削除）
     */
    public void delete(int id) {
        EventCandidate evc = em.find(EventCandidate.class, id);
        if (evc != null) {
            em.getTransaction().begin();
            em.remove(evc);
            em.getTransaction().commit();
        }
    }

    /**
     * EntityManagerを閉じる
     */
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }
    
    // 主キーから候補日データ1件を取得してViewに変換して返す
    public EventCandidateView findOne(int id) {
        EventCandidate ec = em.find(EventCandidate.class, id);
        return EventCandidateConverter.toView(ec);
    }
}
