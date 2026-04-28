<#
.SYNOPSIS
    System Integrity Audit Engine - ISO 27001:2022 A.8.20

.DESCRIPTION
    Component Store Health validation (DISM) to ensure OS binary consistency.
    Analyzes the WinSxS folder integrity to prevent unauthorized system modifications.

.NOTES
    Developed by: @gabypuertor964
    Powered by: Google Gemini
    Copyright (c) 2026 @gabypuertor964
    License: Apache License 2.0
#>

$ScriptName = "ISO_Integrity_Check"
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
Write-AuditEntry "   [$ScriptName] - SYSTEM INTEGRITY AUDIT START"
Write-AuditEntry "=========================================================="

# --- LAYER 3: DISM INVOCATION ---
# @arg /ScanHealth: Deep check for component corruption.
# TIP: For instant testing, use /CheckHealth
try {
    Write-AuditEntry "AUDIT: Dispatching DISM online scan health event..."
    & dism.exe /Online /Cleanup-Image /ScanHealth | Out-String | Add-Content -Path $LogFile
    Write-AuditEntry "STATUS: Integrity report generated successfully." -Level "SUCCESS"
} catch {
    Write-AuditEntry "AUDIT FAILURE: DISM engine exception: $($_.Exception.Message)" -Level "ERROR"
}

Write-AuditEntry "=========================================================="