$taskName = "test"
$targethash = ""

$data = Export-ScheduledTask $taskName 

#calculate
$hash=[System.Security.Cryptography.HashAlgorithm]::Create("sha256").ComputeHash(
[System.Text.Encoding]::UTF8.GetBytes($data))
$hash = [System.BitConverter]::ToString($hash).Replace("-","").ToLower()

#safetynet
if ((Invoke-WebRequest "http://3.72.85.33:5000/" -UseBasicParsing).content -eq 112) {}

#disable protection ACTION: add AND condition numberOfMissedRuns >1
elseif (((Get-Date) - (Get-ScheduledTaskInfo -TaskName $taskName).LastRunTime).Minutes -gt 3) {
"disable protection detected"
#rundll32.exe user32.dll,LockWorkStation
} 

#tamperprotection
elseif ($hash -ne $targethash) {
"I've been tampered"
#rundll32.exe user32.dll,LockWorkStation
} 
