# Basic DFT Scan Chain + ATPG Demo

This repository is a minimal, professional-looking scaffold for a basic DFT flow demo.
Status: scaffold only (no RTL or scripts yet).

## Project Goals
- Show a tiny sequential RTL design.
- Run open-source synthesis and generate a gate-level netlist.
- Cut sequential elements for ATPG.
- Generate stuck-at fault vectors.
- Insert a scan chain and compare netlists.

## Repo Layout
basic-dft-scan-chain-yosys-fault/
├── rtl/
│   └── counter.v
├── tb/
│   └── counter_tb.v
├── scripts/
│   ├── synth.sh
│   ├── cut.sh
│   ├── atpg.sh
│   └── scan_chain.sh
├── netlists/
├── results/
├── README.md
└── Makefile

## Planned Flow
1. RTL design
2. Logic synthesis (Yosys)
3. Sequential cut for ATPG
4. ATPG (stuck-at)
5. Scan chain insertion
6. Compare original vs scan-inserted netlists

## Notes
- Files are placeholders only.
- Fill in RTL, testbench, and scripts in the next step.
