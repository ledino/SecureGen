# 🗺️ SecureGen Roadmap

This roadmap outlines the planned improvements, upcoming features, and long‑term vision for SecureGen.  
It is not a strict schedule, but a transparent overview of where the project is heading.

---

# ✅ Completed (v1.5.x)

- Full documentation overhaul (FR/EN)
- PKI‑ready passphrase generator (`Get-PKIPass`)
- Clipboard safety improvements
- SecureString support
- Cross‑platform clipboard fallback (Windows/macOS/Linux)
- Architecture split: Core.PS7 / Legacy.PS5
- Pester test suite
- PSScriptAnalyzer compliance
- Standard‑version release workflow
- Community files:
  - CODE_OF_CONDUCT.md  
  - SECURITY.md  
  - SUPPORT.md  
  - GOVERNANCE.md  
  - MAINTAINERS.md  
  - CONTRIBUTING.en.md  
  - Issue & PR templates  
  - Discussion templates  
  - FUNDING.yml  

SecureGen is now a fully structured, professional‑grade open‑source project.

---

# 🚧 In Progress

## 🔐 Security & Cryptography
- Improve entropy analysis tools
- Optional entropy scoring output for all generators
- Research: Argon2‑based key derivation helper (non‑breaking)

## 📚 Documentation
- Add more real‑world PKI examples
- Add “recipes” for automation (CI/CD, service accounts, certificates)
- Add a troubleshooting section for clipboard issues on Linux

## 🧪 Testing
- Expand Pester coverage for edge cases
- Add cross‑platform CI matrix for macOS (optional)

---

# 🧭 Planned (v1.6.x)

## ✨ New Features
- **Profiles system**  
  Predefined password/passphrase profiles (e.g., “HighEntropy”, “Memorable”, “PKI‑Strong”).

- **Entropy‑aware passphrase generator**  
  Optional minimum entropy threshold.

- **Custom wordlists**  
  Allow users to provide their own dictionary for passphrases.

- **SecureGen CLI improvements**  
  Better UX for interactive usage.

## 🛠 Developer Experience
- Add `CONTRIBUTING.fr.md`
- Add more examples in `examples.md`
- Add a Release Notes template for GitHub Releases

---

# 🌅 Long‑Term Vision (v2.x)

## 🔐 Advanced Security Features
- Optional integration with platform‑native secure storage:
  - Windows DPAPI
  - macOS Keychain
  - Linux Secret Service (if available)
- Secure ephemeral memory handling (best‑effort, cross‑platform)

## 🧱 Architecture
- Modularization of generators (password, passphrase, PKI)
- Unified internal RNG abstraction layer
- Optional plugin system for custom generators

## 🧪 Testing & Quality
- 100% Pester coverage target
- Fuzz testing for RNG and character pools

---

# 🤝 Community & Ecosystem

- Encourage community wordlists and profiles
- Provide templates for external integrations (Terraform, Ansible, DSC)
- Publish a “SecureGen Best Practices” guide

---

# 📝 Notes

This roadmap is a living document.  
Priorities may change based on:

- community feedback  
- security recommendations  
- PowerShell ecosystem evolution  
- contributor availability  

Contributions are welcome — see `CONTRIBUTING.md`.
