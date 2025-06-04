package actions;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import jakarta.servlet.ServletException;

import actions.views.UserView;
import constants.AttributeConst;
import constants.ForwardConst;
import constants.MessageConst;
import services.UserService;

public class UserAction extends ActionBase {

    private UserService service;

    @Override
    public void process() throws ServletException, IOException {
        service = new UserService();
        
        String command = getRequestParam(AttributeConst.CMD);
        if (!(ForwardConst.CMD_NEW.getValue().equals(command) || ForwardConst.CMD_CREATE.getValue().equals(command))) {
            if (getSessionScope(AttributeConst.LOGIN_USER) == null) {
                redirect(ForwardConst.ACT_LOG, ForwardConst.CMD_SHOW);
                service.close();
                return;
            }
        }

        // コマンドを実行
        invoke();

        service.close();
    }

    /**
     * 一覧表示
     */
    public void index() throws ServletException, IOException {
        System.out.println("【DEBUG】index() が呼ばれました");
        System.out.println("【DEBUG】users の数: " + service.getAllUsers().size());

        List<UserView> users = service.getAllUsers();
        putRequestScope(AttributeConst.USER_LIST, users);

        putRequestScope("actUsr", ForwardConst.ACT_USR.getValue());
        putRequestScope("commShow", ForwardConst.CMD_SHOW.getValue());
        putRequestScope("commNew", ForwardConst.CMD_NEW.getValue());
        putRequestScope("commIdx", ForwardConst.CMD_INDEX.getValue());

        forward(ForwardConst.FW_USER_INDEX);
    }

    /**
     * 詳細表示
     */
    public void show() throws ServletException, IOException {
        int id = toNumber(getRequestParam(AttributeConst.USER_ID));
        UserView uv = service.findOne(id);

        if (uv == null) {
            forward(ForwardConst.FW_ERR_UNKNOWN);
            return;
        }

        putRequestScope(AttributeConst.USER, uv);
        forward(ForwardConst.FW_USER_SHOW);
    }

    /**
     * 新規登録画面表示
     */
    public void entryNew() throws ServletException, IOException {
        putRequestScope(AttributeConst.TOKEN, getTokenId());
        forward(ForwardConst.FW_USER_NEW);
    }

    /**
     * ユーザー新規作成
     */
    public void create() throws ServletException, IOException {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        
        UserView uv = new UserView(
                null,
                getRequestParam(AttributeConst.USER_NAME),
                getRequestParam(AttributeConst.USER_EMAIL),
                getRequestParam(AttributeConst.USER_PASSWORD),
                now);

        service.create(uv);

        putSessionScope(AttributeConst.FLUSH, MessageConst.I_REGISTERED.getMessage());

        redirect(ForwardConst.ACT_USR, ForwardConst.CMD_INDEX);
    }

    /**
     * 編集画面表示
     */
    public void edit() throws ServletException, IOException {
        int id = toNumber(getRequestParam(AttributeConst.USER_ID));
        UserView uv = service.findOne(id);

        if (uv == null) {
            forward(ForwardConst.FW_ERR_UNKNOWN);
            return;
        }

        putRequestScope(AttributeConst.TOKEN, getTokenId());
        putRequestScope(AttributeConst.USER, uv);
        forward(ForwardConst.FW_USER_EDIT);
    }

    /**
     * 更新処理
     */
    public void update() throws ServletException, IOException {
        int id = toNumber(getRequestParam(AttributeConst.USER_ID));
        UserView uv = service.findOne(id);

        if (uv == null) {
            forward(ForwardConst.FW_ERR_UNKNOWN);
            return;
        }

        uv.setUsername(getRequestParam(AttributeConst.USER_NAME));
        uv.setEmail(getRequestParam(AttributeConst.USER_EMAIL));
        uv.setPassword_hash(getRequestParam(AttributeConst.USER_PASSWORD));

        service.update(uv);
        redirect(ForwardConst.ACT_USR, ForwardConst.CMD_INDEX);
    }

    /**
     * ユーザー削除
     */
    public void destroy() throws ServletException, IOException {
        int id = toNumber(getRequestParam(AttributeConst.USER_ID));
        service.destroy(id);
        redirect(ForwardConst.ACT_USR, ForwardConst.CMD_INDEX);
    }
}
