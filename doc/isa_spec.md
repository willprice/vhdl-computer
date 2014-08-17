
Instruction Set Specification [Preliminary]
===============================================================================

This document outlines the preliminary instruction set our computer will use
and the CPU will implement.

It will be a very simple register machine target using a barebones reduced
instruction set.

The main design choices are:
- 32bit word length
- 6 bits of op code which gives a maximum instruction set size of 64. 
- We will use 8 General Purpose Registers.
  Hence there will usually be 2 register arguments per instruction of 3 bits each.
- Other registers include:
 - Program Counter
 - Stack Pointer Register
 - Status / Flag Register
 - Link Register
 - Execution Permissions Registers
- This leaves 26 bits for other purposes. If we have 32bit wide words then with the 64M 
  of flash storage we have, we will need `log_2(64*1024*1024/32) == 21` bits, leaving 5
  over for other things like reg address, is this sufficient enough bits left over, or 
  should we cut the amount of storage that we can address? 
- Why have we chosen 32bit word length? What are the technical limitations that stop us 
  from having a longer word length?
- Are we assuming word length of memory == word length of instruction? (this will make
  decoding easier)

The "other" registers will not be accessible directly, but instructions will be able to
access them when being executed. E.g. the conditional branch can access the status 
register.

Status Flags
-------------------------------------------------------------------------------

The status register will be a 32 bit register automatically updated after every
instruction.

Bit | Flag | Function
----|------|-------------------------------------------------------------------
0   | N    | Negative Flag - The result of the previous operation was negative.
1   | Z    | Zero Flag - The result of the previous operation was zero.
2   | O    | Overflow - The previous operation caused an Overflow in the ALU
3   | L    | Less than Flag
4   | E    | Equal Flag
5   | S    | Supervisor Flag - The currently executing code has enhanced privilidges
6-31| -    | Reserved

Other flags will be added as functionality is required.


Instruction Set Summary
-------------------------------------------------------------------------------

Note: Instructions marked with a * next to their memonic support conditional execution
through the *with mask* feature. This is described in footnote [1].

No. | Prefix | Memonic | Description | Flags Altered |
----|--------|---------|-------------|---------------|
0   | 000000 | BLSLI   | Logical Shift Left With Immediate  | N Z O L E S |
1   | 000001 | BLSLR*  | Logical Shift Left With Register  | N Z O L E S  |
2   | 000010 | BLSRI   | Logical Shift Right with Immediate  | N Z O L E S  |
3   | 000011 | BLSRR*  | Logical Shift Right with register  | N Z O L E S  |
4   | 000100 | BANDI   | Bitwise AND with immediate  | N Z O L E S  |
5   | 000101 | BANDR*  | Bitwise AND with register  | N Z O L E S  |
6   | 000110 | BNADI   | Bitwise NAND with immediate  | N Z O L E S  |
7   | 000111 | BNADR*  | Bitwise NAND with Register  | N Z O L E S  |
8   | 001000 | BIORI   | Bitwise Inclusive OR with immediate | N Z O L E S  |
9   | 001001 | BIORR*  | Bitwise Inclusive OR with Register | N Z O L E S  |
10  | 001010 | BNORI   | Bitwise NOR with immediate | N Z O L E S  |
11  | 001011 | BNORR*  | Bitwise NOR with Register | N Z O L E S  |
12  | 001100 | BXORI   | Bitwise XOR with immediate | N Z O L E S  |
13  | 001101 | BXORR*  | Bitwise XOR with Register | N Z O L E S  |
14  | 001110 | BNOTR*  | Bitwise NOT | N Z O L E S  |
----|--------|---------|-------------|----|
15  | 001111 | AASLI   | Arithmetic Shift Left with Immediate | N Z O L E S  |
16  | 010000 | AASLR*  | Arithmetic Shift Left with Register | N Z O L E S  |
17  | 010001 | AASRI   | Arithmetic Shift Right with Immediate | N Z O L E S  |
18  | 010010 | AASRR*  | Arithmetic Shift Right with Register | N Z O L E S  |
19  | 010011 | AADDI   | Add with immediate | N Z O L E S  |
20  | 010100 | AADDR*  | Add with register | N Z O L E S  |
21  | 010101 | ASUBI   | Subtract with Immediate | N Z O L E S  |
22  | 010110 | ASUBR*  | Subtract with Register | N Z O L E S  |
23  | 010111 | AMULI   | Multiply with immediate | N Z O L E S  |
24  | 011000 | AMULR*  | Multiply with Register | N Z O L E S  |
25  | 011001 | ADIVI   | Divide with immediate | N Z O L E S  |
26  | 011010 | ADIVR*  | Divide with register | N Z O L E S  |
----|--------|---------|-------------|----|
27  | 011011 | MLRFI   | Load Register From Immediate| N Z O L E S  |
28  | 011100 | MLIRO   | Load Register From Immediate With Register offset | N Z O L E S  |
29  | 011101 | MLRRO*  | Load Register From Register with register offset |  N Z O L E S |
30  | 011110 | MSRAI   | Store Register At Immediate | N Z O L E S  |
31  | 011111 | MSIRO   | Store Register At Immediate With Register offset | N Z O L E S  |
32  | 100000 | MSRRO*  | Store Register At Register with Register offset | N Z O L E S  |
----|--------|---------|-------------|----|
33  | 100001 | BRANI   | Branch to immediate address specified in instruction | N Z O L E S  |
34  | 100010 | BRANR*  | Branch to address stored in register | N Z O L E S  |
35  | 100011 | BRWMI   | Branch with mask to immediate address | N Z O L E S  |
36  | 100100 | CALLR*  | Calls Subroutine which starts at address in register. Pushes the PC into the link register.| N Z O L E S | 
37  | 100101 | CARET*  | Call Return. Return from a subroutine. | N Z O L E S |
38  | 100110 | - | - | 
----|--------|---------|-------------|----|
39  | 100111 | STPSH*  | Push Register to the stack. | N Z O L E S  |
40  | 101000 | STPOP*  | Pop to register from the stack. | N Z O L E S  |
41  | 101001 | STKLD*  | Load the stack register into a gp register. | N Z O L E S  |
----|--------|---------|-------------|----|
42  | 101010 |   -     | Reserved | - |
43  | 101011 |   -     | Reserved | - |
44  | 101100 |   -     | Reserved | - |
45  | 101101 |   -     | Reserved | - |
46  | 101110 |   -     | Reserved | - |
47  | 101111 |   -     | Reserved | - |
----|--------|---------|-------------|-----|
48  | 110000 |   -     | Reserved | - |
49  | 110001 |   -     | Reserved | - |
50  | 110010 |   -     | Reserved | - |
51  | 110011 |   -     | Reserved | - |
52  | 110100 |   -     | Reserved | - |
53  | 110101 |   -     | Reserved | - |
54  | 110110 |   -     | Reserved | - |
55  | 110111 |   -     | Reserved | - |
----|--------|---------|-------------|-----|
56  | 111000 |   -     | Reserved | - |
57  | 111001 |   -     | Reserved | - |
58  | 111010 |   -     | Reserved | - |
59  | 111011 |   -     | Reserved | - |
60  | 111100 |   -     | Reserved | - |
61  | 111101 |   -     | Reserved | - |
62  | 111110 |   -     | Reserved | - |
63  | 111111 |   -     | Reserved | - |

***

[1] - With Mask Instructions
-------------------------------------------------------------------------------

All instructions which have enough space left in their word bits after the essential
opcode and arguments support conditional execution. This is done using the *with mask*
feature.

In each instruction supporting this, 6 bits of the instruction word are set asside as
mask bits. These bits are used to mask the lower 6 bits of the status register. If the
result of the mask operation is zero then the instruciton is treated as a NOP and 
execution continues as per normal. If the result of the mask is anything other than zero
then the instruction is executed in the normal manner.

Inclusion of the bit mask means that we can utilize complex conditional execution in
a large number of instructions very simply. This drastically reduces the number of
required instructions and allows for a far smaller and simpler decode pipeline while
not sacrificing functionality.

