# +α uv のインストール

参考: https://qiita.com/futakuchi0117/items/9ec8bd84797fed180647

pip より使い勝手がよいので、必要なら入れておくと便利です。

## インストール

1. uv をインストールします。

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

2. 設定を反映します。

```bash
source $HOME/.local/bin/env
```

3. 次が通れば成功です。

```bash
uv --version
```
