# 🏛️ Project Governance — SecureGen

This document describes how decisions are made in the SecureGen project, how contributions are reviewed, and how releases are managed.  
The goal is to ensure transparency, fairness, and long‑term maintainability.

---

# 👥 Roles & Responsibilities

## 🛠 Maintainer
The maintainer is responsible for:

- reviewing Pull Requests  
- ensuring code quality and security  
- maintaining compatibility (PS5.1 + PS7+)  
- managing releases and versioning  
- enforcing the Code of Conduct  
- guiding contributors  

Current maintainer:

- **Ledino** — Project creator & lead maintainer

Additional maintainers may be added in the future.

---

# 🤝 Decision Process

SecureGen follows a **consensus‑driven** model:

### ✔ Small changes (docs, typos, minor fixes)
Approved by the maintainer after a quick review.

### ✔ Medium changes (new parameters, refactors, tests)
Require:

- a clear justification  
- alignment with project architecture  
- passing CI  
- updated documentation  

### ✔ Major changes (new cmdlets, breaking changes)
Require:

- an Issue or Discussion beforehand  
- design validation  
- architectural review  
- agreement from the maintainer  

Breaking changes are avoided unless absolutely necessary.

---

# 🧪 Pull Request Requirements

All PRs must follow:

- **Conventional Commits**  
- **Pester tests** for new features  
- **PS5.1 + PS7 compatibility**  
- **PSScriptAnalyzer compliance**  
- **Updated documentation** (cmdlets + README if needed)  
- **No manual edits** to:
  - `CHANGELOG.md`
  - `ModuleVersion` in `SecureGen.psd1`

The maintainer may request changes before merging.

---

# 🚀 Release Management

SecureGen uses:

- **semantic versioning** (MAJOR.MINOR.PATCH)  
- **standard‑version** for changelog generation  
- **Git tags** to trigger PowerShell Gallery publishing  

Release flow:

1. PRs merged into `main`  
2. Maintainer runs `npm run release`  
3. Git tag created  
4. GitHub Actions publishes to PSGallery  
5. Release notes generated automatically  

Only maintainers can publish releases.

---

# 🛡 Security Governance

Security issues follow the private disclosure process described in:

👉 `SECURITY.md`

The maintainer is responsible for:

- validating reports  
- preparing patches  
- coordinating responsible disclosure  
- issuing CVEs if appropriate  

---

# 📚 Documentation Governance

Documentation must remain:

- bilingual (EN/FR)  
- consistent with the module’s API  
- aligned with the real workflow  
- clear for beginners and professionals  

The maintainer validates all structural changes to the docs.

---

# 🌱 Community Participation

Community members are encouraged to:

- open Issues  
- propose features  
- submit PRs  
- improve documentation  
- participate in Discussions  

All contributions are welcome as long as they follow:

- the Code of Conduct  
- the Contribution Guidelines  
- the Security Policy  

---

# 🏁 Final Notes

SecureGen is a community‑friendly project, but quality, security, and maintainability remain top priorities.  
This governance model ensures that the project evolves responsibly while staying accessible to contributors.

Thank you for helping make SecureGen better!
