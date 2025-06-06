package actions;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;

import actions.views.AttendanceView;
import actions.views.EventCandidateView;
import actions.views.EventView;
import actions.views.UserView;
import constants.AttributeConst;
import constants.ForwardConst;
import services.AttendanceService;
import services.EventCandidateService;
import services.EventService;
import services.UserService;

public class AttendanceAction extends ActionBase {

    private AttendanceService service;

    @Override
    public void process() throws ServletException, IOException {
        service = new AttendanceService();

        invoke();
        service.close();
    }

    // アンケート回答画面表示（例：候補と選択肢一覧を表示するだけなら）
    public void newAttendance() throws ServletException, IOException {
        EventCandidateView candidate = new EventCandidateService()
            .findOne(toNumber(getRequestParam(AttributeConst.CANDIDATE_ID)));
        putRequestScope(AttributeConst.CANDIDATE, candidate);
        
        forward(ForwardConst.FW_ATTENDANCE_NEW);
    }

    // 回答登録（POST）
    public void create() throws ServletException, IOException {
        EventCandidateView candidate = new EventCandidateService()
            .findOne(toNumber(getRequestParam(AttributeConst.CANDIDATE_ID)));

        UserView loginUser = (UserView) getSessionScope(AttributeConst.LOGIN_USER);
        if(loginUser == null) {
            forward(ForwardConst.FW_ERR_LOGIN);
        }
        
        Integer status = toNumber(getRequestParam(AttributeConst.ATTENDANCE_STATUS));

        // すでに存在する場合は更新、なければ新規作成
        AttendanceView existing = service.getMyAttendanceForCandidate(loginUser, candidate);
        if (existing == null) {
            AttendanceView newAtt = new AttendanceView(
                null, loginUser, candidate, status
            );
            service.create(newAtt);
        } else {
            existing.setStatus(status);
            service.update(existing);
        }

        // フラッシュメッセージ
        putSessionScope(AttributeConst.FLUSH, "アンケートの回答が保存されました。");

        // イベント詳細にリダイレクト（候補の日程一覧含む）
        redirect(ForwardConst.ACT_EVENT, ForwardConst.CMD_SHOW,
                 String.format("id=%d", candidate.getEvent().getId()));
    }
    
    public void summary() throws ServletException, IOException {
        Integer eventId = toNumber(getRequestParam(AttributeConst.EVENT_ID));
        EventView event = new EventService().findOne(eventId);
        List<EventCandidateView> candidateList = new EventCandidateService().getCandidatesByEvent(event);

        List<UserView> allUsers = new UserService().getAllUsers(); // 参加者リスト（全ユーザー）

        // 出欠サマリ生成
        Map<EventCandidateView, Map<String, List<UserView>>> summary =
                service.buildAttendanceSummary(candidateList, allUsers);

        // 出席最多の候補日IDを求める
        Integer maxAttendanceCandidateId = null;
        int maxAttendingCount = -1;

        for (Map.Entry<EventCandidateView, Map<String, List<UserView>>> entry : summary.entrySet()) {
            List<UserView> attending = entry.getValue().get("attending");
            if (attending != null && attending.size() > maxAttendingCount) {
                maxAttendingCount = attending.size();
                maxAttendanceCandidateId = entry.getKey().getId();
            }
        }

        // 合計値計算
        int totalAttending = 0;
        int totalAbsent = 0;
        int totalNotResponded = 0;

        for (Map<String, List<UserView>> statusMap : summary.values()) {
            totalAttending += statusMap.getOrDefault("attending", List.of()).size();
            totalAbsent += statusMap.getOrDefault("absent", List.of()).size();
            totalNotResponded += statusMap.getOrDefault("not_responded", List.of()).size();
        }

        Map<String, Integer> summaryTotals = Map.of(
            "attending", totalAttending,
            "absent", totalAbsent,
            "notResponded", totalNotResponded
        );

        // JSPに渡す
        putRequestScope(AttributeConst.EVENT, event);
        putRequestScope("attendance_summary", summary);
        putRequestScope("maxAttendanceCandidateId", maxAttendanceCandidateId);
        putRequestScope("summaryTotals", summaryTotals);

        forward(ForwardConst.FW_ATTENDANCE_SUMMARY);
    }


}
