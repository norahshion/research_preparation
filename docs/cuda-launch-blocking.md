# 実行前の環境変数設定

プログラムを実行する前に、エラー発生時点で停止させたい場合に設定します。

## Linux

```bash
export CUDA_LAUNCH_BLOCKING=1
```

## Windows

PowerShell では次の形式を使います。

```powershell
$env:CUDA_LAUNCH_BLOCKING=1
```
