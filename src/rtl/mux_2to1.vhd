------------------------------------------------------------------------------
-- @file mux_2to1.vhd
-- @brief Simple implementation of a generic multiplexer that can be
--          easily scaled using the port generics.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

library work; 
use work.common_types.all;

entity mux_2to1 is
   generic (
      PORT_WIDTH   : in integer := 1
   );
   port(
      input_0 : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
      input_1 : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
      sel     : in  std_logic;
      output  : out std_logic_vector(PORT_WIDTH - 1 downto 0)
   );
end entity mux_2to1;

architecture behav of mux_2to1 is
begin

   assign_output : process (sel, input_0, input_1)
   begin
      if(sel = '0') then
         output <= input_0;
      else
         output <= input_1;
      end if;
   end process;

end architecture behav;