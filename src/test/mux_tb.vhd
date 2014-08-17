
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

library work; 
use work.common_types.all;

entity mux_tb is
end;

architecture bench of mux_tb is

  component mux
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
  end component;

  constant NUM_INPUTS : integer := 4;
  constant PORT_WIDTH : integer := 8;
  constant SELECT_WIDTH : integer:= 2;

  signal inputs: VEC_ARRAY(0 to NUM_INPUTS -1);
  signal sel: std_logic_vector(SELECT_WIDTH-1 downto 0);
  signal output: std_logic_vector(PORT_WIDTH - 1 downto 0) ;

begin

  -- Insert values for generic parameters !!
  uut: mux generic map ( PORT_WIDTH   => PORT_WIDTH,
                         SELECT_WIDTH => SELECT_WIDTH,
                         NUM_INPUTS   => NUM_INPUTS )
              port map ( inputs       => inputs,
                         sel          => sel,
                         output       => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
    inputs(0) <= "11000000";
    inputs(1) <= "00110000";
    inputs(2) <= "00001100";
    inputs(3) <= "00000011";
    sel       <= "00";

    -- Put test bench stimulus code here
    wait for 10 ns;
    sel <= "01";
    wait for 10 ns;
    sel <= "11";
    wait for 10 ns;
    sel <= "10";
    wait for 10 ns;
    sel <= "00";

    wait;
  end process;


end;
