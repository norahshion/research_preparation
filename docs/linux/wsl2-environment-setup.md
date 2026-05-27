# WSL2 環境設定

この手順は、Windows 上に Linux（Ubuntu）を導入して使うためのものです。

## ゴール

- WSL2 の Ubuntu が起動できる
- Linux ユーザー作成が完了している
- `wsl -l -v` の `VERSION` が `2`

## 前提

- Windows 11 か、WSL2 対応済みの Windows 10
- 管理者権限の PowerShell が使える

## 手順

1. 管理者権限の PowerShell を開きます。

2. WSL をインストールします。

```powershell
wsl --install
```

3. 再起動を求められたら、Windows を再起動します。

4. 再起動後、スタートメニューから `Ubuntu` を起動します。

5. 初回起動時に Linux ユーザー名とパスワードを設定します。

6. PowerShell に戻って、状態を確認します。

```powershell
wsl --status
wsl -l -v
```

7. `Ubuntu` の `VERSION` が `2` でない場合は次を実行します。

```powershell
wsl --set-version Ubuntu 2
```

## うまくいかないとき

### `wsl --install` が失敗する

Ubuntu を明示して再実行します。

```powershell
wsl --install -d Ubuntu
```

### `VERSION` が 1 のまま

次を実行してから、再度 `wsl -l -v` を確認します。

```powershell
wsl --set-default-version 2
wsl --set-version Ubuntu 2
```

### Ubuntu が起動しない

- Windows を再起動して再試行
- それでもだめなら `wsl --status` の出力を保存して、管理者に相談

## 完了チェック

```powershell
wsl -l -v
```

- `Ubuntu` が `Running` または `Stopped` と表示される
- `VERSION` が `2`

> 参考：[WSL2 のインストールとアンインストール](https://qiita.com/zakoken/items/61141df6aeae9e3f8e36)
