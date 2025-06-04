package actions;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import jakarta.servlet.ServletException;

import actions.views.EventCandidateView;
import actions.views.EventView;
import constants.AttributeConst;
import constants.ForwardConst;
import services.EventCandidateService;
import services.EventService;

public class EventCandidateAction extends ActionBase {

    private EventCandidateService candidateService;
    private EventService eventService;

    @Override
    public void process() throws ServletException, IOException {
        candidateService = new EventCandidateService();
        eventService = new EventService();

        invoke();

        candidateService.close();
        eventService.close();
    }

    /**
     * 候補一覧の表示（特定イベントに紐づく）
     */
    public void index() throws ServletException, IOException {
        System.out.println("EventCandidateAction#index start");

        Integer eventId = toNumber(getRequestParam(AttributeConst.EVENT_ID));
        System.out.println("eventId = " + eventId);

        EventView event = eventService.findOne(eventId);
        System.out.println("event = " + event);

        if (event == null) {
            System.out.println("event is null, forwarding to error page");
            forward(ForwardConst.FW_ERR_UNKNOWN);
            return;
        }

        List<EventCandidateView> candidates = candidateService.getCandidatesByEvent(event);
        System.out.println("candidates size = " + candidates.size());

        putRequestScope(AttributeConst.CANDIDATE_LIST, candidates);
        putRequestScope(AttributeConst.EVENT, event);

        putRequestScope("actCnd", ForwardConst.ACT_CANDIDATE.getValue());
        putRequestScope("commShow", ForwardConst.CMD_SHOW.getValue());
        putRequestScope("commNew", ForwardConst.CMD_NEW.getValue());
        putRequestScope("commIdx", ForwardConst.CMD_INDEX.getValue());

        System.out.println("forward to candidate index JSP");
        forward(ForwardConst.FW_CANDIDATE_INDEX);
    }

    /**
     * 新規候補日時登録画面の表示
     */
    public void entryNew() throws ServletException, IOException {
        Integer eventId = toNumber(getRequestParam(AttributeConst.EVENT_ID));
        EventView event = eventService.findOne(eventId);

        putRequestScope(AttributeConst.TOKEN, getTokenId());
        putRequestScope(AttributeConst.EVENT, event);
        putRequestScope(AttributeConst.CANDIDATE, new EventCandidateView());

        forward(ForwardConst.FW_CANDIDATE_NEW);
    }

    /**
     * 候補日時の登録
     */
    public void create() throws ServletException, IOException {
        String rawEventId = getRequestParam(AttributeConst.EVENT_ID);
        System.out.println("【DEBUG】raw event_id param = " + rawEventId);

        Integer parsedEventId = toNumber(rawEventId);
        System.out.println("【DEBUG】parsed event_id = " + parsedEventId);

        EventView event = eventService.findOne(parsedEventId);
        System.out.println("【DEBUG】fetched event = " + event);
        //        EventView event = eventService.findOne(toNumber(getRequestParam(AttributeConst.EVENT_ID)));

        System.out.println("candidate_date: " + getRequestParam(AttributeConst.CANDIDATE_DATE));
        System.out.println("start_time: " + getRequestParam(AttributeConst.CANDIDATE_START_TIME));
        System.out.println("end_time: " + getRequestParam(AttributeConst.CANDIDATE_END_TIME));

        String dateStr = getRequestParam(AttributeConst.CANDIDATE_DATE);
        String startStr = getRequestParam(AttributeConst.CANDIDATE_START_TIME);
        String endStr = getRequestParam(AttributeConst.CANDIDATE_END_TIME);

        try {
            Date date = Date.valueOf(dateStr);
            Time start = Time.valueOf(startStr + ":00");
            Time end = Time.valueOf(endStr + ":00");

            EventCandidateView evc = new EventCandidateView(null, event, date, start, end);
            candidateService.create(evc);
            putSessionScope(AttributeConst.FLUSH, "候補日時を登録しました。");
            redirect(ForwardConst.ACT_CANDIDATE, ForwardConst.CMD_INDEX, "&event_id=" + event.getId());
        } catch (Exception e) {
            e.printStackTrace();
            putRequestScope(AttributeConst.ERR, List.of("日付または時間の形式が正しくありません"));
            putRequestScope(AttributeConst.EVENT, event);
            forward(ForwardConst.FW_CANDIDATE_NEW);
        }
    }

    /**
     * 候補の削除
     */
    public void destroy() throws ServletException, IOException {
        EventView event = eventService.findOne(toNumber(getRequestParam(AttributeConst.EVENT_ID)));
        Integer id = toNumber(getRequestParam(AttributeConst.ID));

        candidateService.delete(id);

        putSessionScope(AttributeConst.FLUSH, "候補日時を削除しました。");

        redirect(ForwardConst.ACT_CANDIDATE, ForwardConst.CMD_INDEX, "?id=" + event.getId());
    }
}
