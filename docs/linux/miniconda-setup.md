# Miniconda の整備

この手順は、Linux（WSL/Remote-SSH）で Python 実行環境を安全に分離するためのものです。

## ゴール

- `conda` コマンドが使える
- プロジェクト専用の環境を作成できる
- 必要な Python パッケージを導入できる

## 手順

1. インストーラーをダウンロードします。

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

2. インストーラーを実行します。

```bash
bash Miniconda3-latest-Linux-x86_64.sh
```

途中は基本的に `Enter` と `yes` で進めて問題ありません。

3. conda を初期化します。

```bash
~/miniconda3/bin/conda init bash
source ~/.bashrc
```

4. 新しい環境を作成します（例: Python 3.12）。

```bash
conda create -n flatnet_env python=3.12 -y
```

5. 作成した環境を有効化します。

```bash
conda activate flatnet_env
```

6. 依存関係をインストールします。

`requirements.txt` がある場合:

```bash
pip install -r requirements.txt
```

`requirements.txt` がない場合（例）:

```bash
pip install torch torchvision torchaudio
pip install numpy scipy matplotlib opencv-python tqdm
```

## よくある追加対応

一部パッケージで C/C++ コンパイラが必要な場合は、次を先に入れます。

```bash
conda install -c conda-forge gcc_linux-64 gxx_linux-64 -y
```

## 完了チェック

```bash
conda --version
python --version
pip --version
```

## 補足

- `flatnet_env` は環境名なので、任意の名前に変更できます。
- Python バージョンを上げすぎると `torch` と互換性がない場合があります。
- 環境の再利用用に履歴を書き出す場合は次を使います。

```bash
conda env export --from-history > environment.yml
```
