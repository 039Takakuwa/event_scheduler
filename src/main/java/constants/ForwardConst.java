package constants;

/**
 * リクエストパラメーターの変数名、変数値、jspファイルの名前等画面遷移に関わる値を定義するEnumクラス
 *
 */
public enum ForwardConst {

    //action
    ACT("action"),
    ACT_USR("User"),
    ACT_LOG("Log"),
    ACT_EVENT("Event"),

    //command
    CMD("command"),
    CMD_NONE(""),
    CMD_INDEX("index"),
    CMD_SHOW("show"),
    CMD_SHOW_LOGIN("showLogin"),
    CMD_LOGIN("login"),
    CMD_LOGOUT("logout"),
    CMD_NEW("entryNew"),
    CMD_CREATE("create"),
    CMD_EDIT("edit"),
    CMD_UPDATE("update"),
    CMD_DESTROY("destroy"),

    //jsp
    FW_ERR_UNKNOWN("error/unknown"),
    FW_ERR_LOGIN("error/login_error"),
    FW_USER_INDEX("users/index"),
    FW_USER_SHOW("users/show"),
    FW_USER_NEW("users/new"),
    FW_USER_EDIT("users/edit"),
    FW_LOGIN("login/show"),
    
    // 遷移先jsp
    FW_EVENT_INDEX("events/index"),
    FW_EVENT_SHOW("events/show"),
    FW_EVENT_NEW("events/new"),
    FW_EVENT_EDIT("events/edit");

    
    /**
     * 文字列
     */
    private final String text;

    /**
     * コンストラクタ
     */
    private ForwardConst(final String text) {
        this.text = text;
    }

    /**
     * 値(文字列)取得
     */
    public String getValue() {
        return this.text;
    }

}