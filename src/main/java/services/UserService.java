package services;

import java.util.List;

import actions.views.UserConverter;
import actions.views.UserView;
import models.Attendance;
import models.Event;
import models.EventCandidate;
import models.User;

public class UserService extends ServiceBase {

    /**
     * 全ユーザーのリストを取得してUserViewのリストとして返す
     */
    public List<UserView> getAllUsers() {
        List<User> users = em.createNamedQuery("getAllUsers", User.class)
                .getResultList();
        return UserConverter.toViewList(users);
    }

    /**
     * 指定されたIDに対応するユーザーを取得
     */
    public UserView findOne(int id) {
        return UserConverter.toView(em.find(User.class, id));
    }

    /**
     * ユーザー情報を新規登録
     */
    public void create(UserView uv) {
        em.getTransaction().begin();
        em.persist(UserConverter.toModel(uv));
        em.getTransaction().commit();
    }

    /**
     * ユーザー情報を更新
     */
    public void update(UserView uv) {
        em.getTransaction().begin();
        User u = em.find(User.class, uv.getId());
        UserConverter.copyViewToModel(u, uv);
        em.getTransaction().commit();
    }

    /**
     * 指定IDのユーザーを削除
     */
    public void destroy(int id) {
        em.getTransaction().begin();

        User u = em.find(User.class, id);
        if (u != null) {

            // 1. UserがorganizerのEventを取得
            List<Event> events = em.createQuery(
                "SELECT e FROM Event e WHERE e.organizer = :user", Event.class)
                .setParameter("user", u)
                .getResultList();

            for (Event e : events) {

                // 1-1. そのEventに属するEventCandidateを取得
                List<EventCandidate> candidates = em.createQuery(
                    "SELECT ec FROM EventCandidate ec WHERE ec.event = :event", EventCandidate.class)
                    .setParameter("event", e)
                    .getResultList();

                for (EventCandidate ec : candidates) {
                    // 1-1-1. そのEventCandidateに紐づくAttendanceを削除
                    List<Attendance> acs = em.createQuery(
                        "SELECT a FROM Attendance a WHERE a.candidate = :candidate", Attendance.class)
                        .setParameter("candidate", ec)
                        .getResultList();

                    for (Attendance a : acs) {
                        em.remove(a);
                    }

                    em.remove(ec); // EventCandidate削除
                }

                em.remove(e); // Event削除
            }

            // 2. そのUserが回答したAttendanceも削除（他人のイベントへの出欠）
            List<Attendance> attendances = em.createQuery(
                    "SELECT a FROM Attendance a WHERE a.user = :user", Attendance.class)
                    .setParameter("user", u)
                    .getResultList();

            for (Attendance a : attendances) {
                em.remove(a);
            }

            // 3. User自体を削除
            em.remove(u);
        }

        em.getTransaction().commit();
    }


    public User findByUsernameAndPassword(String username, String password_hash) {
        User user = null;
        try {
            user = em.createNamedQuery("User.getByUsernameAndPassword", User.class)
                    .setParameter("username", username)
                    .setParameter("password_hash", password_hash)
                    .getSingleResult();
        } catch (Exception e) {
            // 該当ユーザーなし
        }
        return user;
    }
}
