library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity squeeze_tb is
end squeeze_tb;

architecture sim of squeeze_tb is

  signal clk         : std_logic := '0';
  signal rst         : std_logic := '1';

  signal mode        : std_logic_vector(1 downto 0);
  signal state_in         : std_logic_vector(0 to 1599);
  signal enout   : std_logic;
  signal shake_len        : integer;

  signal next_block : std_logic;
  signal block_ack : std_logic;

  signal dout   : std_logic_vector(0 to 31);
  signal dout_valid : std_logic;
  signal dout_ready : std_logic;

begin

  uut: entity work.squeeze
    port map(
      clk => clk,
      rst => rst,

      mode => mode,
      state_in => state_in,
      enout => enout,
      shake_len => shake_len,

      next_block => next_block,
      block_ack => block_ack,

      dout => dout,
      dout_valid => dout_valid,
      dout_ready => dout_ready
    );

process
begin

rst <= '1';

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

rst <= '0';
mode <= "00";
state_in <= x"A7FFC6F8BF1ED76651C14756A061D662F580FF4DE43B49FA82D80A4B80F8434A5266BEB7346BF3E26695CCCA215987FF89BAB376577BD9803B316AFC55BDDE28CC8EE4F1193DAC03E934E4C1EC3A1978791EE8AF23A987C2331F6001E34A68215FE7099E467E2E28B8B682C2D21E7DD14E43AFADD2E050F0B089A96AFBF675531EF1FA3260B9C6C2B2A155F0D34D6863B2C28E988B3908D926D30B3E90103F911798474D6634FC3358DE8F071A5C712B79973651927C0B145EEBBDAAA7437385E5707BFB0E6E1392";
enout <= '1';

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

clk <= '0'; wait for 5 ns;
clk <= '1'; wait for 5 ns;

end process;
end sim;