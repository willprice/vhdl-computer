------------------------------------------------------------------------------
-- @file adder_full.vhd
-- @brief Implementes a simple 1 bit half adder that can be used to make full
-- adders and vector adders.
-- @see adder_full_tb
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

--
-- Computes the sum and carry bit for two input bits and a carry in bit.
--
entity adder_full is
   port(
        in_0        : in std_logic;
        in_1        : in std_logic;
        carry_in    : in std_logic;
        sum         : out std_logic;
        carry_out   : out std_logic
   );
end entity adder_full;

architecture rtl of adder_full is

    signal i0_xor_i1 : std_logic;
    signal i0_and_i1 : std_logic;
    signal ci_and_xor: std_logic;

begin
   
   i0_xor_i1 <= in_0 xor in_1;
   i0_and_i1 <= in_0 and in_1;
   ci_and_xor <= i0_xor_i1 and carry_in;
   sum <= i0_xor_i1 xor carry_in;
   carry_out <= ci_and_xor or i0_and_i1;

end architecture rtl;
