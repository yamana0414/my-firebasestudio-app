---
name: New user registration failing
about: Steps and information to diagnose and fix the user registration flow
title: "[bug] 新規登録ができない: <short failure summary>"
labels: bug, registration
assignees: ''
---

## 概要
新規登録（メール/パスワード）でユーザー作成に失敗する問題を追跡します。

## 再現手順
1. アプリを起動する
2. ホーム > 「新規登録はこちら」または設定画面から登録画面へ移動
3. メールとパスワードを入力して「登録する」を押す
4. 期待: FirebaseAuth によりユーザーが作成され、ホームに戻る
5. 実際: 失敗エラーが表示される（例: operation-not-allowed, email-already-in-use）

## 環境
- Flutter: (出力 `flutter --version` をここに記載)
- Dart: (出力 `dart --version`)
- Firebase packages:
  - firebase_core: x.x.x
  - firebase_auth: x.x.x

## ログ/エラーメッセージ
（ここに FirebaseAuthException の `e.code` や Flutter のログを貼る）

## 期待される動作
- 正しい入力であればユーザーが作成され、UI はログイン済み状態に遷移する

## 追加情報/チェックリスト
- [ ] Firebase プロジェクトで Email/Password 認証が有効
- [ ] `google-services.json` が `android/app/` に配置されている
- [ ] Android の SHA-1/SHA-256 が Firebase に登録されている
- [ ] (Web) OAuth 同意画面と認可済みドメインが設定されている

## 再現コード（省略可）
`lib/screens/register_screen.dart` を参照

## スクリーンショット/ビデオ
（必要なら添付）
