#coding: utf-8
#language: ja

機能: ユーザ情報の編集
  ユーザとして
  自らのユーザ情報を編集したい
  自分のプロフィールを充実させるため

  シナリオ: ログイン後、自分のユーザ情報を編集する
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
    もし メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ "自分のプロフィール編集ページ"へアクセス
    かつ "名前"に"太郎"と入力する
    かつ "更新"ボタンをクリックする
    ならば "更新されました"と表示されていること

  シナリオ: ログイン後、他人のユーザ情報を編集しようとする
    前提 以下のユーザが存在している:
      |email | display_name|
      |email1@example.com | user1|
      |email2@example.com | user2|
    もし メールアドレスが"email1@example.com"のユーザとしてログインしている
    かつ "user2のプロフィール編集ページ"へアクセス
    ならば "許可されていないアクションです"と表示されていること