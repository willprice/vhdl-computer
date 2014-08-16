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
      parallel_out : in  std_logic_vector(PORT_WIDTH -1 downto 0);
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
         q      : out std_logic;
         not_q  : out std_logic
      );
   end component ff_dtype;

   -- Four to one multiplexer referenced from mux_4to1.vhd
   component mux_4to1 is
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
   end component mux_4to1;
   
   signal inter_dtypes : std_logic_vector(PORT_WIDTH     downto 0);
   signal inter_muxes  : std_logic_vector(PORT_WIDTH - 1 downto 0);

begin
   
   --
   -- Performs the automatic creation of the multiplexers and flipflops that
   -- form the internals of the register. Also handles connecting them up.
   gen_components : for I in 0 to PORT_WIDTH - 1 generate
    
      --
      -- The I'th flipflop
      ff : ff_dtype port map(
         clk   => clk,
         reset => reset,
         data  => inter_muxes(I),
         q     => inter_dtypes(I-1)
      );
      
      --
      -- The I'th multiplexer
      mux : mux_4to1
      generic map(
         PORT_WIDTH => 1
      )
      port map(
         output(I) => inter_muxes(I),
         sel       => control,
         in_0(I)   => inter_dtypes(I),
         in_1(I)   => inter_dtypes(I-1),
         in_2(I)   => inter_dtypes(I+1),
         in_3(I)   => parallel_in(I)
      );

   end generate gen_components;

end architecture arch_rtl;
