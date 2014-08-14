------------------------------------------------------------------------------
-- @file mux.vhd
-- @brief Simple implementation of a generic 2 to 1 multiplexer that can be
--          easily scaled using the port generics.
-- @detais <TO ADD>
-------------------------------------------------------------------------------

-- import std_logic from the IEEE library. Should be done for ALL VHDL files.
library IEEE;
use IEEE.std_logic_1164.all;

-- Module Entity Declaration
entity mux is
   generic (
      PORT_WIDTH : in natural := 1
   );
   port(
      in_a  : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
      in_b  : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
      sel   : in  std_logic;
      output: out std_logic_vector(PORT_WIDTH - 1 downto 0)
   );
end entity mux;

-- Module Architecture
architecture arch_rtl of mux is
begin

   assign_output : process (sel, in_a, in_b)
   begin
      case sel is
         when '0' => output <= in_a;
         when '1' => output <= in_b;
         when others => output <= in_a;
      end case;
   end process;

end architecture arch_rtl;
