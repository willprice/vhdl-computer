--------------------------------------------------------------------------------
-- @file mux_4to1_tb.vhd
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mux_4to1_tb is
end;

architecture testbench of mux_4to1_tb is

   -- DUT COMPONENT DECLARATION
   component mux_4to1 is
      generic (
         PORT_WIDTH : in natural := 1
      );
      port(
         in_0  : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
         in_1  : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
         in_2  : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
         in_3  : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
         sel   : in  std_logic_vector(1 downto 0);
         output: out std_logic_vector(PORT_WIDTH - 1 downto 0)
      );
   end component mux_4to1;

   -- SIGNALS FOR DUT I/O GO HERE

begin

   -- DUT INSTANCE GOES HERE

   stimulus: process
   begin
  
     -- Put initialisation code here


     -- Put test bench stimulus code here

     wait;
   end process;

end;