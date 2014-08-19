------------------------------------------------------------------------------
-- @file {{ tb.file_name }}
-- @see {{ dut.name }}
-------------------------------------------------------------------------------


library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity {{ tb.name }} is
end;

architecture testbench of {{ tb.name }} is

   {{ dut.component }}

   {{ dut.signals }}

begin

   {{ dut.instance }}

   stimulus: process
   begin
  
     -- Put initialisation code here


     -- Put test bench stimulus code here

     wait;
   end process;

end;
