# 実行前の環境変数設定（CUDA_LAUNCH_BLOCKING）

`CUDA_LAUNCH_BLOCKING=1` は、GPU 実行時のエラー位置を特定しやすくするためのデバッグ設定です。

## 注意

- デバッグ用です。通常実行では遅くなるため常用しないでください。
- 設定は現在のシェルセッションにのみ有効です。

## Linux（bash）

設定:

```bash
export CUDA_LAUNCH_BLOCKING=1
```

確認:

```bash
echo $CUDA_LAUNCH_BLOCKING
```

解除:

```bash
unset CUDA_LAUNCH_BLOCKING
```

## Windows（PowerShell）

設定:

```powershell
$env:CUDA_LAUNCH_BLOCKING=1
```

確認:

```powershell
echo $env:CUDA_LAUNCH_BLOCKING
```

解除:

```powershell
Remove-Item Env:CUDA_LAUNCH_BLOCKING
```
