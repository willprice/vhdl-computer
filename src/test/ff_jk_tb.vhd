--------------------------------------------------------------------------------
-- @file ff_jk_tb.vhd
--------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ff_jk_tb is
end;

architecture testbench of ff_jk_tb is

   component ff_jk is
      port( 
         clk    : in     std_logic;
         j      : in     std_logic;
         k      : in     std_logic;
         q      : buffer std_logic;
         not_q  : out    std_logic
      );
   end component ff_jk;

   signal clk   : std_logic;
   signal j     : std_logic;
   signal k     : std_logic;
   signal q     : std_logic;
   signal not_q : std_logic;

begin

   DUT : ff_jk port map(
      clk => clk,
      j => j,
      k => k,
      q => q,
      not_q => not_q
   );


   test_hold_state_does_not_invoke_a_change: process(clk)
   begin
      j <= '0';
      k <= '0';
   end process;

end;