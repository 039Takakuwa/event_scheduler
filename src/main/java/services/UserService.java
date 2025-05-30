package services;

import java.util.List;

import actions.views.UserConverter;
import actions.views.UserView;
import models.User;

public class UserService extends ServiceBase {

    /**
     * 全ユーザーのリストを取得してUserViewのリストとして返す
     */
    public List<UserView> getAllUsers() {
        List<User> users = em.createNamedQuery("getAllUsers", User.class)
                             .getResultList();
        return UserConverter.toViewList(users);
    }

    /**
     * 指定されたIDに対応するユーザーを取得
     */
    public UserView findOne(int id) {
        return UserConverter.toView(em.find(User.class, id));
    }

    /**
     * ユーザー情報を新規登録
     */
    public void create(UserView uv) {
        em.getTransaction().begin();
        em.persist(UserConverter.toModel(uv));
        em.getTransaction().commit();
    }

    /**
     * ユーザー情報を更新
     */
    public void update(UserView uv) {
        em.getTransaction().begin();
        User u = em.find(User.class, uv.getId());
        UserConverter.copyViewToModel(u, uv);
        em.getTransaction().commit();
    }

    /**
     * 指定IDのユーザーを削除
     */
    public void destroy(int id) {
        em.getTransaction().begin();
        User u = em.find(User.class, id);
        if (u != null) {
            em.remove(u);
        }
        em.getTransaction().commit();
    }
}

