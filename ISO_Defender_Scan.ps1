<#
.SYNOPSIS
    Endpoint Security Engine - ISO 27001:2022 Control A.8.7

.DESCRIPTION
    Full malware scan via Microsoft Defender Engine. 
    Automates the protection against malware execution at the endpoint level.

.NOTES
    Developed by: @gabypuertor964
    Powered by: Google Gemini
    Copyright (c) 2026 @gabypuertor964
    License: Apache License 2.0
#>

$ScriptName = "ISO_Defender_Scan"
$LogRoot    = "C:\Program Files\IT_Maintenance\logs\$ScriptName"
if (!(Test-Path $LogRoot)) { New-Item -ItemType Directory -Path $LogRoot -Force | Out-Null }

$PreciseTime = Get-Date -Format "yyyyMMdd_HHmmss_fffffff"
$LogFile     = Join-Path $LogRoot ("$($ScriptName)_$($PreciseTime).log")

function Write-AuditEntry {
    param ([string]$Message, [string]$Level = "INFO")
    $ExactNow = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fffffff"
    "[{0}] [{1}] {2}" -f $ExactNow, $Level.PadRight(7), $Message | Add-Content -Path $LogFile
}

Write-AuditEntry "=========================================================="
Write-AuditEntry "   [$ScriptName] - SECURITY SCAN SESSION START"
Write-AuditEntry "=========================================================="

# --- LAYER 3: ENGINE DISPATCH ---
# @arg -ScanType 2: Full Scan. Note: Use -ScanType 1 for Quick Testing.
try {
    Write-AuditEntry "ENGINE: Invoking MpCmdRun.exe for Full Malware Analysis..."
    & "C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2 | Out-String | ForEach-Object {
        if ($_ -match "Error|Fail") { Write-AuditEntry $_ -Level "ERROR" }
        else { Write-AuditEntry $_ -Level "INFO" }
    }
    Write-AuditEntry "RESULT: Antimalware scan operation concluded." -Level "SUCCESS"
} catch {
    Write-AuditEntry "CRITICAL EXCEPTION: $($_.Exception.Message)" -Level "ERROR"
}

Write-AuditEntry "=========================================================="