# 🔐 Security Policy — SecureGen

Thank you for taking the time to review the security aspects of SecureGen.  
This document explains how to report vulnerabilities, how disclosures are handled, and what versions receive security updates.

---

# 🛡️ Supported Versions

SecureGen follows a rolling‑release model.  
Only the **latest version published on the PowerShell Gallery** receives:

- security patches  
- maintenance updates  
- vulnerability fixes  

Older versions are not maintained.

Check your installed version:

```powershell
(Get-Module SecureGen).Version
```

---

# 🐛 Reporting a Vulnerability

If you discover a security issue, **do not open a public GitHub Issue**.

Instead, please report it privately using one of the following methods:

### 📧 Private email  
security@ledino.dev  
*(replace with your preferred address if needed)*

### 🔒 GitHub Security Advisories  
`https://github.com/ledino/SecureGen/security/advisories` [(github.com in Bing)](https://www.bing.com/search?q="https%3A%2F%2Fgithub.com%2Fledino%2FSecureGen%2Fsecurity%2Fadvisories")

Please include:

- a clear description of the vulnerability  
- steps to reproduce  
- affected versions  
- environment details (PowerShell 5.1 / 7+, OS, etc.)  
- potential impact  

You will receive a response within **72 hours**.

---

# 🔐 Security Principles

SecureGen is designed with security as a first‑class priority.  
The module follows these principles:

- **Local‑only cryptography** (no external calls, no telemetry)  
- **Modern RNG APIs** (PS7: `RandomNumberGenerator.GetBytes`, PS5: `RNGCryptoServiceProvider`)  
- **No secret storage** (nothing written to disk or logs)  
- **Secure clipboard handling** (with optional clearing)  
- **SecureString support** for sensitive automation  
- **No external dependencies**  
- **Cross‑platform parity** (Windows, Linux, macOS)  

For a full technical breakdown, see:  
👉 `docs/security.md`

---

# 🚫 Out of Scope

The following are **not considered vulnerabilities**:

- Clipboard behavior on systems lacking `xclip`, `xsel`, or `wl-copy`  
- PowerShell ExecutionPolicy restrictions  
- Issues caused by modified forks or custom builds  
- Behavior of external tools (`pbcopy`, `xclip`, etc.)  
- Secrets intentionally printed or logged by user scripts  

---

# 🤝 Responsible Disclosure

If you report a vulnerability responsibly:

- You may be credited in the release notes (optional)  
- A fix will be published as soon as possible  
- A CVE may be issued if appropriate  

Thank you for helping keep SecureGen safe, reliable, and trustworthy.

---
