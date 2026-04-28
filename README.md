# 🏁 Sentinel-IT: Automated Compliance & Maintenance Suite

## 1. Overview
Sentinel-IT is an automation ecosystem for Windows endpoint hygiene, security, and compliance. Designed as a proactive response to modern infrastructure challenges, this suite covers critical controls from ISO 27001:2022 and ISO 20000-1 frameworks. It ensures asset protection, malware management, system integrity, and storage optimization in an unattended, resilient, and auditable manner.

## 2. Suite Architecture & ISO Mapping
The suite consists of four specialized engines orchestrated to run via Windows Task Scheduler under the highest-privilege security context: `NT AUTHORITY\SYSTEM`.

| Script                         | ISO Control | Technical Function                                | Business Value                      |
|--------------------------------|-------------|--------------------------------------------------|-------------------------------------|
| ISO_Cleanup_Screenshots.ps1    | A.8.1       | Multi-profile purge of screenshots (Local & OneDrive). | Data Leakage Prevention (DLP).     |
| ISO_Defender_Scan.ps1          | A.8.7       | Forced Full Scan via Microsoft Defender Engine.  | Malware Mitigation & Response.     |
| ISO_Cleanup_Temp_Global.ps1    | ISO 20000   | System-wide and user cache reclamation.          | Storage Capacity Management.       |
| ISO_Integrity_Check.ps1        | A.8.20      | Component Store Audit (DISM) for binary consistency. | Configuration Security & Integrity. |

## 3. Logging Standard (Forensic Level)
To ensure absolute audit traceability, each execution generates an independent telemetry file:

- **Nanosecond Precision:** Naming convention `[ScriptName]_[YYYYMMDD_HHmmss_fffffff].log`.
- **Metadata Rich:** Includes Hostname, Execution Identity, Process ID (PID), and standardized log levels (INFO, SUCCESS, WARN, ERROR).
- **Resilience:** High-tolerance execution; uses isolated Try/Catch blocks per profile to ensure system-locked folders do not halt the audit.

## 4. Deployment Specifications
- **Operating System:** Windows 10/11 or Windows Server 2016+.
- **Standard Path:** `C:\Program Files\IT_Maintenance\scripts\`
- **Log Repository:** `C:\Program Files\IT_Maintenance\logs\`

## 5. Implementation Guide

### Step 1: Script Provisioning
Deploy the `.ps1` files to the standard path. Ensure ACLs (Access Control Lists) restrict write access to Administrators only.

### Step 2: Task Scheduler Orchestration
For each component, create a task with the following "Hardened" parameters:

- **User Context:** `SYSTEM`
- **Privileges:** "Run with highest privileges."
- **Execution Argument:**
```powershell
PowerShell -NoProfile -ExecutionPolicy Bypass -File "C:\Program Files\IT_Maintenance\scripts\SCRIPT_NAME.ps1"
```

## 6. Security & Governance
- **Policy Integrity:** Uses `-ExecutionPolicy Bypass` to execute local logic without degrading the global system security posture.
- **Error Isolation:** Designed with granular error handling to maintain continuity during multi-user environment scans.

## 7. Credits & Authorship
- **Lead Architect & Maintainer:** @gabypuertor964
- **Technical Copilot:** Powered by Google Gemini (AI Orchestration)
- **License:** Apache License 2.0
