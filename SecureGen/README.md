# SecureGen

SecureGen is a modern, secure, cross‑platform PowerShell module designed to generate strong passwords, passphrases, PKI secrets, and cryptographic indexes with a clean and ergonomic developer experience.

---

## 🚀 Features

- Generate strong passwords (`Get-PassWord`)
- Create secure passphrases (`Get-PassPhrase`)
- Produce PKI‑ready secrets (`Get-PKIPass`)
- Generate cryptographic indexes (`Get-CryptoIndex`)
- Cross‑platform (Windows, Linux, macOS)
- Fully documented with PlatyPS
- Fast, lightweight, no dependencies

---

## 📦 Installation

```powershell
Install-Module SecureGen -Scope CurrentUser
```

---

## 🧪 Quick Examples

### Generate a password

```powershell
Get-PassWord -Length 20
```

### Generate a passphrase

```powershell
Get-PassPhrase -Words 5
```

### Generate a PKI secret

```powershell
Get-PKIPass
```

---

## 📘 Documentation

Full documentation, diagrams, examples, and developer guides are available on GitHub:

https://github.com/Ledino/SecureGen

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome.  
See the contributing guidelines on GitHub.

---

## 📜 License

MIT License  
Copyright (c) 2026 Ledino

---