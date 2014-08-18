--------------------------------------------------------------------------------
-- @file ff_dtype_tb.vhd
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ff_dtype_tb is
end entity ff_dtype_tb;

architecture testbench of ff_dtype_tb is

   component ff_dtype is
      port(
         clk    : in std_logic;
         data   : in std_logic;
         reset  : in std_logic;
         q      : buffer std_logic;
         not_q  : buffer std_logic
      );
   end component ff_dtype;

   signal sig_q : std_logic := '0';
   signal sig_not_q : std_logic := '1';
   signal sig_clk : std_logic := '0';
   signal sig_data : std_logic := '0';
   signal sig_reset : std_logic := '1';

begin

   sig_clk <= not sig_clk after 20 ns;
   sig_reset <= '0' after 5 ns;
   sig_data <= not sig_data after 13 ns;

   DUT : ff_dtype port map(
      q => sig_q,
      not_q => sig_not_q,
      clk => sig_clk,
      data => sig_data,
      reset => sig_reset
   );
   
   
   test_q_is_low_under_reset: process
   begin
      wait until rising_edge(sig_reset);
      assert (sig_q = '0') report "Q is not zero under reset conditions" severity error;
   end process;

   test_q_is_equal_to_data: process
   begin 
      wait until sig_clk'event and sig_reset='0';
      wait for 1 ps;
      assert (sig_data = sig_q) report "Q is not equal to sig_data." severity error;
   end process; 

   test_q_never_equals_not_q: process(sig_q, sig_not_q)
   begin
      if(sig_reset = '0') then
         assert (sig_q /= sig_not_q) report "Q and Q_BAR are equal." severity error;
      end if;
   end process;

end architecture testbench;