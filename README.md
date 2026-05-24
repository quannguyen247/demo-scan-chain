# Secure Scan Chain Demo

A simple Verilog demo for understanding the basic idea of **DFT (Design for Testability)** and **scan chains**.

This project uses a 4-bit counter to show how normal flip-flops can be replaced by scan flip-flops, allowing data to be shifted in and out for testing.

---

## What is a Scan Chain?

A normal D flip-flop works like this:

```text
D -> DFF -> Q
```

A scan flip-flop adds a test path:

```text
             +-----+
D ---------->|     |
             | MUX | -> DFF -> Q
scan_in ---->|     |
             +-----+
                ^
             scan_en
```

Operation:

```text
scan_en = 0 -> normal mode
scan_en = 1 -> scan shift mode
```

In this demo, four scan flip-flops are connected as:

```text
scan_in -> q[0] -> q[1] -> q[2] -> q[3] -> scan_out
```

So `q[3:0]` represents the internal scan chain state.

---

## Project Structure

```text
secure-scan-chain/
├── rtl/
│   ├── counter.v
│   ├── counter_scan.v
│   └── scan_dff.v
├── tb/
│   ├── counter_tb.v
│   └── counter_scan_tb.v
├── results/
│   ├── counter.vcd
│   ├── counter_scan.vcd
│   └── counter_scan.gtkw
├── netlists/
│   ├── counter_synth.v
│   └── counter_scan_synth.v
├── Makefile
├── LICENSE
└── README.md
```

Main files:

| File | Description |
|---|---|
| `rtl/counter.v` | Normal 4-bit counter |
| `rtl/scan_dff.v` | Basic scan flip-flop |
| `rtl/counter_scan.v` | Counter built from scan flip-flops |
| `tb/counter_tb.v` | Testbench for normal counter |
| `tb/counter_scan_tb.v` | Testbench for scan chain demo |
| `results/counter_scan.vcd` | Scan chain waveform |
| `results/counter_scan.gtkw` | Saved GTKWave layout |
| `netlists/counter_scan_synth.v` | Synthesized scan-chain netlist |

---

## Requirements

Install tools on Linux or WSL:

```bash
sudo apt update
sudo apt install -y make iverilog gtkwave yosys
```

Check tools:

```bash
make --version
iverilog -V
yosys -V
gtkwave --version
```

---

## Commands

Show available commands:

```bash
make
```

Run normal counter simulation:

```bash
make sim
```

Open normal counter waveform:

```bash
make wave
```

Synthesize normal counter:

```bash
make synth
```

Run scan chain simulation:

```bash
make sim-scan
```

Open scan chain waveform:

```bash
make wave-scan
```

Synthesize scan-chain counter:

```bash
make synth-scan
```

Clean generated files:

```bash
make clean
```

---

## Scan Chain Demo Flow

Run:

```bash
make sim-scan
```

Expected output:

```text
Normal counter mode, q = 0100
After scan load, q = 1010
After one capture clock, q = 1011
Scanned out data = 1011
SCAN CHAIN DEMO PASSED.
```

Meaning:

```text
1. The circuit first works as a normal counter.
2. The testbench shifts 1010 into the scan chain.
3. The circuit captures one normal clock cycle.
4. The captured value is shifted out through scan_out.
```

---

## How to Read the Waveform

Open the scan waveform:

```bash
make wave-scan
```

Important signals:

| Signal | Meaning |
|---|---|
| `clk` | Clock |
| `rst` | Reset |
| `en` | Counter enable |
| `scan_en` | Select normal mode or scan mode |
| `scan_in` | Serial scan input |
| `scan_out` | Serial scan output |
| `q[3:0]` | Internal scan chain state |
| `scanned_data[3:0]` | Data collected from `scan_out` |

Main phases:

```text
scan_en = 0, en = 1 -> normal counter mode
scan_en = 1, en = 0 -> scan load / scan read mode
```

Example:

```text
Scan load:  q[3:0] = 1010
Capture:    q[3:0] = 1011
Scan read:  scanned_data[3:0] = 1011
```

GTKWave may show bus values in hexadecimal:

```text
A = 1010
B = 1011
```

Right-click a bus signal and select:

```text
Data Format -> Binary
```

to view it as binary.

---

## Synthesis

Run:

```bash
make synth-scan
```

Generated file:

```text
netlists/counter_scan_synth.v
```

Check scan-related ports:

```bash
grep scan_en netlists/counter_scan_synth.v
grep scan_in netlists/counter_scan_synth.v
grep scan_out netlists/counter_scan_synth.v
```

---

## Notes

This is a manual educational scan-chain demo.

In real industrial DFT flows, scan insertion is usually performed automatically by EDA tools. This project only focuses on the core concept:

```text
normal flip-flop -> scan flip-flop -> scan chain -> shift in/out test data
```

Not included yet:

```text
ATPG
fault simulation
automatic scan insertion
JTAG
secure scan locking
```

---

## License

This project is licensed under the [Apache License 2.0](LICENSE).