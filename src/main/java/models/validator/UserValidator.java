package models.validator;

import java.util.ArrayList;
import java.util.List;

import actions.views.UserView;

public class UserValidator {
    public static List<String> validate(UserView uv, Boolean passwordCheckFlag) {
        List<String> errors = new ArrayList<>();

        // 名前チェック
        String nameError = validateName(uv.getUsername());
        if (!nameError.equals("")) {
            errors.add(nameError);
        }

        // パスワードチェック（条件付き）
        if (passwordCheckFlag) {
            String passwordError = validatePassword(uv.getPassword_hash());
            if (!passwordError.equals("")) {
                errors.add(passwordError);
            }
        }

        return errors;
    }

    // 名前のバリデーション
    private static String validateName(String name) {
        if (name == null || name.equals("")) {
            return "名前を入力してください。";
        }
        return "";
    }

    // パスワードのバリデーション
    private static String validatePassword(String password) {
        if (password == null || password.length() < 8) {
            return "パスワードは8文字以上で入力してください。";
        }
        return "";
    }

}
