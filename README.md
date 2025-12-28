# CA2025 Term Project – MyCPU 4-soc Extension

This repository is developed as part of the CA2025 term project.

## Base Implementation

This project is based on the refined 4-soc implementation provided by
the course staff:

https://github.com/sysprog21/ca2025-mycpu/tree/main/4-soc

The original 4-soc README and source code are preserved under the
`4-soc/` directory.

## Project Goal

- Extend the 4-soc system to support:
  - [ ] VGA-based game output
  - [ ] Keyboard input
  - [ ] Timer / interrupt support
- Port and validate selected applications (e.g., trex, auto-tetris)

## How to Build (Base System)

```bash
cd 4-soc
make check-vga
make check-uart
make shell
