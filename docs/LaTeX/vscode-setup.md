# VS Code での LaTeX 環境構築（初心者向け）

目的: `template.tex` を VS Code 上で編集し、PDF を得られる最短手順を示します。

## 1. TeX 配布のインストール

- Windows: MiKTeX もしくは TeX Live を推奨。研究用途では TeX Live（フル）を推奨します。
- Linux (WSL): `texlive-full`（容量大）または `texlive-latex-recommended` 等必要なパッケージを選択。

例（Ubuntu/WSL）:

```bash
sudo apt update
sudo apt install texlive-latex-extra texlive-fonts-recommended texlive-luatex -y
```

## 2. VS Code と拡張の導入

- VS Code をインストール
- 拡張: `LaTeX Workshop`（作者: James Yu）をインストール

## 3. 初回ビルドの確認

1. `template.tex` を VS Code で開く
2. コマンドパレット `Ctrl+Shift+P` で `LaTeX Workshop: Build LaTeX project` を実行
3. ビルドが成功すれば右側に PDF プレビューが表示されます

## 4. 推奨設定（ワークスペース）

`.vscode/settings.json` に次を入れると便利です:

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": ["-pdf", "-interaction=nonstopmode", "-synctex=1", "%DOC%"]
    }
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "latexmk",
      "tools": ["latexmk"]
    }
  ],
  "latex-workshop.view.pdf.viewer": "tab"
}
```

> 注: `latexmk` を使う場合はシステムに `latexmk` が入っていることを確認してください（TeX Live に同梱されます）。

## 5. トラブル対処のヒント

- パッケージ不足でビルドが失敗する: エラーメッセージにあるパッケージ名を `apt` や TeX Live のインストーラで追加
- フォント問題: `lmodern` を入れておくと多くの問題が解決
- 画像が表示されない: 画像ファイルは `.tex` と同じフォルダに置く

## 6. よくあるコマンド（参考）

- ローカルで手動ビルド:

```bash
latexmk -pdf template.tex
```

- 一時ファイルの削除:

```bash
latexmk -c
```


---

必要なら `.vscode/tasks.json` のテンプレートや、BibTeX/BibLaTeX の導入例も追加します。