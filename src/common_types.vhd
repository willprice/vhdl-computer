--
-- This is the common package file.
-- All common types, constants etc go in here.
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

package common_types is

   type VEC_ARRAY is array(integer range <>) of std_logic_vector(7 downto 0);

end package;
