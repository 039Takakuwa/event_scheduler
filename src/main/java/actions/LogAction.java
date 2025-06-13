package actions;

import java.io.IOException;

import jakarta.servlet.ServletException;

import actions.views.UserConverter;
import actions.views.UserView;
import constants.AttributeConst;
import constants.ForwardConst;
import models.User;
import services.UserService;

public class LogAction extends ActionBase {

    private UserService service;

    @Override
    public void process() throws ServletException, IOException {
        service = new UserService();

        // 直接リクエストパラメータからcommandを取得
        String command = request.getParameter(ForwardConst.CMD.getValue());

        switch (command) {
        case "show":
            showLoginForm();
            break;
        case "login":
            login();
            break;
        case "logout":
            logout();
            break;
        default:
            forward(ForwardConst.FW_ERR_UNKNOWN);
        }
    }

    private void showLoginForm() throws ServletException, IOException {
        forward(ForwardConst.FW_LOGIN);
    }

    private void login() throws ServletException, IOException {
        String username = getRequestParam(AttributeConst.USER_NAME);
        String password = getRequestParam(AttributeConst.USER_PASSWORD);

        System.out.println("ログイン試行: username=" + username + ", password=" + password);

        User u = service.findByUsernameAndPassword(username, password);

        if (u != null) {
            System.out.println("ログイン成功: " + u.getUsername());
            
            UserView uv = UserConverter.toView(u);
            putSessionScope(AttributeConst.LOGIN_USER, uv);
            redirect(ForwardConst.ACT_USR, ForwardConst.CMD_INDEX);
        } else {
            System.out.println("ログイン失敗");
            putRequestScope(AttributeConst.FLUSH, "ユーザー名またはパスワードが違います。");
            forward(ForwardConst.FW_LOGIN);
        }
    }


    private void logout() throws ServletException, IOException {
        removeSessionScope(AttributeConst.LOGIN_USER);
        redirect(ForwardConst.ACT_LOG, ForwardConst.CMD_SHOW);
    }
}
