
   VHDL Computer Architecture - Design Choices
===============================================================================

  This document outlines some of the top level design choices to be made in
chosing the main architecture of the machine.

 Core Architecture
-------------------------------------------------------------------------------

- ~~Harvard~~
- Von Neuman


 A Von Neuman architecture will be easier to implement and allow for more 
flexibility within the software.


Machine Type
-------------------------------------------------------------------------------

  This will essentiall define how we structure the instruction set, along with
how complicated the instruction decode pipeline will be. A larger instruction
set will make programs smaller - important considering the limited memory
available on the papillio board we will be implementing this on.

Considered Options:

- Stack Machine
   - This would basically limit us to a RISC style architecture. Pro`s are
   a simpler fetch decode execte (FDE) pipeline and consequently a far
   smaller gate count leaving chip area available for fancy IO controllers
   for peripherals.
   - Cons would be larger program size in memory since more instructions will
   be required for even the most basic of tasks.

- Register Machine
   - Flexible RISC or CISC capability.
   - Given available gate count RISC architecture will be nessecery anyway.
   - This would be a far more flexible architecture to use. We can implement
   a stack machine over a register machine. It also allows us to keep the
   instruction count down in the programs.
   - Registers will be complex and have a high gate count so we can expect this
   machine to have a larger area requirement.

Main Design Constraints:
-------------------------------------------------------------------------------

- Gate/Area Count
  We have a finite number of gates/logic slices available that we
  absoloutely cannot go over. Hence we will be looking for compact
  implementations of functionality for the core CPU.

- Memory Size
  The papilio has two main banks of memory accessible from the FGPA logic:
  - 64Mbit Micron MT48LC4M16 SDRAM
  - 64Mbit Macronix MX25L6445 SPI Flash
  Logically we will use the FLASH as non-volatile storage and the SDRAM as
  main program and data memory. Although we can add on IO interfaces for
  extra memory we should aim to have the core OS or program code able to
  operate withing the 64MB memory space. Hence we will need to make sure the
  instruction set allows programs to be as compact as possible without pushing
  up the area cost.
  There is also 64K of SRAM built into the SPARTAN6 FPGA. This will be the
  shockingly fast memory and could act as either very fast program memory
  or the basis of a very simple cache.
