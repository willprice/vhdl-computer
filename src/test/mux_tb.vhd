------------------------------------------------------------------------------
-- @file mux_tb.vhd
-- @brief Testbench for the MUX 
-- @detais <TO ADD>
-------------------------------------------------------------------------------

-- import std_logic from the IEEE library. Should be done for ALL VHDL files.
library IEEE;
use IEEE.std_logic_1164.all;

-- Module Entity Declaration
entity mux_tb is
end entity mux_tb;

-- Module Architecture
architecture arch_rtl of mux_tb is

-- DUT component declaration
component mux is
   generic (
      PORT_WIDTH : in natural := 1
   );
   port(
      in_a  : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
      in_b  : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
      sel   : in  std_logic;
      output: out std_logic_vector(PORT_WIDTH - 1 downto 0)
   );
end component;

-- signal declarations
signal input_1 : std_logic_vector(7 downto 0) := "00001111";
signal input_2 : std_logic_vector(7 downto 0) := "01010101";
signal out_sig : std_logic_vector(7 downto 0) := "00001111";
signal select_signal : std_logic := '1';

begin

   -- quick n nasty toggle the select signal every 10 ns.
   select_signal <= not select_signal after 10 ns;

   -- Monitors the output of the DUT and throws errors if there is any sort of
   -- missmatch
   assert_test : process (out_sig, select_signal)
   begin
      if (select_signal='1') then
         assert(out_sig = input_1) report "Bad MUX output on sel=1";
      end if;
   end process assert_test;

   -- For correct behavior observe the output value switch between
   -- in_a and in_b every 10 ns;
  
   dut : mux generic map (PORT_WIDTH => 8)
            port map (in_a => input_1,
                      in_b => input_2,
                      sel  => select_signal,
                      output => out_sig);

end architecture arch_rtl;
