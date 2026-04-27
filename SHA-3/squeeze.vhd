library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity squeeze is
  port(
    clk   : in std_logic;
    rst   : in std_logic;

    mode  : in std_logic_vector(1 downto 0);

    -- Entrada desde Keccak-f
    state_in    : in std_logic_vector(0 to 1599); -- salida de keccak
    enout : in std_logic; -- confirmacion desde keccak de estado listo

    -- Solo para SHAKE
    shake_len   : in integer; -- bits a extraer

    -- Control hacia SHA-3 fsm
    next_block : out std_logic;
    block_ack : in std_logic;

    -- Salida
    dout       : out std_logic_vector(0 to 31); -- 4 bytes
    dout_valid : out std_logic;
    dout_done       : out std_logic
  );
end squeeze;

architecture rtl of squeeze is

signal rate_bytes : integer;
signal out_bytes  : integer;

signal state_reg : std_logic_vector(0 to 1599);

signal byte_cnt  : integer := 0;
signal out_cnt   : integer := 0;

type state_type is (IDLE, OUTPUT, PERMUTE, DONE);
signal fsm : state_type := IDLE;

begin

process(mode, shake_len)
begin
  case mode is
    when "00" => -- SHA3-256
      rate_bytes <= 136;
      out_bytes  <= 32;

    when "01" => -- SHA3-512
      rate_bytes <= 72;
      out_bytes  <= 64;

    when "10" => -- SHAKE256
      rate_bytes <= 136;
      out_bytes  <= shake_len / 8;

    when others =>
      rate_bytes <= 136;
      out_bytes  <= 32;
  end case;
end process;

process(clk)
begin
  if rising_edge(clk) then

    if rst = '1' then
      fsm <= IDLE;
      dout_valid <= '0';
      next_block <= '0';
      dout_done <= '0';
      byte_cnt <= 0;
      out_cnt <= 0;

    else
      case fsm is

        -- =====================
        when IDLE =>
          dout_done <= '0';
          dout_valid <= '0';

          if enout = '1' then
            state_reg <= state_in;
            byte_cnt <= 0;
            out_cnt <= 0;
            fsm <= OUTPUT;
          end if;

        -- =====================
        when OUTPUT =>
          dout_valid <= '1';

          -- salida de 4 bytes
          dout <= state_reg((byte_cnt*8) to (byte_cnt*8)+31);

          byte_cnt <= byte_cnt + 4;
          out_cnt  <= out_cnt + 4;

          if out_cnt + 4 >= out_bytes then
            fsm <= DONE;

          elsif byte_cnt + 4 >= rate_bytes then
            fsm <= PERMUTE;
          end if;

        -- =====================
        when PERMUTE =>
          dout_valid <= '0';
          next_block <= '1';

          if block_ack = '1' then
            next_block <= '0';
            state_reg <= state_in; -- nuevo estado
            byte_cnt <= 0;
            fsm <= OUTPUT;
          end if;

        -- =====================
        when DONE =>
          dout_valid <= '0';
          dout_done <= '1';
          fsm <= IDLE;

      end case;
    end if;
  end if;
end process;
end rtl;