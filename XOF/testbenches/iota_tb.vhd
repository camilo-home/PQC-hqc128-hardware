library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity iota_tb is
end iota_tb;

architecture tb of iota_tb is
component iota is	
	port
	(
		clk: in std_logic;
		s: in std_logic_vector(0 to 1600-1);
		addrct: in std_logic_vector(4 downto 0);	
		sout: out std_logic_vector(0 to 1600-1)
	);

end component;

    signal s_tb    : std_logic_vector(0 to 1599);
    signal sout_tb : std_logic_vector(0 to 1599);
    signal clk     : std_logic;
    signal addrct   : std_logic_vector(4 downto 0);

begin

    -- Instantiate DUT
    DUT: iota
        port map(
            s    => s_tb,
            sout => sout_tb,
	    clk  => clk,
	    addrct => addrct
        );

 ------------------------------------------------
    -- Stimulus process
    ------------------------------------------------
    seq1: process
    begin

s_tb <= x"eeb1f252ec4460b524a93ffeddf67d17d05d24a3ff8a09423f5a095fc6afcca29dee528a8d62c7006513ccf4b2ace6075e47ae164c007e20fc263bf4b5a5178c1d765db97c99eae654b22fd53c20befb070c65b2914ddeb37c0093c4f80f8d963ac40947d9bfa2c15fdca2d33e6c90a6c584cc0bd44b04082181aaee385f6380d258c2f4532ad04ad1e68c21990c69ebac57c265a5051d48fbdb71a7dcda42646a37fca72bf6cc38620a86af98312e0208db9681de6d2a4b0a0379b1a4459f971f70bbe63694c7b5";

-- indice de round constant desde 0 a 23 bin
addrct <= "00000";

        wait for 2200 ns;

	clk <= '0';
	wait for 500 ns;
	clk <= '1';
	wait for 500 ns;

    end process;

end tb;