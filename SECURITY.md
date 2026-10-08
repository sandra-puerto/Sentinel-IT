# Security Policy

## Supported Versions
| Version | Supported          |
| ------- | ------------------ |
| 2.x     | :white_check_mark: |
| < 2.0   | :x:                |

## Reporting a Vulnerability
If you discover a security vulnerability within Sentinel-IT, please send an e-mail to Sandra Puerto at contacto@sandrapuerto.com. All security vulnerabilities will be promptly addressed.

We take the security of our automated infrastructure scripts very seriously, given their execution context (`NT AUTHORITY\SYSTEM`). Ensure your environment strictly restricts write access to the deployment folder (`C:\Program Files\IT_Maintenance\Sentinel-IT\`) to prevent local privilege escalation (LPE).
