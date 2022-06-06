# README

## herokuの初期設定

### 本番用のDockerfile

・イメージにソースコードの含める

・bundle installを行う

・herokuのユーザはdynoグループで自動作成される

### ログイン

```
$ heroku login
```

### ベータ版にアップデート

```
$ heroku update beta
```

### manifestをインストール

```
$ heroku plugins:install @heroku-cli/plugin-manifest
$ heroku plugins
```

### herokuアプリの作成

```
$ heroku create <任意のアプリ名> --manifest
$ heroku open
```

### herokuのリモートリポジトリが追加されていることを確認

```
$ git remote -v
```

### スタックの確認

```
$ heroku stack
$ heroku stack:set container
```

### herokuにソースをpush

```
$ git push heroku main
```

### herokuの環境変数を設定する

```
$ pbcopy < config/master.key
$ heroku config:set RAILS_MASTER_KEY=<マスターキー>
$ heroku config
```

### gemのインストールのパスを確認する

```
# vendor/bundle配下になっていること
$ heroku run bundle config
```

### マイグレーションの実行

```
$ heroku run bundle exec rails db:migrate
$ heroku open /api/v1/hello
```

## herokuの確認

### プロセス確認

```
$ heroku ps
```

### herokuのコンテナにログイン

```
$ heroku run bash

# タイムゾーン確認
$ date
```

## postgresの確認

### ローカルにpostgresをインストール

```
$ brew install postgresql
```

### herokuのpostgresのプラン情報を確認

```
$ heroku pg:info
```

### herokuのpostgresの接続情報

```
$ heroku pg:credentials:url
```

### postgresにアクセス

```
$ heroku pg:psql <アドオン名>

# タイムゾーン確認
=> show timezone;

# タイムゾーン変更
=> ALTER DATABASE your_database_name SET timezone = 'Asia/Tokyo';

# 一度抜けてからタイムゾーン確認
=> show timezone;
```







