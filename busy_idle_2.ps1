param($frequency)
$has_frequency = $null -ne $frequency
if (!$has_frequency) {
    $frequency = 1
}

Add-Type -AssemblyName System.Windows.Forms
$WShell = New-Object -ComObject Wscript.Shell

$maxPos = Get-WmiObject -Class Win32_DesktopMonitor | Select-Object ScreenWidth,ScreenHeight
Write-Host $maxPos.ScreenHeight
$pressedKey = $null

while($pressedKey.Key -ne "q"){
    if([Console]::KeyAvailable){
        $pressedKey = [Console]::ReadKey($true)
    }
    
    $x = Get-Random -Maximum $maxPos.ScreenWidth
    $y = Get-Random -Maximum $maxPos.ScreenHeight
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x,$y)
    $WShell.SendKeys("{SCROLLLOCK}")
    Start-Sleep -Milliseconds 100
    $WShell.SendKeys("{SCROLLLOCK}")
    Start-Sleep -Seconds $frequency
}