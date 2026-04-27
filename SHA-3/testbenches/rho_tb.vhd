library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rho_tb is
end rho_tb;

architecture tb of rho_tb is

    -- Component declaration
    component rho
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
    DUT: rho
        port map(
            s    => s_tb,
            sout => sout_tb
        );

    ------------------------------------------------
    -- Stimulus process
    ------------------------------------------------
    stim_proc: process
    begin
        
	s_tb(0 to 1599) <= x"BEE1B253CE4C62F50B90437321FBF9F55DE5BB39DBCEA31440329E792C5B3DD56DC45A40290D3CBF72AC44AFE4982F857990229ABB6F2DDD4404793793F1608ECB000757CFDC99DDA1F0610D6425E162F531DD95AC289CAD9AF6CE0FDAAF3741D0DA1287CB941F3E96B37D4F933588AA7EA5358ED18B67EEDF2FAED50A7B61DA157CD38EF1B72FF2A216C2820AA4D63921D0947D8AE3AB759483633ED868545F713E69241423F6537DE2E3FA9A57D0CC69D6C1BBC70615D72E259371B79BFAC6158AA73C5780A739";
        wait;

    end process;

end tb;