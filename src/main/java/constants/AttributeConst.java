package constants;

/**
 * 画面の項目値等を定義するEnumクラス
 *
 */
public enum AttributeConst {

    //フラッシュメッセージ
    FLUSH("flush"),

    //一覧画面共通
    MAX_ROW("maxRow"),
    PAGE("page"),

    //入力フォーム共通
    ID("id"),
    TOKEN("_token"),
    ERR("errors"),

    //ユーザ管理
    USER("user"),
    USERS("users"),
    USER_ID("id"),
    USER_LIST("user_list"),
    USER_NAME("username"),
    USER_EMAIL("email"),
    USER_PASSWORD("password"),
    LOGIN_USER("login_user"),
    
    //イベント関連
    EVENTS("events"),             // イベント一覧
    EVENT("event"),               // 単一イベント
    EVENT_ID("event_id"),
    EVENT_TITLE("title"),         // イベントタイトル
    EVENT_DESCRIPTION("description"), // イベント説明
    EVENT_ORGANIZER_ID("organizerId"), // イベント主催者ID
    EVENT_LIST("event_list"),
    
    // イベント候補関連
    CANDIDATE("candidate"),                      // 単一候補
    CANDIDATES("candidates"),                    // 候補一覧
    CANDIDATE_ID("id"),
    CANDIDATE_EVENT("event"),                    // 所属イベント（EventView）
    CANDIDATE_DATE("candidate_date"),                      // 候補日付
    CANDIDATE_START_TIME("candidate_start_time"),          // 開始時刻
    CANDIDATE_END_TIME("candidate_end_time"),              // 終了時刻
    CANDIDATE_LIST("candidate_list"),
    
    // 出欠確認関連
    ATTENDANCE("attendance"),                    // 単一の出欠
    ATTENDANCES("attendances"),                  // 出欠一覧
    ATTENDANCE_ID("id"),
    ATTENDANCE_USER("user"),                     // 回答者（UserView）
    ATTENDANCE_CANDIDATE("candidate"),           // 候補（EventCandidateView）
    ATTENDANCE_STATUS("status"),                 // 回答内容（0: 出席、1: 未定、2: 欠席）
    
    ATTEND_STATUS_ATTENDING("0"),
    ATTEND_STATUS_ABSENT("1"),
    ATTEND_STATUS_MAYBE("2"),

    CMD("command");

    private final String text;
    private final Integer i;

    private AttributeConst(final String text) {
        this.text = text;
        this.i = null;
    }

    private AttributeConst(final Integer i) {
        this.text = null;
        this.i = i;
    }

    public String getValue() {
        return this.text;
    }

    public Integer getIntegerValue() {
        return this.i;
    }

}