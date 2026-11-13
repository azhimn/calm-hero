# Send a driver command, capture a burst of frames, stack a cropped strip of each into one contact sheet.
param([string]$Cmd = "next", [int]$Frames = 16, [int]$Top = 500, [int]$Height = 430, [string]$Out = "C:\Roggie\theme\design\shots-live\burst.png")
Add-Type @"
using System; using System.Runtime.InteropServices;
public static class B { [DllImport("user32.dll")] public static extern bool SetProcessDPIAware(); }
"@
[B]::SetProcessDPIAware() | Out-Null
Add-Type -AssemblyName System.Windows.Forms, System.Drawing
$b = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$caps = @()
$Cmd | Out-File "$env:TEMP\pn-cmd.txt" -Encoding ascii
$sw = [Diagnostics.Stopwatch]::StartNew()
for ($i = 0; $i -lt $Frames; $i++) {
  $bmp = New-Object System.Drawing.Bitmap $b.Width, $Height
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.CopyFromScreen(0, $Top, 0, 0, (New-Object System.Drawing.Size $b.Width, $Height)); $g.Dispose()
  $caps += ,@($bmp, $sw.ElapsedMilliseconds)
  Start-Sleep -Milliseconds 25
}
$sc = 0.25; $w = [int]($b.Width * $sc); $h = [int]($Height * $sc)
$sheet = New-Object System.Drawing.Bitmap $w, ($h * $Frames)
$g = [System.Drawing.Graphics]::FromImage($sheet)
$font = New-Object System.Drawing.Font "Segoe UI", 9
for ($i = 0; $i -lt $Frames; $i++) {
  $g.DrawImage($caps[$i][0], 0, $i * $h, $w, $h)
  $g.DrawString("$($caps[$i][1]) ms", $font, [System.Drawing.Brushes]::Yellow, 2, $i * $h + 2)
  $caps[$i][0].Dispose()
}
$sheet.Save($Out); "-> $Out"
