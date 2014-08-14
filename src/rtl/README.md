
 RTL Source Code
================================================================================

This folder contains all hardware description code and register transfer level
logic that will form the logic of the CPU.

It should not contain any files generated by build systems. Ideally they should
all end up in [project root]/work

 Code Conventions
-------------------------------------------------------------------------------  

VHDL is not case sensitive, however all code should be in lower case and use
underscores as spaces.

Naming conventions for modules are:

```
function_type_subtype
```

For example:

```
register_shift
adder_signed_lookahead
mux
register
```

 Module List
--------------------------------------------------------------------------------

This is a list of all RTL modules that are present within this source folder,
along with the current status of their implementation.


| Module Name | Port Declarations | RTL Implemented  | Verified |
|-------------|-------------------|------------------|----------|
| adder_signed | no  | no  | no |
| mux_2bit   | no  | no  | no |
| ff_dtype  | no  | no  | no |
| ff_jk     |  no |  no | no |
|           |     |     |    |
| Please add more below | - | - | no |


Please try to keep this table up to date!
