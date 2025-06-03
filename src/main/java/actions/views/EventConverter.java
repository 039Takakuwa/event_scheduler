package actions.views;

import java.util.ArrayList;
import java.util.List;

import models.Event;

/**
 * イベントデータのDTO⇔モデルの変換を行うクラス
 */
public class EventConverter {

    /**
     * EventViewのインスタンスからEventのインスタンスを作成する
     * @param ev EventViewのインスタンス
     * @return Eventのインスタンス
     */
    public static Event toModel(EventView ev) {
        return new Event(
                ev.getId(),
                ev.getTitle(),
                ev.getDescription(),
                UserConverter.toModel(ev.getOrganizer()),
                ev.getCreatedAt()
        );
    }

    /**
     * EventのインスタンスからEventViewのインスタンスを作成する
     * @param e Eventのインスタンス
     * @return EventViewのインスタンス
     */
    public static EventView toView(Event e) {
        if (e == null) {
            return null;
        }

        return new EventView(
                e.getId(),
                e.getTitle(),
                e.getDescription(),
                UserConverter.toView(e.getOrganizer()),
                e.getCreatedAt()
        );
    }

    /**
     * EventのリストからEventViewのリストを作成する
     * @param eventList モデルのリスト
     * @return ビューのリスト
     */
    public static List<EventView> toViewList(List<Event> eventList) {
        List<EventView> evList = new ArrayList<>();

        for (Event e : eventList) {
            evList.add(toView(e));
        }

        return evList;
    }

    /**
     * EventViewの各フィールドの内容をEventにコピーする
     * @param e モデル（上書き対象）
     * @param ev ビュー（上書き元）
     */
    public static void copyViewToModel(Event e, EventView ev) {
        e.setId(ev.getId());
        e.setTitle(ev.getTitle());
        e.setDescription(ev.getDescription());
        e.setOrganizer(UserConverter.toModel(ev.getOrganizer()));
        e.setCreatedAt(ev.getCreatedAt());
    }
}
