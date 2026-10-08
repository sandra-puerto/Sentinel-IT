<div align="center">

# 🛡️ Sentinel-IT
**Maintenance and Control-Mapping Suite for Windows Endpoints**

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg?logo=powershell&logoColor=white)](#)
[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011%20%7C%20Server-0078D6?logo=windows&logoColor=white)](#)
[![Mapped Controls](https://img.shields.io/badge/Mapped%20controls-ISO%2027001%20%7C%20ISO%2020000--1-success.svg)](#)
[![License](https://img.shields.io/badge/License-MIT--based%20Custom-lightgrey.svg)](#)

*PowerShell automation with no third-party dependencies and structured logging designed for SIEM ingestion.*

---
</div>

## 📌 Overview
Routine endpoint hygiene (storage cleanup, malware scans, system integrity checks) is often done by hand or with heavy third-party agents. **Sentinel-IT** is a Hub-and-Spoke PowerShell automation suite that runs these routines on a schedule and associates each one with a specific control from ISO/IEC 27001:2022 or ISO/IEC 20000-1.

It can run autonomously under the `NT AUTHORITY\SYSTEM` context and records what was executed, when, and under which identity, to support IT audit processes.

> **Scope note:** Sentinel-IT helps automate routines that relate to the controls listed below. It does not make an organization compliant or certified; that depends on the organization's full management system.

## 🚀 Key Features
- 🔌 **Native architecture:** runs on PowerShell 5.1+ and relies on built-in Windows components (Microsoft Defender, DISM). No third-party modules or background services.
- 📡 **Structured logging:** configurable JSON output, designed for ingestion by SIEM platforms (such as Splunk, Datadog or Azure Sentinel) through your existing log forwarders.
- 🔐 **Audit-friendly logging:** each action is timestamped and records the execution identity and Process ID (PID).
- ⚙️ **Modular design:** a central core handles logging and privileges, while independent "Engines" run each routine.

---

## 🏛️ Control Mapping
Each engine is associated with a selected control. The mapping reflects the author's interpretation and is documented in [`ISO_MAPPING.md`](docs/ISO_MAPPING.md).

| Engine Script               | Control (ISO 27001:2022 / 20000-1) | Objective                         | Implementation                                                   |
|-----------------------------|------------------------------------|-----------------------------------|------------------------------------------------------------------|
| `Invoke-CleanupScreenshots` | **A.8.12** / A.8.10                | Reduce data exposure on endpoints | Automates removal of local and OneDrive screenshots.             |
| `Invoke-DefenderScan`       | **A.8.7**                          | Protection against malware        | Triggers scheduled Full Scans silently.                          |
| `Invoke-IntegrityCheck`     | **A.8.9**                          | Configuration and system health   | Runs `DISM /ScanHealth` to check for Component Store corruption. |
| `Invoke-CleanupTempGlobal`  | **A.8.6** / ISO 20000-1            | Storage capacity management       | Clears system-wide and multi-user temporary caches.              |

> ⚠️ **Data removal notice:** the screenshot and temporary-file engines delete files. Review the scope of each engine and test on a non-production device before deploying.

---

## 📦 Deployment
The suite includes an installer (`Install-Sentinel.ps1`) that deploys the modular framework and creates scheduled Windows tasks that run without user interaction.

```powershell
# Open PowerShell as Administrator and run:
.\installer\Install-Sentinel.ps1
```

The installer supports silent execution, so it is designed to be deployable through tools such as Intune, SCCM or Group Policy.

---

## 🏗️ Documentation
- 📄 [**System Architecture (ARCHITECTURE.md)**](docs/ARCHITECTURE.md)
- 📊 [**Control Mapping (ISO_MAPPING.md)**](docs/ISO_MAPPING.md)
- 🔒 [**Security Policy (SECURITY.md)**](SECURITY.md)

---
<div align="center">
<b>Designed and developed by Sandra Puerto (@sandra-puerto)</b><br>
<sub>Distributed under an MIT-based custom license. See the <a href="LICENSE">LICENSE</a> file for details.</sub>
</div>
