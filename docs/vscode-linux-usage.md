# VS Code で Linux を使う

参考: https://qiita.com/_masa_u/items/d3c1fa7898b0783bc3ed

## 必要な拡張機能

- Remote Development
- Remote - WSL

拡張機能の参考リンク:

- https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
- https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl

## 使い方

1. Linux で開きたいディレクトリに移動します。
2. VS Code は Windows 側から起動します。
3. ファイルは Linux 側の保存先に置きます。例: `\\wsl.localhost\Ubuntu\home\sito\test`
4. たとえば `test` ディレクトリがホームディレクトリ直下にある場合は、先にそのディレクトリへ移動します。

```bash
cd test
```

5. その場所で VS Code を開きます。

```bash
code .
```
