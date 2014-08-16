
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

Instruction Set Summary
-------------------------------------------------------------------------------

No. | Prefix | Memonic | Description | Operation | Flags Altered |
----|--------|---------|-------------|-----------|---------------|
0   | 000000 | BLSLI   | Logical Shift Left With Immediate | - | - |
1   | 000001 | BLSLR   | Logical Shift Left With Register | - | - |
2   | 000010 | BLSRI   | Logical Shift Right with Immediate | - | - |
3   | 000011 | BLSRR   | Logical Shift Right with register | - | - |
4   | 000100 | BANDI   | Bitwise AND with immediate | - | - |
5   | 000101 | BANDR   | Bitwise AND with register | - | - |
6   | 000110 | BNADI   | Bitwise NAND with immediate | - | - |
7   | 000111 | BNADR   | Bitwise NAND with Register | - | - |
8   | 001000 | BIORI   | Bitwise Inclusive OR with immediate | - | - |
9   | 001001 | BIORR   | Bitwise Inclusive OR with Register | - | - |
10  | 001010 | BNORI   | Bitwise NOR with immediate | - | - |
11  | 001011 | BNORR   | Bitwise NOR with Register | - | - |
12  | 001100 | BXORI   | Bitwise XOR with immediate | - | - |
13  | 001101 | BXORR   | Bitwise XOR with Register | - | - |
14  | 001110 | BNOTR   | Bitwise NOT | - | - |
----|--------|---------|-------------|-----------|---------------|
15  | 001111 | AASLI   | Arithmetic Shift Left with Immediate | - | - |
16  | 010000 | AASLR   | Arithmetic Shift Left with Register | - | - |
17  | 010001 | AASRI   | Arithmetic Shift Right with Immediate | - | - |
18  | 010010 | AASRR   | Arithmetic Shift Right with Register | - | - |
19  | 010011 | AADDI   | Add with immediate | - | - |
20  | 010100 | AADDR   | Add with register | - | - |
21  | 010101 | ASUBI   | Subtract with Immediate | - | - |
22  | 010110 | ASUBR   | Subtract with Register | - | - |
23  | 010111 | AMULI   | Multiply with immediate | - | - |
24  | 011000 | AMULR   | Multiply with Register | - | - |
25  | 011001 | ADIVI   | Divide with immediate | - | - |
26  | 011010 | ADIVR   | Divide with register | - | - |
----|--------|---------|-------------|-----------|---------------|
27  | 011011 |   -     | Reserved | - | - |
28  | 011100 |   -     | Reserved | - | - |
29  | 011101 |   -     | Reserved | - | - |
30  | 011110 |   -     | Reserved | - | - |
31  | 011111 |   -     | Reserved | - | - |
----|--------|---------|-------------|-----------|---------------|
32  | 100000 |   -     | Reserved | - | - |
33  | 100001 |   -     | Reserved | - | - |
34  | 100010 |   -     | Reserved | - | - |
35  | 100011 |   -     | Reserved | - | - |
36  | 100100 |   -     | Reserved | - | - |
37  | 100101 |   -     | Reserved | - | - |
38  | 100110 |   -     | Reserved | - | - |
39  | 100111 |   -     | Reserved | - | - |
----|--------|---------|-------------|-----------|---------------|
40  | 101000 |   -     | Reserved | - | - |
41  | 101001 |   -     | Reserved | - | - |
42  | 101010 |   -     | Reserved | - | - |
43  | 101011 |   -     | Reserved | - | - |
44  | 101100 |   -     | Reserved | - | - |
45  | 101101 |   -     | Reserved | - | - |
46  | 101110 |   -     | Reserved | - | - |
47  | 101111 |   -     | Reserved | - | - |
----|--------|---------|-------------|-----------|---------------|
48  | 110000 |   -     | Reserved | - | - |
49  | 110001 |   -     | Reserved | - | - |
50  | 110010 |   -     | Reserved | - | - |
51  | 110011 |   -     | Reserved | - | - |
52  | 110100 |   -     | Reserved | - | - |
53  | 110101 |   -     | Reserved | - | - |
54  | 110110 |   -     | Reserved | - | - |
55  | 110111 |   -     | Reserved | - | - |
----|--------|---------|-------------|-----------|---------------|
56  | 111000 |   -     | Reserved | - | - |
57  | 111001 |   -     | Reserved | - | - |
58  | 111010 |   -     | Reserved | - | - |
59  | 111011 |   -     | Reserved | - | - |
60  | 111100 |   -     | Reserved | - | - |
61  | 111101 |   -     | Reserved | - | - |
62  | 111110 |   -     | Reserved | - | - |
63  | 111111 |   -     | Reserved | - | - |