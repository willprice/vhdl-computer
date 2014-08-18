------------------------------------------------------------------------------
-- @file comparator_1bit.vhd
-- @brief A very simple 1 bit comparator with LT, EQ, and GT output bits.
-- @see comparator_1bit.vhd
-------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

--
-- @brief Acts as a 1 bit comparator. Comp is compared with base.
-- lt is set iff comp is less than base.
-- likewise for gt.
--
entity comparator_1bit is
    port(
        base : in  std_logic;
        comp : in  std_logic;
        lt   : out std_logic;
        gt   : out std_logic;
        eq   : out std_logic
    );
end entity comparator_1bit;

architecture rtl of comparator_1bit is

    -- factord out common signals for lt, gt and eq
    signal not_base : std_logic;
    signal not_comp : std_logic;

begin
   
    not_base <= not base;
    not_comp <= not comp;

    eq <= (base and comp) or (not_base and not_comp));
    lt <= base and not_comp;
    gt <= not_base and comp;

end architecture rtl;
