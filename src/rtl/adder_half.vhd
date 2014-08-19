------------------------------------------------------------------------------
-- @file adder_half.vhd
-- @brief Implementes a simple 1 bit half adder that can be used to make full
-- adders and vector adders.
-- @see adder_full_tb
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

--
-- Computes the sum and carry bit for two input bits.
--
entity adder_half is
   port(
        in_0        : in std_logic;
        in_1        : in std_logic;
        sum         : out std_logic;
        carry_out   : out std_logic
   );
end entity adder_half;

architecture rtl of adder_half is

begin
   
   sum          <= in_0 xor in_1;
   carry_out    <= in_0 and in_1;

end architecture rtl;
