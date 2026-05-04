# CobAll

[![Lint and Compile](https://github.com/ByteMeHahaha/CobAll/actions/workflows/LintAndCompile.yml/badge.svg)](https://github.com/ByteMeHahaha/CobAll/actions/workflows/LintAndCompile.yml)

A COBOL app that combines different functionalities of COBOL into one app as a
demo.

- Author: Ethan Kletschke
- Version: `0.0.5`
- Developed on: Windows 11
- License: MIT
- Project metadata file: [`project.yaml`](./meta/project.yaml)

---

- [CobAll](#coball)
  - [About CobAll](#about-coball)
    - [Notes About User Input](#notes-about-user-input)

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
- Writing debug logs to a file with different log levels, e.g. `DBG`, `WARN`,
  `INF`, etc.
  - This is implemented using a subroutine, which I've personally never
    been able to pull off until now
- A main menu screen to decide what screen you want to go to

### Notes About User Input

Because the "GUI" is just a "styled" terminal screen (text-based user interface)
and not a proper GUI.

GnuCOBOL's implementation of COBOL's `SCREEN` section is admittedly quite
finicky with its user input.
Because of this, the fields on the different TUI screens may be a bit (or very)
buggy and/or unpredictable when typing input into them.

Furthermore, while it is possible to use the mouse to click and focus on a
specific input field, to avoid unpredictable behaviour, use the arrow keys to
navigate across fields.
