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
    EVENT_ID("id"),
    EVENT_TITLE("title"),         // イベントタイトル
    EVENT_DESCRIPTION("description"), // イベント説明
    EVENT_ORGANIZER_ID("organizerId"), // イベント主催者ID
    EVENT_LIST("event_list");

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