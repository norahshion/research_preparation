Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms

function Write-Info($s){ Write-Output "INFO: $s" }
function Write-Err($s){ Write-Error "ERROR: $s" }

Write-Info "Checking clipboard for existing image..."
try {
    $existing = [System.Windows.Forms.Clipboard]::GetImage()
} catch {
    $existing = $null
}
if ($existing -ne $null) {
    Write-Info "Clipboard already contains an image. Nothing to do."
    exit 0
}

Write-Info "No image in clipboard, checking for file paths..."

# Use IDataObject to inspect formats and try multiple retrievals
$data = [System.Windows.Forms.Clipboard]::GetDataObject()
$formats = $data.GetFormats()
Write-Info "Available clipboard formats: $($formats -join ', ')"

$paths = $null
# 1) Try FileDrop
if ($data.GetDataPresent([System.Windows.Forms.DataFormats]::FileDrop)) {
    try { $paths = $data.GetData([System.Windows.Forms.DataFormats]::FileDrop) } catch {}
}

# 2) Try named FileDropList
if (-not $paths -and $data.GetDataPresent('FileDropList')) {
    try { $paths = $data.GetData('FileDropList') } catch {}
}

# 3) Try UnicodeText and parse lines that are valid paths
if (-not $paths -and $data.GetDataPresent([System.Windows.Forms.DataFormats]::UnicodeText)) {
    try {
        $text = $data.GetData([System.Windows.Forms.DataFormats]::UnicodeText)
        if ($text) {
            $candidates = $text -split "\r?\n" | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }
            $valid = $candidates | Where-Object { Test-Path $_ }
            if ($valid -and $valid.Count -gt 0) { $paths = $valid }
        }
    } catch {}
}

if (-not $paths -or $paths.Count -eq 0) {
    Write-Err "No file path in clipboard. Copy an image file in Explorer (Ctrl+C) first." 
    Write-Info "Clipboard formats detected: $($formats -join ', ')"
    exit 1
}

$file = $paths[0]
Write-Info "Found path in clipboard: $file"
if (-not (Test-Path $file)) {
    Write-Err "Clipboard path does not exist: $file"
    exit 2
}

$ext = [System.IO.Path]::GetExtension($file).ToLower()
$allowed = '.png','.jpg','.jpeg','.bmp','.gif','.tif','.tiff'
if ($allowed -notcontains $ext) {
    Write-Err "File extension '$ext' does not look like an image."
    exit 4
}

try {
    # Load bytes and create image from stream to avoid locking original file
    $bytes = [System.IO.File]::ReadAllBytes($file)
    $ms = New-Object System.IO.MemoryStream(,$bytes)
    $img = [System.Drawing.Image]::FromStream($ms)
    [System.Windows.Forms.Clipboard]::SetImage($img)
    Write-Info "OK: image placed into clipboard from $file"
    exit 0
} catch {
    Write-Err "Failed to load or set image: $_"
    exit 3
}
