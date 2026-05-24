.DEFAULT_GOAL := help
.PHONY: help sim wave synth clean

help:
	@echo "Available commands:"
	@echo "- make sim: Run RTL simulation"
	@echo "- make wave: Open waveform"
	@echo "- make synth: Run Yosys synthesis"
	@echo "- make clean: Remove generated files"

sim:
	mkdir -p results
	iverilog -o results/counter_tb tb/counter_tb.v rtl/counter.v
	vvp results/counter_tb

wave:
	gtkwave results/counter.vcd

synth:
	mkdir -p netlists
	yosys -p "read_verilog rtl/counter.v; synth -top counter; write_verilog -noattr netlists/counter_synth.v"

clean:
	rm -rf results/* netlists/*