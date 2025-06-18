# 📌 アプリ名（仮）

**Event Scheduler（イベントスケジューラー）**

---

# 📝 アプリ概要

社内や友人間での**イベント開催における候補日の調整**を効率的に行うためのWebアプリケーションです。主催者はイベントの候補日を提示し、参加者はその出欠状況を登録することができます。日程調整ツールとして**簡単に運用可能なイベント管理アプリ**です。

---

# 🎥 スクリーンショット
![Image](https://github.com/user-attachments/assets/3204bc70-a91d-4ea1-b893-9ce8b472ae71)

# 🎯 主な機能

## 1. ユーザー管理

* ユーザー登録・ログイン機能
* ユーザー情報には氏名、メールアドレス、パスワードを保持

## 2. イベント作成

* タイトル・説明文を入力してイベントを作成
* イベントの主催者（organizer）はユーザーIDと紐づけられる
* 候補日（1日以上）を設定可能。日付・開始時刻・終了時刻を指定

## 3. 出欠管理

* 各ユーザーは各候補日に対して「参加」「未定」「不参加」を選択
* 全員の出欠状況を一覧で確認可能

## 4. 集計・表示

* 出欠状況を候補日ごとに集計して表示
* UIはシンプルだが、情報の見やすさを重視

---

# 🔧 技術スタック

## バックエンド

* Java 21
* Jakarta Persistence（JPA）+ Hibernate
* Mavenビルド管理
* サーブレット + JSP（MVC構成）

## データベース

* MySQL（RDBMS）
* JPAによるエンティティ定義（User, Event, Candidate, Attendance）

## フロントエンド

* HTML
* JavaScript
* Tailwind CSS（埋め込みで軽量に使用）

---
## 📊 テーブル一覧と関係

![Image](https://github.com/user-attachments/assets/84bb07c1-053d-4c70-a907-8d439ee46bbf)

| テーブル名           | 説明                             | 主な項目                                                | 関連先テーブル（関係）                      |
|---------------------|----------------------------------|---------------------------------------------------------|---------------------------------------------|
| `users`             | ユーザー情報                     | `id`, `username`, `email`, `password_hash`, `created_at` | `events.organizer_id`（1:N）、`attendances.user_id`（1:N） |
| `events`            | イベント情報                     | `id`, `title`, `description`, `organizer_id`, `created_at` | `users.id`（N:1）、`event_candidates.event_id`（1:N）、`attendances`（1:N） |
| `event_candidates`  | イベントの候補日                 | `id`, `event_id`, `date`, `start_time`, `end_time`       | `events.id`（N:1）、`attendances.candidate_id`（1:N） |
| `attendances`       | 出欠登録情報                     | `id`, `user_id`, `candidate_id`, `status`               | `users.id`（N:1）、`event_candidates.id`（N:1） |


# 👥 利用シナリオ（例）

1. **主催者：田中さん**が「新年会」のイベントを作成し、1月10〜12日の候補日時を入力
2. イベントページのURLを共有
3. **参加者：鈴木さん、佐藤さん**がそれぞれ自分の出欠状況に回答
4. 田中さんが全体の参加状況と回答を確認し、最適な日程と会場を決定

---

# ✅ 主要機能一覧

* イベント作成、候補日登録
* 出欠登録、出欠一覧表示
* ユーザーによるログイン処理
* MySQLとの連携による永続化