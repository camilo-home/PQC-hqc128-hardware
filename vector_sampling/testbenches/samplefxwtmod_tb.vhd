library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity samplefxwtmod_tb is
end entity;

architecture tb of samplefxwtmod_tb is

  -- =========================
  -- DUT signals
  signal clk         : std_logic := '0';
  signal rst         : std_logic := '1';
  signal start       : std_logic := '0';
  signal mode        : std_logic := '0';

  signal shake_din   : std_logic_vector(31 downto 0);
  signal shake_valid : std_logic := '0';

  signal sample_done        : std_logic;

  -- =========================
  -- clock period
  constant CLK_PERIOD : time := 10 ns;

begin

  -- =========================
  -- instancia del DUT
  dut: entity work.samplefxwtmod
    port map(
      clk         => clk,
      rst         => rst,
      start       => start,
      mode        => mode,
      shake_din   => shake_din,
      shake_valid => shake_valid,
      sample_done => sample_done
    );

  -- =========================
  -- clock
  clk_process : process
  begin
    while true loop
      clk <= '0';
      wait for CLK_PERIOD/2;
      clk <= '1';
      wait for CLK_PERIOD/2;
    end loop;
  end process;

  -- =========================
  -- stimulus
  stim_proc: process
    variable seed : unsigned(31 downto 0) := x"12345678";
  begin

    -- reset
    rst <= '1';
    wait for 50 ns;
    rst <= '0';

    -- iniciar
    wait for 20 ns;
    start <= '1';
    wait for CLK_PERIOD;
    start <= '0';

    -- flujo SHAKE simulado
    while sample_done = '0' loop
      wait until rising_edge(clk);

      -- generar pseudo-random simple (LFSR-like)
      seed := seed xor (seed sll 13);
      seed := seed xor (seed srl 17);
      seed := seed xor (seed sll 5);

      shake_din   <= std_logic_vector(seed);
      shake_valid <= '1';
    end loop;

    shake_valid <= '0';

    -- esperar un poco
    wait for 100 ns;

    -- segundo test (modo 75)
    mode <= '1';

    wait for 20 ns;
    start <= '1';
    wait for CLK_PERIOD;
    start <= '0';

    while sample_done = '0' loop
      wait until rising_edge(clk);

      seed := seed xor (seed sll 13);
      seed := seed xor (seed srl 17);
      seed := seed xor (seed sll 5);

      shake_din   <= std_logic_vector(seed);
      shake_valid <= '1';
    end loop;

    shake_valid <= '0';

    wait for 100 ns;

  end process;

end architecture;
