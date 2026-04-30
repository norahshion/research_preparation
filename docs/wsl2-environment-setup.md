# WSL2 環境設定

参考: https://qiita.com/zakoken/items/61141df6aeae9e3f8e36

## 手順

1. PowerShell で次を実行します。

```powershell
wsl --install
```

2. 実行後に再起動します。
3. 再起動後、検索バーで Ubuntu を検索してコマンドラインを開きます。
4. ユーザー名とパスワードを設定します。
5. コマンドラインで次を実行します。

```powershell
wsl -l -v
```

6. `VERSION` が 2 になっていることを確認します。
7. もし 1 の場合は、次を実行します。

```powershell
wsl --set-version Ubuntu 2
```

8. うまくインストールできない場合は、Ubuntu を指定してインストールします。

```powershell
wsl --install -d Ubuntu
```
