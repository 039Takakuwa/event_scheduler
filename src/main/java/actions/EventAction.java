package actions;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;

import actions.views.AttendanceView;
import actions.views.EventCandidateView;
import actions.views.EventView;
import actions.views.UserView;
import constants.AttributeConst;
import constants.ForwardConst;
import constants.MessageConst;
import services.AttendanceService;
import services.EventCandidateService;
import services.EventService;

public class EventAction extends ActionBase {

    private EventService service;

    @Override
    public void process() throws ServletException, IOException {
        if (getSessionScope(AttributeConst.LOGIN_USER) == null) {
            redirect(ForwardConst.ACT_LOG, ForwardConst.CMD_SHOW);
            return;
        }
        service = new EventService();

        // メソッドを実行
        invoke();

        service.close();
    }

    /**
     * 一覧画面の表示
     */
    public void index() throws ServletException, IOException {
        List<EventView> events = service.getAllEvents();
        putRequestScope(AttributeConst.EVENT_LIST, events);

        putRequestScope("actEvn", ForwardConst.ACT_EVENT.getValue());
        putRequestScope("commShow", ForwardConst.CMD_SHOW.getValue());
        putRequestScope("commNew", ForwardConst.CMD_NEW.getValue());
        putRequestScope("commIdx", ForwardConst.CMD_INDEX.getValue());

        forward(ForwardConst.FW_EVENT_INDEX);
    }

    /**
     * 新規登録画面の表示
     */
    public void entryNew() throws ServletException, IOException {
        putRequestScope(AttributeConst.TOKEN, getTokenId());
        putRequestScope(AttributeConst.EVENT, new EventView());

        forward(ForwardConst.FW_EVENT_NEW);
    }

    /**
     * イベントの登録処理
     */
    public void create() throws ServletException, IOException {
        Timestamp now = new Timestamp(System.currentTimeMillis());

        EventView ev = new EventView(
                null,
                getRequestParam(AttributeConst.EVENT_TITLE),
                getRequestParam(AttributeConst.EVENT_DESCRIPTION),
                getSessionScope(AttributeConst.LOGIN_USER), // organizer
                now);

        service.create(ev);

        putSessionScope(AttributeConst.FLUSH, MessageConst.I_REGISTERED.getMessage());

        redirect(ForwardConst.ACT_EVENT, ForwardConst.CMD_INDEX);
    }

    /**
     * イベント詳細画面の表示
     */
    public void show() throws ServletException, IOException {
        EventView ev = service.findOne(toNumber(getRequestParam(AttributeConst.ID)));

        if (ev == null) {
            forward(ForwardConst.FW_ERR_UNKNOWN);
            return;
        }

        // 候補一覧を取得してリクエストスコープに格納
        List<EventCandidateView> candidates = new EventCandidateService().getCandidatesByEvent(ev);
        System.out.println("候補日件数: " + candidates.size());

        putRequestScope(AttributeConst.CANDIDATE_LIST, candidates);

        UserView loginUser = (UserView) getSessionScope(AttributeConst.LOGIN_USER);
        
        AttendanceService attendanceService = new AttendanceService();

        // 出席情報を取得（候補ごとの自分の回答）
        Map<EventCandidateView, AttendanceView> myAttendances = attendanceService.getMyAttendancesMap(loginUser,
                candidates);

        putRequestScope("my_attendances", myAttendances);
        
        attendanceService.close();

        putRequestScope(AttributeConst.EVENT, ev);
        forward(ForwardConst.FW_EVENT_SHOW);
    }

    /**
     * 編集画面の表示
     */
    public void edit() throws ServletException, IOException {
        EventView ev = service.findOne(toNumber(getRequestParam(AttributeConst.ID)));

        if (ev == null) {
            forward(ForwardConst.FW_ERR_UNKNOWN);
            return;
        }

        putRequestScope(AttributeConst.TOKEN, getTokenId());
        putRequestScope(AttributeConst.EVENT, ev);

        forward(ForwardConst.FW_EVENT_EDIT);
    }

    /**
     * イベント更新処理
     */
    public void update() throws ServletException, IOException {
        Integer id = toNumber(getRequestParam(AttributeConst.EVENT_ID));
        EventView ev = service.findOne(id);

        if (ev == null) {
            forward(ForwardConst.FW_ERR_UNKNOWN);
            return;
        }

        ev.setTitle(getRequestParam(AttributeConst.EVENT_TITLE));
        ev.setDescription(getRequestParam(AttributeConst.EVENT_DESCRIPTION));

        service.update(ev);

        putSessionScope(AttributeConst.FLUSH, "イベントを更新しました。");

        redirect(ForwardConst.ACT_EVENT, ForwardConst.CMD_INDEX);
    }

    /**
     * イベント削除処理（完全削除）
     */
    public void destroy() throws ServletException, IOException {
        Integer id = toNumber(getRequestParam(AttributeConst.EVENT_ID));
        service.delete(id);

        putSessionScope(AttributeConst.FLUSH, "イベントを削除しました。");

        redirect(ForwardConst.ACT_EVENT, ForwardConst.CMD_INDEX);
    }

}
