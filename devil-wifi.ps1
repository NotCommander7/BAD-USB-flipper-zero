$output = ""
$profiles = netsh wlan show profiles | Select-String ":(.+)$"

foreach ($profile in $profiles) {
    $name = $profile.Matches.Groups[1].Value.Trim()
    $details = netsh wlan show profile name="$name" key=clear
    $passwordLine = $details | Select-String "Key Content"
    $password = if ($passwordLine) { $passwordLine.Matches.Groups[1].Value.Trim() } else { "N/A" }
    $output += "`n$name : $password"
}

$output | Out-File "$env:USERPROFILE\Desktop\wifi-passwords.txt"
