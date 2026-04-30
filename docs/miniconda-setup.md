# Miniconda の整備

これはファイル実行用の実行環境を用意するための手順です。

## 手順

1. インストーラーをダウンロードします。

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

2. スクリプトを実行します。途中は基本的に Enter や yes で進めます。
3. Conda を初期化します。

```bash
~/miniconda3/bin/conda init bash
```

4. 設定を反映します。

```bash
source ~/.bashrc
```

5. 新しい環境を作成します。`python=3.12` の部分は必要に応じて変えます。

```bash
conda create -n flatnet_env python=3.12
```

6. 作成した環境に入ります。

```bash
conda activate flatnet_env
```

7. 必要なライブラリを導入します。`recordclass.txt` がある場合は、先に C コンパイラを入れます。

```bash
conda install -c conda-forge gcc_linux-64 gxx_linux-64 -y
pip install -r requirements.txt
```

8. `recordclass.txt` がない場合は、必要なものを個別に入れます。

```bash
pip install torch torchvision torchaudio
pip install numpy scipy matplotlib opencv-python tqdm
```

## 補足

- Python バージョンを上げすぎると、`torch` との互換性がない場合があります。
- `flatnet_env` は環境名なので、分かりやすい名前に置き換えて構いません。
