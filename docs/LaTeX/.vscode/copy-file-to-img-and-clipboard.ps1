param(
    [string]$currentFile
)

function Write-Info($s){ Write-Output "INFO: $s" }
function Write-Err($s){ Write-Error "ERROR: $s" }

if ($currentFile -and (Test-Path $currentFile)) {
    $currentDir = Split-Path $currentFile -Parent
} else {
    $currentDir = (Get-Location).Path
}

Write-Info "Using current file dir: $currentDir"

$destDir = Join-Path $currentDir 'img'
if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir | Out-Null }

# Get file paths from clipboard
$paths = Get-Clipboard -Format FileDropList -ErrorAction SilentlyContinue
if (-not $paths -or $paths.Count -eq 0) {
    Write-Err "No file path in clipboard. Copy an image file in Explorer (Ctrl+C) first."
    exit 1
}

$file = $paths[0]
if (-not (Test-Path $file)) { Write-Err "Copied path does not exist: $file"; exit 2 }

$ext = [System.IO.Path]::GetExtension($file)
$ts = (Get-Date).ToString('yyyy-MM-dd-HH-mm-ss')
$destFileName = "${ts}${ext}"
$destPath = Join-Path $destDir $destFileName

try {
    Copy-Item -Path $file -Destination $destPath -Force
    Write-Info "Copied file to $destPath"
} catch {
    Write-Err "Failed to copy file: $_"
    exit 3
}

# compute relative path from currentDir
$absCurrent = [System.IO.Path]::GetFullPath($currentDir)
$absDest = [System.IO.Path]::GetFullPath($destPath)
if ($absDest.StartsWith($absCurrent)) {
    $rel = $absDest.Substring($absCurrent.Length).TrimStart('\','/')
} else {
    # fallback to path relative to workspace
    $rel = $absDest
}

# use unix-style separators for markdown
$rel = $rel -replace '\\','/'

$md = "![]($rel)"
Set-Clipboard -Value $md
Write-Info "Markdown link placed to clipboard: $md"
exit 0
