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
```

