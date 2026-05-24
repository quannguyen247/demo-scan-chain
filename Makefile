.PHONY: help sim wave synth sim-scan wave-scan synth-scan clean

help:
	@echo "Available commands:"
	@echo "- make sim: Run normal counter simulation"
	@echo "- make wave: Open normal counter waveform"
	@echo "- make synth: Run normal counter synthesis"
	@echo "- make sim-scan: Run scan chain simulation"
	@echo "- make wave-scan: Open scan chain waveform"
	@echo "- make synth-scan: Run scan chain synthesis"
	@echo "- make clean: Remove compiled simulation binaries"

sim:
	mkdir -p results
	iverilog -o results/counter_tb tb/counter_tb.v rtl/counter.v
	vvp results/counter_tb

wave:
	gtkwave results/counter.vcd

synth:
	mkdir -p netlists
	yosys -p "read_verilog rtl/counter.v; synth -top counter; write_verilog -noattr netlists/counter_synth.v"

sim-scan:
	mkdir -p results
	iverilog -o results/counter_scan_tb tb/counter_scan_tb.v rtl/scan_dff.v rtl/counter_scan.v
	vvp results/counter_scan_tb

wave-scan:
	gtkwave results/counter_scan.vcd

synth-scan:
	mkdir -p netlists
	yosys -p "read_verilog rtl/scan_dff.v rtl/counter_scan.v; synth -top counter_scan; write_verilog -noattr netlists/counter_scan_synth.v"

clean:
	rm -rf results/* netlists/*