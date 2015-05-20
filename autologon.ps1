cd C:\Users\Administrator\Desktop
. .\Set-SecureAutoLogon.ps1
Set-SecureAutoLogon -username "Administrator" -password $(ConvertTo-SecureString "TechAccel1!" -AsPlainText -Force)
# Set-SecureAutoLogon -username "brad" -password $(ConvertTo-SecureString "MonkE123" -AsPlainText -Force)
Restart-Computer
