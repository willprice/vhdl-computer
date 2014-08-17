------------------------------------------------------------------------------
-- @file ff_dtype.vhd
-- @brief Implements a simple dtype flipflop
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

--
-- @details On the rising edge of clk, whatever value present on data is reflected on
-- q, while its inverse is refelected on not_q.
-- if reset is high then q is put low. reset is asynchronous.
--
entity ff_dtype is
   port(
      clk    : in std_logic;
      data   : in std_logic;
      reset  : in std_logic;
      q      : buffer std_logic;
      not_q  : buffer std_logic
   );
end entity ff_dtype;

architecture rtl of ff_dtype is
begin
  
   -- @details
   -- This process is responsible for the updating of the output's q and not_q based
   -- on rising edge clock events and asynchonous reset.
   update_output : process(clk, reset)
   begin
      if(reset = '1') then
         q     <= '0';
         not_q <= '1';
      elsif (rising_edge(clk)) then
         q     <= data;
         not_q <= not data;
      else 
         q <= q;
         not_q <= not_q;
      end if;
   end process;

end architecture rtl;