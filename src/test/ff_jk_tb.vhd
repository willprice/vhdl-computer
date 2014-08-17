-- Generated automatically with tbgen.py
-- ff_jk_tb.vhd
-- @brief
--

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ff_jk_tb is
end;

architecture testbench of ff_jk_tb is

   -- DUT COMPONENT DECLARATION
   component ff_jk is
      port( 
         clk    : in     std_logic;
         j      : in     std_logic;
         k      : in     std_logic;
         q      : buffer std_logic;
         not_q  : out    std_logic
      );
   end component ff_jk;

   -- SIGNALS FOR DUT I/O GO HERE
   $dut_signals$

begin

   -- DUT INSTANCE GOES HERE
   $dut_instance$

   stimulus: process
   begin
  
     -- Put initialisation code here


     -- Put test bench stimulus code here

     wait;
   end process;

end;