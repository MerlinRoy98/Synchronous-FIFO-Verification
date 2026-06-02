# Synchronous-FIFO-Verification

## Design
Parameterized synchronous FIFO (DEPTH=8, DATA_WIDTH=8)
- Circular buffer with read/write pointers
- Full/empty flag generation

## Testbench
Flat SystemVerilog TB with:
- Directed write and read phases
- Queue based scoreboard
- Randomized data

## Results
- 7/7 comparisons passed
- Clean waveform captured in waves/

## Tools
- EDA Playground
- Icarus Verilog 12.0
- EPWave

## Next Steps
- UVM testbench development
- SVA assertions
- Functional coverage
