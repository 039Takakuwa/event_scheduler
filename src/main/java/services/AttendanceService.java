package services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.persistence.NoResultException;

import actions.views.AttendanceConverter;
import actions.views.AttendanceView;
import actions.views.EventCandidateConverter;
import actions.views.EventCandidateView;
import actions.views.UserConverter;
import actions.views.UserView;
import models.Attendance;

public class AttendanceService extends ServiceBase {

    // 出欠の作成
    public void create(AttendanceView av) {
        em.getTransaction().begin();
        em.persist(AttendanceConverter.toModel(av));
        em.getTransaction().commit();
    }

    // 出欠の更新
    public void update(AttendanceView av) {
        em.getTransaction().begin();
        Attendance a = em.find(Attendance.class, av.getId());
        a.setStatus(av.getStatus());
        em.getTransaction().commit();
    }

    // 特定候補に対するすべての出欠情報を取得
    public List<AttendanceView> getAttendancesForCandidate(EventCandidateView candidate) {
        List<Attendance> attendances = em.createNamedQuery("getAttendancesForCandidate", Attendance.class)
            .setParameter("candidate", EventCandidateConverter.toModel(candidate))
            .getResultList();
        return attendances.stream()
            .map(AttendanceConverter::toView)
            .collect(Collectors.toList());
    }

    // 特定ユーザーと候補に対する出欠を1件取得
    public AttendanceView getMyAttendanceForCandidate(UserView user, EventCandidateView candidate) {
        try {
            Attendance attendance = em.createNamedQuery("getMyAttendanceForCandidate", Attendance.class)
                .setParameter("user", UserConverter.toModel(user))
                .setParameter("candidate", EventCandidateConverter.toModel(candidate))
                .getSingleResult();
            return AttendanceConverter.toView(attendance);
        } catch (NoResultException e) {
            return null;
        }
    }
    
    public Map<EventCandidateView, AttendanceView> getMyAttendancesMap(UserView user, List<EventCandidateView> candidates) {
        Map<EventCandidateView, AttendanceView> map = new LinkedHashMap<>();
        for (EventCandidateView candidate : candidates) {
            AttendanceView att = getMyAttendanceForCandidate(user, candidate);
            map.put(candidate, att);
        }
        return map;
    }
    
    public Map<EventCandidateView, Map<String, List<UserView>>> buildAttendanceSummary(
            List<EventCandidateView> candidates, List<UserView> allUsers) {

        Map<EventCandidateView, Map<String, List<UserView>>> result = new LinkedHashMap<>();

        for (EventCandidateView candidate : candidates) {
            Map<String, List<UserView>> map = new HashMap<>();
            map.put("attending", new ArrayList<>());
            map.put("absent", new ArrayList<>());
            map.put("not_responded", new ArrayList<>(allUsers)); // 全員未回答で初期化

            List<AttendanceView> responses = getAttendancesForCandidate(candidate); // 各候補への出欠一覧

            for (AttendanceView attendance : responses) {
                UserView user = attendance.getUser();
                map.get("not_responded").remove(user); // 回答済みなら削除
                if (attendance.getStatus() == 0) {
                    map.get("attending").add(user);
                } else if (attendance.getStatus() == 1) {
                    map.get("absent").add(user);
                }
            }

            result.put(candidate, map);
        }

        return result;
    }
}
