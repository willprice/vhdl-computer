------------------------------------------------------------------------------
-- @file reg_shift.vhd
-- @brief Implements a very simple shift register with serial input, parallel
-- load and output, and serial output.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

--
-- @details
-- Generic width shift register with parallel load enable and asynchronous reset.
-- Different action is performed depending on the value of control:
-- 00 - stay the same
-- 01 - shift right
-- 10 - shift left
-- 11 - parallel load
entity reg_shift is
   generic(
      PORT_WIDTH : in natural := 8
   );
   port(
      clk          : in  std_logic;
      reset        : in  std_logic;
      en           : in  std_logic;
      serial_in    : in  std_logic;
      serial_out   : out std_logic;
      parallel_in  : in  std_logic_vector(PORT_WIDTH -1 downto 0);
      parallel_out : out std_logic_vector(PORT_WIDTH -1 downto 0);
      control      : in  std_logic_vector(1 downto 0)
   );
end entity reg_shift;

architecture arch_rtl of reg_shift is

   -- D type flipflop referenced from ff_dtype.vhd
   component ff_dtype is
      port(
         clk    : in std_logic;
         data   : in std_logic;
         reset  : in std_logic;
         q      : buffer std_logic;
         not_q  : buffer std_logic
      );
   end component ff_dtype;

   -- Four to one multiplexer referenced from mux_4to1.vhd
   component mux_4to1 is
      generic (
         PORT_WIDTH : in natural := 1
      );
      port(
         in_0   : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
         in_1   : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
         in_2   : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
         in_3   : in  std_logic_vector(PORT_WIDTH - 1 downto 0);
         sel    : in  std_logic_vector(1 downto 0);
         out_sig: out std_logic_vector(PORT_WIDTH - 1 downto 0)
      );
   end component mux_4to1;
   
   signal flipflop_outputs : std_logic_vector(PORT_WIDTH downto -1);
   signal mux_outputs      : std_logic_vector(PORT_WIDTH downto 0);

begin
   
   parallel_out <= flipflop_outputs(PORT_WIDTH -1 downto 0);
   flipflop_outputs(-1) <= serial_in;
   serial_out <= flipflop_outputs(PORT_WIDTH);

   --
   -- Performs the automatic creation of the multiplexers and flipflops that
   -- form the internals of the register. Also handles connecting them up.
   gen_components : for I in 0 to PORT_WIDTH - 1 generate

      --
      -- The I'th flipflop
      ff : ff_dtype port map(
         clk   => clk,
         reset => reset,
         data => mux_outputs(I),
         q => flipflop_outputs(I)
      );
      
      --
      -- The I'th multiplexer
      mux : mux_4to1
      generic map(
         PORT_WIDTH => 1
      )
      port map(
         -- All mux's share the same control signal.
         sel        => control,
         out_sig(0) => mux_outputs(I),
         -- zeroth input is stay the same
         in_0(0)    => flipflop_outputs(I),
         -- first input is the previous flipflop output
         in_1(0)    => flipflop_outputs(I-1),
         -- second input is the next flipflop output
         in_2(0)    => flipflop_outputs(I+1),
         -- third input is parallel load
         in_3(0)    => parallel_in(I)
      );

   end generate gen_components;

end architecture arch_rtl;
