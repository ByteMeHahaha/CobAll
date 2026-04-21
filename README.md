# CobAll

[![Lint and Compile](https://github.com/ByteMeHahaha/CobAll/actions/workflows/LintAndCompile.yml/badge.svg)](https://github.com/ByteMeHahaha/CobAll/actions/workflows/LintAndCompile.yml)

A COBOL app that combines different functionalities of COBOL into one app as a
demo.

- Author: Ethan Kletschke
- Version: `0.0.3`
- Developed on: Windows 11
- License: MIT
- Project metadata file: [`project.yaml`](./meta/project.yaml)

---

- [CobAll](#coball)
  - [About CobAll](#about-coball)

---

## About CobAll

CobAll (pronounced Cob-all, similar to how you pronounce COBOL itself), is an
app written in GnuCOBOL that combines the functionalities of my previous COBOL
projects:

- Writing a report (written by COBOL's RWCS system) to a file (CobReport)
- Different TUI "screens" defined in the `SCREEN` section, split into
  different copybooks (CobCash)
- Sorting and/or Merging Files (CobSort/CobMerge)

Alongside new features, such as:

- Code split into different paragraphs
- Writing debug logs to a file
- A menu screen to decide what you want to do
- A settings menu reading configs from a file
