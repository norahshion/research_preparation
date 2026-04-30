# conda 未使用版

## uv コマンドの導入

1. uv コマンドをインストールします。

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

2. もし上の方法でうまくいかなかった場合は、bash に入ってから設定を読み込みます。

```bash
bash
source ~/.bashrc
```

3. `uv --version` を実行して、エラーが出なければ成功です。

## `pyproject.toml` と `uv.lock` がある場合

1. 該当ファイルがあるディレクトリに移動します。

```bash
cd ~/flatnet-spt
```

2. 設定を反映します。

```bash
uv sync
```

## ファイルがない場合

1. プロジェクトを初期化します。

```bash
uv init
```

2. Python のバージョンを固定します。

```bash
uv python pin 3.12
```

3. ライブラリを 1 行ずつ追加します。

```bash
uv add numpy scipy scikit-image
```

4. `torch` は CUDA 12.4 向けを明示します。

```bash
uv add torch torchvision --index https://download.pytorch.org/whl/cu124 --index-strategy unsafe-best-match
```

## 補足

- ライブラリは基本的にそのプロジェクトの `.venv` に依存します。
- 別プロジェクトでも同じ構成を使いたい場合は、`pyproject.toml` と `uv.lock` がある場合の手順を使うと楽です。
- `pyproject.toml` の `name = "flatnet-spt"` は、新しいプロジェクト名に書き換えて構いません。
- `uv.lock` は自動で名前変更されるので、手で変更しないでください。
- 既に `uv init` 済みのフォルダで `uv add` するほうが確実です。
