# +alpha uv のインストール（任意）

`uv` は Python 依存管理と仮想環境作成を高速に行えるツールです。
Miniconda 運用がすでに安定している場合は必須ではありません。

## このページを使う人

- `uv` の高速な依存解決を使いたい
- 既存プロジェクトで `pyproject.toml` / `uv.lock` を使っている

## インストール

1. `uv` をインストールします。

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

2. シェル設定を反映します。

```bash
source $HOME/.local/bin/env
```

3. バージョン確認します。

```bash
uv --version
```

## うまくいかないとき

- `uv: command not found` が出る場合は、シェルを開き直して再度 `uv --version`
- それでも失敗する場合は `~/.local/bin` が PATH に含まれているか確認

> 参考: [uv （pythonパッケージマネージャー）の使い方　簡易版](https://qiita.com/futakuchi0117/items/9ec8bd84797fed180647)
