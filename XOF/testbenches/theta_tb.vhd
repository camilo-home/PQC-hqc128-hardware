library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity theta_tb is
end theta_tb;

architecture tb of theta_tb is

    -- Component declaration
    component theta
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
    DUT: theta
        port map(
            s    => s_tb,
            sout => sout_tb
        );

    ------------------------------------------------
    -- Stimulus process
    ------------------------------------------------
    stim_proc: process
    begin
        
	s_tb(0 to 1599) <= x"6EB1F252EC4460B524A93FFEDDF67D17D05D24A3FF8A09423F5A095FC6AFCCA29DEE528A8D62C7006513CCF4B2ACE6075E47AE164C007E20FC263BF4B5A5178C1D765DB97C99EAE654B22FD53C20BEFB070C65B2914DDEB37C0093C4F80F8D963AC40947D9BFA2C15FDCA2D33E6C90A6C584CC0BD44B04082181AAEE385F6380D258C2F4532AD04AD1E68C21990C69EBAC57C265A5051D48FBDB71A7DCDA42646A37FCA72BF6CC38620A86AF98312E0208DB9681DE6D2A4B0A0379B1A4459F971F70BBE63694C7B5";
        wait;

    end process;

end tb;