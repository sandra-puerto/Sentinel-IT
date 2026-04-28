<#
.SYNOPSIS
    Asset Sanitization Engine - ISO 27001:2022 Control A.8.1

.DESCRIPTION
    Multi-user screenshot purge to prevent sensitive data exposure in local and cloud vectors.
    Optimized for compliance environments where data leakage must be mitigated.

.PARAMETER PreciseTime
    High-resolution timestamp with nanosecond precision for forensic logging.

.NOTES
    Developed by: @gabypuertor964
    Powered by: Google Gemini
    Copyright (c) 2026 @gabypuertor964
    License: Apache License 2.0
#>

# --- PRE-FLIGHT: INFRASTRUCTURE ---
$ScriptName = "ISO_Cleanup_Screenshots"
$LogRoot    = "C:\Program Files\IT_Maintenance\logs\$ScriptName"
if (!(Test-Path $LogRoot)) { New-Item -ItemType Directory -Path $LogRoot -Force | Out-Null }

# High-Precision Timestamp (Nanoseconds: fffffff)
$PreciseTime = Get-Date -Format "yyyyMMdd_HHmmss_fffffff"
$LogFile     = Join-Path $LogRoot ("$($ScriptName)_$($PreciseTime).log")

# --- CORE LOGGING ENGINE ---
function Write-AuditEntry {
    param (
        [Parameter(Mandatory=$true)][string]$Message,
        [Parameter(Mandatory=$false)][ValidateSet("INFO", "SUCCESS", "WARN", "ERROR")][string]$Level = "INFO"
    )
    $ExactNow = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fffffff"
    $Entry = "[{0}] [{1}] {2}" -f $ExactNow, $Level.PadRight(7), $Message
    $Entry | Add-Content -Path $LogFile
}

Write-AuditEntry "=========================================================="
Write-AuditEntry "   [$ScriptName] - SECURITY AUDIT SESSION START"
Write-AuditEntry "=========================================================="
Write-AuditEntry "HOST: $($env:COMPUTERNAME) | PID: $PID"
Write-AuditEntry "IDENTITY: $([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)"
Write-AuditEntry "----------------------------------------------------------"

try {
    # Recursive Profile Discovery
    $Profiles = Get-ChildItem -Path "C:\Users" -Directory -Force -ErrorAction SilentlyContinue
    Write-AuditEntry "DISCOVERY: Total profile objects identified: $($Profiles.Count)"

    foreach ($Profile in $Profiles) {
        $UserName = $Profile.Name
        
        # System Profile Exclusion Logic
        if ($UserName -match "All Users|Default User|LocalService|NetworkService") { continue }

        Write-AuditEntry "INSPECTING: Subject [$UserName]"
        
        $Vectors = @(
            (Join-Path $Profile.FullName "OneDrive\Pictures\Screenshots"),
            (Join-Path $Profile.FullName "Pictures\Screenshots"),
            (Join-Path $Profile.FullName "OneDrive\Imágenes\Capturas"),
            (Join-Path $Profile.FullName "Imágenes\Capturas")
        )

        foreach ($Path in $Vectors) {
            if (Test-Path -Path $Path) {
                try {
                    $Assets = Get-ChildItem -Path $Path -File -Force -ErrorAction SilentlyContinue
                    if ($Assets.Count -gt 0) {
                        $Count = $Assets.Count
                        # Technical Purge (Force & Recurse)
                        Remove-Item -Path "$Path\*" -Force -Recurse -ErrorAction Stop
                        Write-AuditEntry "PURGE: Cleared $Count assets from [$Path]" -Level "SUCCESS"
                    } else {
                        Write-AuditEntry "IDLE: Vector found but zero content present in [$Path]"
                    }
                } catch {
                    Write-AuditEntry "I/O FAILURE: Access denied or file lock at [$Path]" -Level "WARN"
                }
            }
        }
    }
} catch {
    Write-AuditEntry "CRITICAL FAILURE: $($_.Exception.Message)" -Level "ERROR"
}

Write-AuditEntry "----------------------------------------------------------"
Write-AuditEntry "   [$ScriptName] - SESSION END (RC: $LASTEXITCODE)"
Write-AuditEntry "=========================================================="