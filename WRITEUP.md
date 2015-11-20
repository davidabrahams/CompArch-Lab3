# Lab 3 Write-Up
#### Isaac Getto, David Abrahams, Kai Levy

## CPU Design

![](img/cpu_block_diagram.jpg)

We chose to implement a single cycle CPU design. Our CPU is capable of implementing all required instructions -- `LW, SW, J, JR, JAL, BNE, XORI, ADD, SUB, SLT` -- as well as `BEQ`.

### Instruction RTL

The following is how our CPU implements each instruction. Because our CPU is single-cycle, all instructions are implemented simultaneously (assuming there is no delay between each block):

#### `LW`

* Instr_Register = Instr_Memory[PC]
* PC = PC + 4
* A = Registers[rs]
* Result = A + Sign_Extend(Imm)
* Data_Reg = Data_Memory[Result]
* Registers[rt] = Data_Reg

#### `SW`

* Instr_Register = Instr_Memory[PC]
* PC = PC + 4
* A = Registers[rs]
* B = Registers[rt]
* Result = A + Sign_Extend(Imm)
* Mem[Result] = B

#### `J`

* Instr_Register = Instr_Memory[PC]
* PC = {PC[31:28], Instr_Register[25:0], b00}

#### `JR`

* Instr_Register = Instr_Memory[PC]
* A = Registers[rs]
* PC = A

**** `JAL`

* Instr_Register = Instr_Memory[PC]
* Registers[$ra] = PC + 4
* PC = {PC[31:28], Instr_Register[25:0], b00}

#### `BNE`

* Instr_Register = Instr_Memory[PC]
* A = Registers[rs]
* B = Registers[rt]
* Result = PC + Sign_Extend(Imm)
* if (A!=B) -> PC = Result

#### `BEQ`

* Instr_Register = Instr_Memory[PC]
* PC = PC + 4
* A = Registers[rs]
* B = Registers[rt]
* Result = PC + Sign_Extend(Imm)
* if (A==B) -> PC = Result

#### `ADD`

* Instr_Register = Instr_Memory[PC]
* PC = PC + 4
* A = Registers[rs]
* B = Registers[rt]
* Result = A + B
* RegFile[rd] = Result

#### `SUB`

* Instr_Register = Instr_Memory[PC]
* PC = PC + 4
* A = Registers[rs]
* B = Registers[rt]
* Result = A - B
* RegFile[rd] = Result

#### `SLT`

* Instr_Register = Instr_Memory[PC]
* PC = PC + 4
* A = Registers[rs]
* B = Registers[rt]
* Result = A < B
* RegFile[rd] = Result

## Testing

### Execution
To run a test for a specific module, run

```
CompArch-Lab3$ ./build/moduleToTest
```


To run all module tests, run:

```
CompArch-Lab3$ ./build/alltests
```

Each module test tests all of that module's functionality, and gives an output like this:

```
VCD info: dumpfile build/pc.vcd opened for output.
Testing PC
PC Tests Passed
```

if all functionality works as expected.

In order to test an assembly program, compile it with `MARS`, and dump the raw instructions to a text file. Modify `instructionRegister.v` to load the given textfile and run `./build/cpu` to run the program.

### Strategy
We tested each module in the CPU exhaustively with verilog tests.

Each of the tests for the control table and instruction decoder were simple: give them every possible input and check for every possible output.

For each of the "memory" components (registers, program counter, data memory), we tested by feeding in information and getting it back out.

The multiplexers were tested by feeding in information and checking that each selection worked.

The ALU was tested in the same methodology as in Lab 1, detailed [here](https://github.com/sarahwalters/CompArch-Lab1).

We then tested each CPU for each command separately with assembly code. The test programs are the in `assembly` folder, and were loaded by dumping the commands in binary to the `load` folder, before being loaded into the instruction memory. We checked that our execution yielded the desired results by examining the waveforms.

Finally, we ran the complete assembly tests (our `division.asm` and others) and checked our results with the instructions given in the `README`s.
