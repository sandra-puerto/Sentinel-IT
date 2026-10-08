<div align="center">

# 🛡️ Sentinel-IT
**Automated Compliance & Maintenance Suite for Enterprise Endpoints**

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg?logo=powershell&logoColor=white)](#)
[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011%20%7C%20Server-0078D6?logo=windows&logoColor=white)](#)
[![Compliance](https://img.shields.io/badge/Compliance-ISO%2027001%20%7C%20ISO%2020000--1-success.svg)](#)
[![License](https://img.shields.io/badge/License-Enhanced%20MIT-lightgrey.svg)](#)

*Zero-dependency, SIEM-ready infrastructure automation built for security and auditability.*

---
</div>

## 📌 The Engineering Vision
Modern IT infrastructure demands proactive hygiene and security baselining. **Sentinel-IT** is a Hub-and-Spoke PowerShell automation ecosystem designed to help enforce critical ISO controls at the endpoint level. 

Designed for enterprise environments, it can run autonomously under the `NT AUTHORITY\SYSTEM` context, assisting in the mitigation of data leakage risks, malware threats, and storage capacity bottlenecks.

## 🚀 Key Enterprise Features
- 🔌 **Native Architecture:** Runs on PowerShell 5.1+, leveraging built-in Windows OS components without requiring third-party background services.
- 📡 **SIEM-Ready Telemetry:** Configurable JSON logging support, providing structured output designed for ingestion by SIEM platforms (like Splunk, Datadog, or Azure Sentinel) via your existing log forwarders.
- 🔐 **Forensic-Level Auditing:** Actions are timestamped to the nanosecond, tracking Execution Identity and Process ID (PID) to support IT auditing processes.
- ⚙️ **Modular & Scalable:** A centralized core handles logging and privileges, while independent "Engines" execute specific compliance runbooks.

---

## 🏛️ ISO Compliance Architecture
Sentinel-IT maps its automated routines directly to global standard frameworks.

| Engine Script                 | ISO Control | Strategic Objective                                   | Sentinel-IT Implementation                                    |
|-------------------------------|-------------|-----------------------------------------------------|---------------------------------------------------------------|
| `Invoke-CleanupScreenshots`   | **A.8.1**   | Data Leakage Prevention (DLP)                       | Automates the purging of local and OneDrive screenshot vectors. |
| `Invoke-DefenderScan`         | **A.8.7**   | Malware Mitigation                                  | Triggers automated Full Scans silently.                       |
| `Invoke-IntegrityCheck`       | **A.8.20**  | System Integrity Validation                         | Runs `DISM /ScanHealth` to check for Component Store corruption.|
| `Invoke-CleanupTempGlobal`    | **20000-1** | Storage Capacity Management                         | Systematically clears system-wide and multi-user caches.      |

---

## 📦 Deployment & Orchestration
Deploying Sentinel-IT across a fleet of devices is highly streamlined. 

### Interactive / Silent Installation
The suite includes an enterprise orchestrator (`Install-Sentinel.ps1`) that deploys the modular framework and schedules stealth-mode Windows Tasks automatically.

```powershell
# Open PowerShell as Administrator and run:
.\installer\Install-Sentinel.ps1
```
*(Supports silent deployment for Intune, SCCM, or Group Policy).*

---

## 🏗️ Technical Documentation
For deep-dives into the framework mechanics and security guidelines, consult our official documentation:
- 📄 [**System Architecture (ARCHITECTURE.md)**](docs/ARCHITECTURE.md)
- 📊 [**Full Compliance Mapping (ISO_MAPPING.md)**](docs/ISO_MAPPING.md)
- 🔒 [**Security Policy (SECURITY.md)**](SECURITY.md)

---
<div align="center">
<b>Engineered by Sandra Puerto (@sandra-puerto)</b><br>
<sub>Protected under the Enhanced MIT License. See the <a href="LICENSE">LICENSE</a> file for details.</sub>
</div>
