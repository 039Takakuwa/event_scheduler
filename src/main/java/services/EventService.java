package services;

import java.util.List;

import jakarta.persistence.EntityManager;

import actions.views.EventConverter;
import actions.views.EventView;
import actions.views.UserConverter;
import models.Attendance;
import models.Event;
import models.EventCandidate;
import utils.DBUtil;

public class EventService {

    private EntityManager em;

    public EventService() {
        this.em = DBUtil.createEntityManager();
    }

    /**
     * 全イベントを取得（最新順）
     */
    public List<EventView> getAllEvents() {
        List<Event> events = em.createNamedQuery("Event.getAll", Event.class)
                               .getResultList();
        return EventConverter.toViewList(events);
    }

    /**
     * IDから1件のイベントを取得
     */
    public EventView findOne(int id) {
        return EventConverter.toView(em.find(Event.class, id));
    }

    /**
     * イベントを新規作成
     */
    public void create(EventView ev) {
        em.getTransaction().begin();
        em.persist(EventConverter.toModel(ev));
        em.getTransaction().commit();
    }

    /**
     * イベント情報を更新
     */
    public void update(EventView ev) {
        em.getTransaction().begin();
        Event e = em.find(Event.class, ev.getId());
        if (e != null) {
            // フィールドの更新
            e.setTitle(ev.getTitle());
            e.setDescription(ev.getDescription());
            e.setOrganizer(UserConverter.toModel(ev.getOrganizer()));
            e.setCreatedAt(ev.getCreatedAt());
        }
        em.getTransaction().commit();
    }

    /**
     * イベントを削除（論理削除に対応するならdeleteFlagを設定）
     */
    public void delete(int eventId) {
        em.getTransaction().begin();

        Event event = em.find(Event.class, eventId);
        if (event != null) {

            // 1. Eventにぶら下がっているEventCandidateをすべて取得
            List<EventCandidate> candidates = em.createQuery(
                "SELECT ec FROM EventCandidate ec WHERE ec.event = :event", EventCandidate.class)
                .setParameter("event", event)
                .getResultList();

            for (EventCandidate ec : candidates) {
                // 1-1. Attendanceも削除
                List<Attendance> attendances = em.createQuery(
                    "SELECT a FROM Attendance a WHERE a.candidate = :candidate", Attendance.class)
                    .setParameter("candidate", ec)
                    .getResultList();

                for (Attendance a : attendances) {
                    em.remove(a);
                }

                em.remove(ec);
            }

            // 2. Event削除（これで初めて通るようになる）
            System.out.println("[DEBUG] Deleting event: " + event.getTitle());
            em.remove(event);
        } else {
            System.out.println("[DEBUG] event not found for ID: " + eventId);
        }

        em.getTransaction().commit();
    }


    /**
     * EntityManagerのクローズ
     */
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }
}
