# VS Code で Linux を使う（WSL）

この手順は、WSL 上のフォルダを VS Code で開いて編集する方法です。

## ゴール

- VS Code が WSL に接続している
- Linux 側のフォルダを開いて編集できる

## 必要な拡張機能

- [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
- [Remote - WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)

## おすすめ手順（最短）

1. Windows で VS Code を起動します。
2. コマンドパレット（`Ctrl+Shift+P`）を開きます。
3. `WSL: Connect to WSL` を実行します。
4. 左下が `WSL: Ubuntu` などになったことを確認します。
5. `File -> Open Folder...` で Linux 側フォルダを開きます。

## ターミナルから開く方法

1. WSL ターミナルを開き、作業ディレクトリに移動します。

```bash
cd ~/your-project
```

2. その場所で VS Code を開きます。

```bash
code .
```

`code` が見つからない場合は、いったん VS Code から WSL 接続したあとに再試行してください。

## 保存場所の注意

- Linux 開発用ファイルは Linux 側（例: `/home/<user>/...`）に置くのを推奨
- Windows 側のネットワークパス経由で編集すると遅くなる場合があります

## 完了チェック

- 左下に `WSL` の表示がある
- 統合ターミナルで次が実行できる

```bash
uname -a
pwd
```

>　参考：[【WSL / WSL2】VSCode×WSLでWindows上にLinux開発環境を構築](https://qiita.com/_masa_u/items/d3c1fa7898b0783bc3ed)
