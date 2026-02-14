# 🔐 Security Advisory — SecureGen

Thank you for taking the time to report a potential security vulnerability.  
Please fill out the sections below to help the maintainer assess and address the issue quickly and responsibly.

---

## 🧩 Summary

Provide a clear and concise description of the vulnerability:

- What is the issue?
- What part of SecureGen is affected?
- What is the potential impact?

---

## 🔍 Technical Details

Please include as much detail as possible:

- Affected cmdlets (e.g., `Get-PKIPass`, `Get-PassPhrase`, clipboard functions, etc.)
- Affected PowerShell versions (PS5.1, PS7+)
- Affected OS (Windows, Linux, macOS)
- Relevant code paths or functions
- Any cryptographic concerns

---

## 🧪 Steps to Reproduce

Provide a minimal reproducible example:

```powershell
# Example
Get-PassWord -Length 32
```

Include:

- expected behavior  
- actual behavior  
- error messages or logs (if any)

---

## 🔐 Impact Assessment

Explain the potential severity:

- Does it expose secrets?
- Does it weaken cryptographic guarantees?
- Does it affect PKI workflows?
- Does it impact automation or CI/CD?
- Does it allow privilege escalation?

---

## 🛠 Suggested Fix (optional)

If you have ideas for remediation, please include them:

- code suggestions  
- architectural considerations  
- security best practices  

This is optional but appreciated.

---

## 🧭 Environment Details

Please include:

```powershell
$PSVersionTable
(Get-Module SecureGen).Version
[System.Environment]::OSVersion
```

---

## 📎 Additional Notes

Add any relevant information:

- screenshots  
- logs  
- references  
- related issues  
- proof‑of‑concept code  

---

Thank you for reporting this issue responsibly.  
The maintainer will review your advisory as soon as possible.S

---
