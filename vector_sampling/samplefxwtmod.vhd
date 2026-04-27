library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity samplefxwtmod is
  port(
    clk           : in  std_logic;
    rst           : in  std_logic;

    start         : in  std_logic;
    mode          : in  std_logic; -- 0: wt=66, 1: wt=75

    shake_din     : in  std_logic_vector(31 downto 0);
    shake_valid   : in  std_logic;

    sample_done          : out std_logic
  );
end entity;

architecture rtl of samplefxwtmod is

  -- =========================
  -- CONSTANTES
  constant N : integer := 17669;
  constant RAM_BYTES : integer := 2209;

  -- =========================
  -- BRAM (bitmap)
  type ram_type is array (0 to RAM_BYTES-1) of std_logic_vector(7 downto 0);
  signal ram : ram_type := (others => (others => '0'));

  -- =========================
  -- FSM
  type state_type is (
    IDLE,
    LOAD_U32,
    --COMPUTE,
    COMP_1,
    COMP_2,
    COMP_3,
    READ_BRAM,
    WRITE_BRAM,
    NEXT_I,
    DONE
  );

  signal fsm : state_type := IDLE;

  -- =========================
  -- DATAPATH
  signal wt        : integer range 0 to 75 := 0;
  signal i         : integer range 0 to 75 := 0;

  signal u32       : unsigned(31 downto 0);
  signal m         : unsigned(14 downto 0);

  signal mult      : unsigned(46 downto 0);
  signal posn    : unsigned(14 downto 0);

  signal byte_addr : integer range 0 to RAM_BYTES-1;
  signal bit_addr  : integer range 0 to 7;

  signal byte_reg  : std_logic_vector(7 downto 0);

begin

  process(clk)
  variable temp : unsigned(46 downto 0);
  begin
    if rising_edge(clk) then

      if rst = '1' then
        fsm   <= IDLE;
        i     <= 0;
        sample_done  <= '0';
        ram   <= (others => (others => '0'));

      else
        case fsm is

          -- =========================
          when IDLE =>
            sample_done <= '0';

            if start = '1' then
              i <= 0;

              if mode = '0' then
                wt <= 66;
              else
                wt <= 75;
              end if;

              ram <= (others => (others => '0'));
              fsm <= LOAD_U32;
            end if;

          -- =========================
          when LOAD_U32 =>
            if shake_valid = '1' then
              u32 <= unsigned(shake_din);
              fsm <= COMP_1;
            end if;

          -- =========================

	    -- COMBINACIONAL (alta latencia)
	    --when COMPUTE =>
	    --temp := u32 * to_unsigned(N - i, 15);
	    --posn <= temp(46 downto 32) + to_unsigned(i, 15);
	    --fsm <= READ_BRAM;
	    -- SECUENCIAL
            -- m = N - i
	    when COMP_1 =>
	      m <= to_unsigned(N - i, 15);
	      fsm <= COMP_2;
	    -- multiplicacion
	    when COMP_2 =>
	      mult <= u32 * m;
	      fsm <= COMP_3;
	    -- escalado (shift) + posicion
	    when COMP_3 =>
	      posn    <= mult(46 downto 32) + to_unsigned(i, 15);
	      fsm <= READ_BRAM;

          -- =========================
          when READ_BRAM =>
            byte_addr <= to_integer(posn(14 downto 3));
            bit_addr  <= to_integer(posn(2 downto 0));

            byte_reg <= ram(to_integer(posn(14 downto 3)));

            fsm <= WRITE_BRAM;

          -- =========================
          when WRITE_BRAM =>

            if byte_reg(bit_addr) = '0' then
              -- escribir bit
              byte_reg(bit_addr) <= '1';
              ram(byte_addr) <= byte_reg;

              fsm <= NEXT_I;
            else
              -- duplicado ? ignorar y pedir nuevo u32
              fsm <= LOAD_U32;
            end if;

          -- =========================
          when NEXT_I =>
            i <= i + 1;

            if i + 1 >= wt then
              fsm <= DONE;
            else
              fsm <= LOAD_U32;
            end if;

          -- =========================
          when DONE =>
            sample_done <= '1';
            fsm <= IDLE;

        end case;
      end if;
    end if;
  end process;

end rtl;
