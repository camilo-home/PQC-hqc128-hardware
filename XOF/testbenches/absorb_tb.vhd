library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity absorb_tb is
end absorb_tb;

architecture sim of absorb_tb is

  signal clk         : std_logic := '0';
  signal rst         : std_logic := '1';

  signal mode        : std_logic_vector(1 downto 0);
  signal din         : std_logic_vector(0 to 31);
  signal din_valid   : std_logic := '0';
  signal last        : std_logic := '0';

  signal state_out   : std_logic_vector(0 to 1599);
  signal state_valid : std_logic;

begin

  -- =========================
  -- DUT
  -- =========================
  uut: entity work.absorb
    port map(
      clk => clk,
      rst => rst,
      mode => mode,
      din => din,
      din_valid => din_valid,
      last => last,
      state_out => state_out,
      state_valid => state_valid
    );

  -- =========================
  -- Stimulus (clock manual)
  -- =========================
  process
  begin

    -- =========================
    -- RESET
    -- =========================
    rst <= '1';
    last <= '0';
    mode <= "00";
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;

    rst <= '0';
    din_valid <= '1';
    
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;

    -- =========================
    -- WORD 0
    -- =========================
    din       <= x"E7BB8702";
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;

    -- =========================
    -- WORD 1
    -- =========================
    din       <= x"9EF1A48F";
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;

    -- =========================
    -- WORD 2
    -- =========================
    din       <= x"51E203CC";
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;

    -- =========================
    -- WORD 3
    -- =========================
    din       <= x"9F33AB21";
    last      <= '1';
    -- =========================
    -- PAD
    -- =========================
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;

    -- =========================
    -- DONE (state_valid debería activarse)
    -- =========================
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;

    -- ciclos extra para observar
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;

    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;

    wait;
  end process;

end sim;
