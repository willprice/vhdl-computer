
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
- Other registers include:
 - Program Counter
 - Stack Pointer Register
 - Status / Flag Register

The "other" registers will not be accessible directly, but instructions will be able to
access them when being executed. E.g. the conditional branch can access the status 
register.

No. | Prefix | Memonic | Description | Operation | Flags Altered |
----|--------|---------|-------------|-----------|---------------|
0   | 000000 |   -     | Reserved | - | - |
1   | 000001 |   -     | Reserved | - | - |
2   | 000010 |   -     | Reserved | - | - |
3   | 000011 |   -     | Reserved | - | - |
4   | 000100 |   -     | Reserved | - | - |
5   | 000101 |   -     | Reserved | - | - |
6   | 000110 |   -     | Reserved | - | - |
7   | 000111 |   -     | Reserved | - | - |
----|--------|---------|-------------|-----------|---------------|
8   | 001000 |   -     | Reserved | - | - |
9   | 001001 |   -     | Reserved | - | - |
10  | 001010 |   -     | Reserved | - | - |
11  | 001011 |   -     | Reserved | - | - |
12  | 001100 |   -     | Reserved | - | - |
13  | 001101 |   -     | Reserved | - | - |
14  | 001110 |   -     | Reserved | - | - |
15  | 001111 |   -     | Reserved | - | - |
----|--------|---------|-------------|-----------|---------------|
16  | 010000 |   -     | Reserved | - | - |
17  | 010001 |   -     | Reserved | - | - |
18  | 010010 |   -     | Reserved | - | - |
19  | 010011 |   -     | Reserved | - | - |
20  | 010100 |   -     | Reserved | - | - |
21  | 010101 |   -     | Reserved | - | - |
22  | 010110 |   -     | Reserved | - | - |
23  | 010111 |   -     | Reserved | - | - |
----|--------|---------|-------------|-----------|---------------|
24  | 011000 |   -     | Reserved | - | - |
25  | 011001 |   -     | Reserved | - | - |
26  | 011010 |   -     | Reserved | - | - |
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
