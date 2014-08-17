------------------------------------------------------------------------------
-- @file mux.vhd
-- @brief Simple implementation of a generic multiplexer that can be
--          easily scaled using the port generics.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

library work; 
use work.common_types.all;

entity mux is
   generic (
      PORT_WIDTH   : in integer := 8;
      SELECT_WIDTH : in integer := 1;
      NUM_INPUTS   : in integer := 2
   );
   port(
      inputs  : in VEC_ARRAY(0 to NUM_INPUTS -1);
      sel     : in  std_logic_vector(SELECT_WIDTH-1 downto 0);
      output  : out std_logic_vector(PORT_WIDTH - 1 downto 0)
   );
end entity mux;

architecture arch_behav of mux is
begin

   assign_output : process (sel, inputs)
   begin
     output <= inputs(CONV_INTEGER(sel));
   end process;

end architecture arch_behav;
