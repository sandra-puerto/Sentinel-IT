<#
.SYNOPSIS
    Sentinel-IT Enterprise Logging Module
.DESCRIPTION
    Provides standardized forensic logging capabilities (Text and JSON for SIEM).
#>

$global:SentinelLogFormat = "TEXT" # Can be set to "JSON" for SIEM integration
$global:SentinelLogDir = "C:\Program Files\IT_Maintenance\logs"

function Initialize-SentinelLog {
    param([string]$EngineName)
    $LogPath = Join-Path $global:SentinelLogDir $EngineName
    if (-not (Test-Path $LogPath)) { New-Item -ItemType Directory -Path $LogPath -Force | Out-Null }
    
    $PreciseTime = Get-Date -Format "yyyyMMdd_HHmmss_fffffff"
    $global:CurrentLogFile = Join-Path $LogPath ("$($EngineName)_$($PreciseTime).log")
}

function Write-AuditEntry {
    param (
        [Parameter(Mandatory=$true)][string]$Message,
        [Parameter(Mandatory=$false)][ValidateSet("INFO", "SUCCESS", "WARN", "ERROR")][string]$Level = "INFO",
        [Parameter(Mandatory=$false)][hashtable]$Metadata = @{}
    )
    
    if (-not $global:CurrentLogFile) { return }

    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fffffff"
    $Identity = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $HostName = $env:COMPUTERNAME

    if ($global:SentinelLogFormat -eq "JSON") {
        $LogObj = [ordered]@{
            Timestamp = $Timestamp
            Level = $Level
            Host = $HostName
            Identity = $Identity
            PID = $PID
            Message = $Message
            Metadata = $Metadata
        }
        $LogObj | ConvertTo-Json -Compress | Add-Content -Path $global:CurrentLogFile
    } else {
        $MetaStr = if ($Metadata.Count -gt 0) { " | " + ($Metadata.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" } -join ", ") } else { "" }
        $Entry = "[{0}] [{1}] [PID:{2}] [{3}] {4}{5}" -f $Timestamp, $Level.PadRight(7), $PID, $Identity, $Message, $MetaStr
        $Entry | Add-Content -Path $global:CurrentLogFile
    }
}

Export-ModuleMember -Function Initialize-SentinelLog, Write-AuditEntry
