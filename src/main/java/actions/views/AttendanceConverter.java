package actions.views;

import java.util.ArrayList;
import java.util.List;

import models.Attendance;

public class AttendanceConverter {

    // View → Model
    public static Attendance toModel(AttendanceView av) {
        return new Attendance(
            av.getId(),
            UserConverter.toModel(av.getUser()),
            EventCandidateConverter.toModel(av.getCandidate()),
            av.getStatus()
        );
    }

    // Model → View
    public static AttendanceView toView(Attendance a) {
        if (a == null) {
            return null;
        }

        return new AttendanceView(
            a.getId(),
            UserConverter.toView(a.getUser()),
            EventCandidateConverter.toView(a.getCandidate()),
            a.getStatus()
        );
    }

    // Viewのリスト → Modelのリスト
    public static List<Attendance> toModelList(List<AttendanceView> avList) {
        List<Attendance> aList = new ArrayList<>();
        for (AttendanceView av : avList) {
            aList.add(toModel(av));
        }
        return aList;
    }

    // Modelのリスト → Viewのリスト
    public static List<AttendanceView> toViewList(List<Attendance> aList) {
        List<AttendanceView> avList = new ArrayList<>();
        for (Attendance a : aList) {
            avList.add(toView(a));
        }
        return avList;
    }

    // Viewの内容を既存のModelにコピー
    public static void copyViewToModel(Attendance a, AttendanceView av) {
        a.setId(av.getId());
        a.setUser(UserConverter.toModel(av.getUser()));
        a.setCandidate(EventCandidateConverter.toModel(av.getCandidate()));
        a.setStatus(av.getStatus());
    }
}
