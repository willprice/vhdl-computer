------------------------------------------------------------------------------
-- @file mux_4to1.vhd
-- @brief Simple implementation of a generic 4 to 1 multiplexer that can be
--          easily scaled using the port generics.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_4to1 is
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
end entity mux_4to1;

architecture arch_rtl of mux_4to1 is
begin

   assign_output : process (sel, in_0, in_1, in_2, in_3)
   begin
      case sel is
         when "00" => output <= in_0;
         when "01" => output <= in_1;
         when "10" => output <= in_2;
         when "11" => output <= in_3;
         when others => output <= in_0;
      end case;
   end process;

end architecture arch_rtl;
