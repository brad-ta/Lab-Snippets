$fileName = "Set-SecureAutoLogon.ps1"
$backupName = "Set-SecureAutoLogon-Orig.ps1"

$parentPath_Test = "C:\Users\Administrator\Desktop\"
$parentPath_Prod = "C:\Users\Administrator\AppData\Roaming\BoxStarter\" + `
	"Boxstarter.Bootstrapper\"
	
$filePath = $parentPath_Prod + $fileName
Write-Host $filePath

$backupPath = $parentPath_Prod + $backupName
Write-Host $backupPath


if (-not (Select-String $filePath -pattern "BRAD@TA FIX" -quiet)) {
	Write-Host "Boxstarter logon fix required."
	
	# Backup the file.
	Copy-Item $filePath $backupPath
	
	# Read in lines of file.
	$lines = Get-Content -Path $filePath;
	
	# Make a small block of lines to insert.
	$insertLines = @(
		"        # BRAD@TA FIX 2015-05-20",
		"        Set-ItemProperty -Path $WinlogonPath -Name DefaultPassword -Value $decryptedPass -Force",
		"        # BRAD@TA FIX END",
		""
	)
	
	# Insert them
	$newLines = $lines[0..251] + $insertLines + $lines[252..($lines.length)]
	
	# Save the file
	$newLines > $filePath
	
	# DEBUG - Print the file to console
	# $newLines | ForEach-Object { Write-Host $_}
	
} else {
	Write-Host "No Boxstarter logon fix required."
	
}
