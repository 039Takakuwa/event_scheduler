package actions.views;

import java.util.ArrayList;
import java.util.List;

import models.User;

public class UserConverter {

    /**
     * ViewモデルのインスタンスからDTOモデルのインスタンスを作成する
     * @param ev UserViewのインスタンス
     * @return Userのインスタンス
     */
    public static User toModel(UserView uv) {

        return new User(
                uv.getId(),
                uv.getUsername(),
                uv.getEmail(),
                uv.getPassword_hash(),
                uv.getCreatedAt());
    }

    /**
     * DTOモデルのインスタンスからViewモデルのインスタンスを作成する
     * @param e Userのインスタンス
     * @return UserViewのインスタンス
     */
    public static UserView toView(User u) {

        if(u == null) {
            return null;
        }

        return new UserView(
                u.getId(),
                u.getUsername(),
                u.getEmail(),
                u.getPassword_hash(),
                u.getCreated_at());
    }

    /**
     * DTOモデルのリストからViewモデルのリストを作成する
     * @param list DTOモデルのリスト
     * @return Viewモデルのリスト
     */
    public static List<UserView> toViewList(List<User> list) {
        List<UserView> uvs = new ArrayList<>();

        for (User e : list) {
            uvs.add(toView(e));
        }

        return uvs;
    }

    /**
     * Viewモデルの全フィールドの内容をDTOモデルのフィールドにコピーする
     * @param e DTOモデル(コピー先)
     * @param uv Viewモデル(コピー元)
     */
    public static void copyViewToModel(User u, UserView uv) {
        u.setId(uv.getId());
        u.setUsername(uv.getUsername());
        u.setEmail(uv.getEmail());
        u.setPassword_hash(uv.getPassword_hash());
        u.setCreated_at(uv.getCreatedAt());

    }
}
