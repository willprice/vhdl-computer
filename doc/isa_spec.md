
Instruction Set Specification [Preliminary]
===============================================================================

This document outlines the preliminary instruction set our computer will use
and the CPU will implement.

It will be a very simple register machine target using a barebones reduced
instruction set.

The main design choices are:
- 32bit word length
- Variable instruction code length. Remaining bits made available for
  embedding data and arguments within the instructions.
- 5 bits of op code leaving the rest free for data and arguments?
- **Need to decide how many registers a core will have etc**

Logical Operations
-------------------------------------------------------------------------------
- Logical Shift Left (LSL)
- Logical Shift Right (LSR)
- AND
- OR
- XOR
- NOT
- NAND
- NOR

Register / Memory Operations
--------------------------------------------------------------------------------
- LOAD Immediate
- LOAD Absoloute (Register)
- LOAD With Offset
- STORE Immediate
- STORE Absoloute (Register)
- STORE With Offset

Arithmetic Operations
-------------------------------------------------------------------------------
- ADD
- SUB
- MUL
- DIV (Can we get away with only supporting this in software?) NO!
- Arithmetic Shift Left
- Arithmetic Shift Right

Control Flow Operations
-------------------------------------------------------------------------------
- Branch
- Conditional Branch
- Return (Pop Program Counter)
- Call (Push Program Counter)

Special Operations
-------------------------------------------------------------------------------
- HALT
