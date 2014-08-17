------------------------------------------------------------------------------
-- @file ff_jk.vhd
-- @brief Implements a simple jk flip flop module
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

--
-- @details
-- On the rising edge of the clock, q and not_q are set depending on the status of
-- inputs j and k
--
entity ff_jk is
   port( 
      clk    : in     std_logic;
      j      : in     std_logic;
      k      : in     std_logic;
      q      : buffer std_logic;
      not_q  : out    std_logic
   );
end entity ff_jk;

architecture rtl of ff_jk is
begin
   
   update_output : process(clk, j, k)
   begin
      if(rising_edge(clk)) then
         q     <= (j and not q) or (not k and q);
         not_q <= not q;
      end if;
   end process;

end architecture rtl;