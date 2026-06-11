# 研究環境構築 & 技術引継ぎドキュメント集 (research_preparation)

本プロジェクトは、研究室に新しく配属された下級生への**技術引継ぎ**と、学内外への**技術情報発信（技適ブログなど）の下書き**を目的としたドキュメント集です。

研究活動を円滑に進めるための「Linux/Python環境の構築」から「VS Codeでの快適なLaTeX論文執筆環境」、さらには学内LANのネットワーク制限を回避して作業効率を上げる「仮想VPNを用いた画面拡張手順」まで、実践的なノウハウを体系的にまとめています。

---

## 🗺️ 全体マップ（インデックス）

| カテゴリ | 目的 | 主要ドキュメント |
| :--- | :--- | :--- |
| **Linux & Python開発環境** | WSL2やリモートサーバー上でのPython開発環境構築 | 📂 [Linux 初期設定とPython環境構築](./docs/linux/README.md)<br>└ 🐧 [WSL2 環境構築手順](./docs/linux/wsl2-environment-setup.md)<br>└ 🔗 [VS Code Remote-SSH 接続手順](./docs/linux/remote-ssh-setup.md)<br>└ 🐍 [Miniconda による環境整備](./docs/linux/miniconda-setup.md) |
| **LaTeX 論文執筆環境** | VS CodeとTeX Liveを用いた高速・全自動ビルド環境の構築 | 📂 [LaTeX 環境構築ポータル](./docs/LaTeX/README.md)<br>└ 📝 [VS Code + LaTeX 構築・SyncTeX設定](./docs/LaTeX/vscode-setup.md)<br>└ 📄 [最小構成テンプレート](./docs/LaTeX/template/template.tex) |
| **画面拡張（ブログ下書き）** | 学内LAN等の制限環境におけるサブディスプレイ化ノウハウ | 📂 [spacedesk + Tailscale 画面拡張手順](./docs/remote_window/README.md) |

---

## 🚀 目的別ロードマップ

あなたの目的に応じて、以下のロードマップに沿ってドキュメントを読み進めてください。

### 1. 新しく配属された下級生の方（開発環境構築）
研究室のPCまたは自身のPCで研究を開始するための標準的なセットアップ手順です。

1. **Linux環境の確保**
   - 自身のPC（Windows）内に構築する場合：[WSL2 環境設定](./docs/linux/wsl2-environment-setup.md) を参照。
   - 研究室の共有サーバー等に接続する場合：[VS Code で Remote-SSH 接続](./docs/linux/remote-ssh-setup.md) を参照。
2. **エディタ連携**
   - WSL2でVS Codeを使用する方法：[VS Code で Linux を使う](./docs/linux/vscode-linux-usage.md) を参照。
3. **Python環境の構築**
   - パッケージ管理ツールのセットアップ：[Miniconda の整備](./docs/linux/miniconda-setup.md) を参照。
   - ※さらに高速な仮想環境管理を試したい場合のみ [+alpha uv のインストール](./docs/linux/uv-install-optional.md) も検討してください。

### 2. 論文や進捗報告書を書き始める方（LaTeX環境構築）
論文執筆のデファクトスタンダードである LaTeX の執筆・自動PDF生成環境をローカルに構築します。

1. **環境構築とVS Code連携**
   - [VS Code での LaTeX 環境構築](./docs/LaTeX/vscode-setup.md) を見ながら、TeX Live のインストールと VS Code 拡張機能の連携を行います。
   - **ポイント**：環境変数に依存しない「絶対パス指定」によるトラブル回避手法を導入しています。
2. **テンプレートの活用**
   - [template.tex](./docs/LaTeX/template/template.tex) をベースにして執筆を開始してください。

### 3. 技術ブログ執筆・画面拡張ノウハウを知りたい方（ブログ下書き）
「学内ネットワーク制限下で、ノートPCを研究室PCのサブディスプレイとして使いたい」という課題を、Tailscale（仮想VPN）とファイアウォール制御でスマートに解決する手順です。

- [spacedesk + Tailscaleを用いた画面拡張手順](./docs/remote_window/README.md) を参照。
- **技適ブログ下書きとしての価値**：学内有線LANとWi-Fiのセグメント分離という実務上の課題を、仮想L2/L3トンネリングで解決するまでの技術プロセスとセキュリティ設定がまとめられています。

---

## 🛠️ ドキュメントの保守・拡充について

- 新しいトラブルシューティングやツール（DockerやGit等）の設定手順を記述する場合は、`docs/` 配下に新規ディレクトリを作成し、カテゴリごとに README.md を作成して本ポータルからリンクしてください。
- 記述の際は、下級生が迷わないよう「PowerShell（Windows側）」と「Bash（Linux側）」の実行環境の区別を明記してください。
