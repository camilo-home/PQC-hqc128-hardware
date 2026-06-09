library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pi_tb is
end pi_tb;

architecture tb of pi_tb is
    -- Component declaration
    component pi
        port(
            s    : in  std_logic_vector(0 to 1599);
            sout : out std_logic_vector(0 to 1599)
        );
    end component;

    -- Signals
    signal s_tb    : std_logic_vector(0 to 1599);
    signal sout_tb : std_logic_vector(0 to 1599);

begin

    -- Instantiate DUT
    DUT: pi
        port map(
            s    => s_tb,
            sout => sout_tb
        );

    ------------------------------------------------
    -- Stimulus process
    ------------------------------------------------
    stim_proc: process
    begin
        
	s_tb(0 to 1599) <= x"BEE1B253CE4C62F585C821B990FDFCFA7796ECE76F3A8C51C5B3DD540329E79221A797EDB88B4805FE4982F8572AC44A29ABB6F2DDD79902391011E4DE4FC582000EAF9FB933BB965E162A1F0610D642BEA63BB2B5851395D066BDB383F6ABCD50F97283E7DA1B429AC4554B59BEA7C91DA316CFDCFD4A6B6A853DB0ED6F97D79C778DB97F90ABE6AC73442D850415491D5BA90E84A3EC575F9483633ED86854FD94DC4F9A4905081F78B8FEA695F4334EB60DDE3830AEBB259371B79BFAC62E9CE4562A9CF15E02";
        wait;

    end process;

end tb;