# Linux 初期設定

このディレクトリは、研究で使う Linux 実行環境を初期設定するための手順書です。

- Windows の中に Linux を作って使う人: WSL2 ルート
- 研究室サーバーなどの既存 Linux に接続して使う人: Remote-SSH ルート

どちらのルートでも、最後に Python 実行環境（Miniconda / uv）を整備します。

## 先に決めること

1. 自分の作業先
- A. 手元 PC（Windows）内に Linux を作る -> WSL2
- B. 既存のリモート Linux サーバーに接続する -> Remote-SSH

2. Python 環境管理
- まずは Miniconda を推奨
- conda を使わない場合のみ `uv-without-conda.md` を参照

## 読む順番

### 導線 A（ローカル実行 / WSL2）

1. [WSL2 環境設定](./wsl2-environment-setup.md)
2. [VS Code で Linux を使う](./vscode-linux-usage.md)
3. [Miniconda の整備](./miniconda-setup.md)
4. 必要なら [+alpha uv のインストール](./uv-install-optional.md)
5. 必要なら [実行前の環境変数設定（CUDA 等）](./cuda-launch-blocking.md)

### 導線 B（リモート実行 / SSH）

1. [VS Code で Remote-SSH 接続](./remote-ssh-setup.md)
2. [Miniconda の整備](./miniconda-setup.md)
3. 必要なら [+alpha uv のインストール](./uv-install-optional.md)
4. 必要なら [実行前の環境変数設定（CUDA 等）](./cuda-launch-blocking.md)

## 作業時の注意

- 指示が `PowerShell` のときは Windows 側で実行します。
- 指示が `bash` のときは Linux 側（WSL またはリモート）で実行します。
- `yes`, `y`, `Enter`, `accept` の入力を求められる場面があります。

## 完了チェック

- Linux シェルが開ける（WSL または Remote-SSH）
- VS Code 左下に接続先（WSL または SSH）が表示される
- `python --version` と `pip --version` が実行できる
- 必要なプロジェクト依存がインストール済み
