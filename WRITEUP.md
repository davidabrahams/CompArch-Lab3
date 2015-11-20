# Lab 3 Write-Up
#### Isaac Getto, David Abrahams, Kai Levy

## CPU Design

![](img/cpu_block_diagram.jpg)

We chose to implement a single cycle CPU design. Our CPU is capable of implementing all required instructions -- `LW, SW, J, JR, JAL, BNE, XORI, ADD, SUB, SLT` -- as well as `BEQ`.

### Explanation of high-level design

Every instruction's RTL requires adding to the program counter, so on the left we have a `PC` block whose output goes into an adder, which adds either `4` or the Branch amount. This value is fed back into a mux that sets the `PC` to either the incremented value of `PC`, a jump value, or the data stored in a register.

We fetch the current instruction from Instruction Memory and then decode it using the `IR` block. These registers are fed into the Registers module, which fetches the value at two registers and writes to a third, if `WrEn=1`. We write either `PC+4` for a `JAL`, the value stored at in memory at register `rs` for a `LW`, or value coming off of our `ALU` for any of the math instructions.

The ALU takes in the values stored at register `rt` and the value at `rs`, or the sign extended immediate if we are doing a `LW` or `SW`. The ALU output is fed to the Data Memory address (because addresses are computed) and the data write of the register.

These components allow us to implement all of the following RTL:

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

### Verilog Testing and Execution
To run a test for a specific module, run

```
CompArch-Lab3$ ./build/moduleToTest
```


To run all module tests, run:

```
./build/alltests
```

Each module test tests all of that module's functionality, and gives an output like this:

```
VCD info: dumpfile build/pc.vcd opened for output.
Testing PC
PC Tests Passed
```

if all functionality works as expected.

#### The ALU

```
CompArch-Lab3$ ./build/alu
```

The ALU tests do three tests of addition and subtraction, testing different combinations of carryout, overflow, and negative and positive operands. Similarly we test SLT with three sets of input to ensure our SLT works for every combination of negative and positive numbers. Finally, we test all simple logic (NOR, NAND, etc).

#### The Clock

```
CompArch-Lab3$ ./build/clock
```

The clock tests simply tests that the clock is switching on and off at the expected frequency at many different time points.

#### The Control Table

```
CompArch-Lab3$ ./build/controlTable
```

The control table sets all control signals in our top level cpu module. The tests give the control table every single `op` and `funct` code, and tests that the control signals are set appropriately.

#### The Data Memory

```
CompArch-Lab3$ ./build/datamemory
```

The datamemory can both read data from a given address, or write data to a given address. Our tests test both read and write capabilities at different addresses, and ensure that our memory is persistant between calls.

#### The Instruction Decoder

```
CompArch-Lab3$ ./build/instructionDecoder
```

The Instruction Decoder takes in takes in a 32-bit instruction and outputs the correct registers, immediate, and `funct` code. The tests give the decoder a series of instructions and checks that the outputs are what we expect.

#### The Multiplexer

```
CompArch-Lab3$ ./build/multiplexer
```

We have 2, 4, and 8 input multiplexers. The tests give the multiplexers a series of inputs and then address into different values, and check the output.

#### The Program Counter

```
CompArch-Lab3$ ./build/pc
```

The PC simply sets the PC to its input on positive clock edges. The tests check that the PC is being set properly and at the right time.

#### The Registers

```
CompArch-Lab3$ ./build/registers
```

The register holds 32 data values in registers, and sets certain registers (like the zeor register) to predefined values. On positive clock edges the register sets the output data values to the data contained in the registers, and writes to the write-register if write is enabled.

The tests test both the input and output functionality of the registers. We write to registers and then read from them.

### Assembly Tests

In order to test an assembly program, compile it with `MARS`, and dump the raw instructions to a text file. Modify `instructionRegister.v` to load the given textfile and run `$ ./build/cpu` to run the program.

### Testing Strategy
We tested each module in the CPU exhaustively with verilog tests.

Each of the tests for the control table and instruction decoder were simple: give them every possible input and check for every possible output.

For each of the "memory" components (registers, program counter, data memory), we tested by feeding in information and getting it back out.

The multiplexers were tested by feeding in information and checking that each selection worked.

The ALU was tested in the same methodology as in Lab 1, detailed [here](https://github.com/sarahwalters/CompArch-Lab1).

We then tested each CPU for each command separately with assembly code. The test programs are the in `assembly` folder, and were loaded by dumping the commands in binary to the `load` folder, before being loaded into the instruction memory. We checked that our execution yielded the desired results by examining the waveforms.

Finally, we ran the complete assembly tests (our `division.asm` and others) and checked our results with the instructions given in the `README`s.

### Area Analysis

We have chosen to describe the size of our CPU by calculating the total number of fundamental gates used in the design. We define the size of the two input logic gates as follows.

| Gate | Size |
|:----:|:----:|
| NOT  |  1   |
| NAND |  2   |
| NOR  |  2   |
| XNOR |  2   |
| AND  |  3   |
| OR   |  3   |
| XOR  |  3   |

The `AND`, `OR`, and `XOR` gates are made using their negative couterpart gate and a `NOT` gate. Using these values we can determine the size of each component.

#### Program Counter

The program counter holds a 32 bit address that signifies the location of the current instruction. At each the positive edge of each clock cycle, the input is propogated through as the new output. We estimate that the program counter requires the following subcomponents.

| Subcomponent | Quantity | Unit Size | Total Size |
|:------------:|:--------:|:---------:|:----------:|
| D Flip Flop  |    32    |     9     |    288     |
|              |          |           |    288     |

#### Adder

In order to increment the program counter after each cycle, an adder is used. This adder must be able to handle unsigned 32 bit additions. The table below shows the estimated cost.

| Subcomponent     | Quantity | Unit Size | Total Size |
|:----------------:|:--------:|:---------:|:----------:|
| 1 Bit Full Adder |    32    |    15     |    480     |
|                  |          |           |    480     |

#### Instruction Memory

The instruction memory is able to store program operations. Each instruction requires 32 bits of space. Based on the input address supplied, a corresponding instruction will be output at the positive edge of each clock cycle. We estimate the size of this component as follows.

| Subcomponent            | Quantity | Unit Size | Total Size |
|:-----------------------:|:--------:|:---------:|:----------:|
| D Flip Flop with Enable |  32,768  |    11     |   360,448  |
| 1024 Option Mux         |  32      |  34,813   |  1,113,002 |
|                         |          |           |  1,473,450 |

#### Instruction Decoder

The instruction decoder breaks up the 32 bit instruction into its individual parts. This is done simply with wires and requires no gates.


#### Sign Extender

The sign extender converts a signed 16 bit immediate into a signed 32 bit number. This is simply done by wiring the most significant bit of the 16 bit number to the top 16 bits of the 32 bit instruction. The rest of the bits are wired to the same location in the new number. This requires no gates.


#### Concatenator

The concatenator merges three values into a single 32 bit value. This is simply done by wiring the inputs into the output. This requires no gates.


#### Registers

The register file is similar to the instruction memory. The registers support writing to one of the 32 locations at a time and reading from two different address simultaneously. The estimated size is as follows.

| Subcomponent            | Quantity | Unit Size | Total Size |
|:-----------------------:|:--------:|:---------:|:----------:|
| D Flip Flop with Enable |  1024    |    11     |   11,264   |
| 32 Option Mux           |  64      |  605      |  38,693    |
|                         |          |           |  49,957    |


#### Data Memory

The data memory is exactly the same as the instruction memory, except that it holds data values rather than instructions. The sizing is the same.

| Subcomponent            | Quantity | Unit Size | Total Size |
|:-----------------------:|:--------:|:---------:|:----------:|
| D Flip Flop with Enable |  32,768  |    11     |   360,448  |
| 1024 Option Mux         |  32      |  34,813   |  1,113,002 |
|                         |          |           |  1,473,450 |

#### ALU

The ALU allows the CPU to compute mathematical operations. This component operates on 32 bit operands. The table below describes its size.

| Subcomponent | Quantity | Unit Size | Total Size |
|:------------:|:--------:|:---------:|:----------:|
| Bit Slice    |  32      |    197    |   6,304     |
| NOT Gate     |  5       |    1      |   5        |
| XNOR Gate    |  2       |    2      |   4        |
| AND Gate     |  11      |    3      |   33       |
| OR Gate      |  1       |    3      |   3        |
| NOR Gate     |  32      |    2      |   64       |
|              |          |           |  6,413      |

#### Additional Components

The following components are used within the cpu, outside of any other subcomponent.

| Subcomponent | Quantity | Unit Size | Total Size |
|:------------:|:--------:|:---------:|:----------:|
| AND Gate     |  11      |    3      |   33       |
| OR Gate      |  1       |    3      |   3        |
|              |          |           |  36        |

#### Total

The grand total size is calculated in the following table.

| Subcomponent       | Quantity | Unit Size    | Total Size  |
|:------------------:|:--------:|:------------:|:-----------:|
| Adder              |  1       |    480       |   480       |
| Program Counter    |  1       |    288       |   288       |
| Instruction Memory |  1       |   1,473,450  |   1,473,450 |
| Registers          |  1       |    49,957    |   49,957    |
| Data Memory        |  1       |    1,473,450 |   1,473,450 |
| ALU                |  1       |    6,413     |   6,413     |
| AND Gate           |  11      |    3         |   33        |
| OR Gate            |  1       |    3         |   3         |
|                    |          |              |   3,004,074 |
