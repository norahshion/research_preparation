# conda 未使用版（uv で環境構築）

この手順は、conda を使わず `uv` とプロジェクト内 `.venv` で管理したい場合の手順です。

## ゴール

- `uv` が使える
- プロジェクトごとに依存関係を再現できる

## 0. uv を使えるようにする

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
uv --version
```

`uv --version` が通らない場合はシェルを開き直して再試行します。

## 1. 既存プロジェクト（`pyproject.toml` と `uv.lock` がある）

1. プロジェクトフォルダへ移動

```bash
cd ~/your-project
```

2. 依存関係を同期

```bash
uv sync
```

これで `.venv` が作成され、ロックファイルどおりに環境が再現されます。

## 2. 新規プロジェクト（設定ファイルがない）

1. プロジェクト初期化

```bash
uv init
```

2. Python バージョン固定（例: 3.12）

```bash
uv python pin 3.12
```

3. 必要ライブラリ追加

```bash
uv add numpy scipy scikit-image
```

4. PyTorch（CUDA 12.4 例）

```bash
uv add torch torchvision --index https://download.pytorch.org/whl/cu124 --index-strategy unsafe-best-match
```

## 完了チェック

```bash
uv run python --version
uv run python -c "import numpy; print(numpy.__version__)"
```

## 補足

- 依存はプロジェクト内 `.venv` に入ります。
- 同じ構成を別環境で再現するには `pyproject.toml` と `uv.lock` をコミットします。
