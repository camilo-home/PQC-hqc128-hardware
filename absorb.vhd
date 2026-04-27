library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity absorb is
  port(
    clk         : in  std_logic;
    rst         : in  std_logic;
    mode        : in  std_logic_vector(1 downto 0);

    din         : in  std_logic_vector(0 to 31);
    din_valid   : in  std_logic;
    last        : in  std_logic;

    state_out   : out std_logic_vector(0 to 1599);
    state_valid : out std_logic
  );
end absorb;

architecture rtl of absorb is

  -- =========================
  -- Parámetros
  -- =========================
  signal rate_bytes : integer := 136;
  signal suffix     : std_logic_vector(0 to 7);
  signal fbp        : std_logic_vector(0 to 7);

  -- =========================
  -- Estado interno
  -- =========================
  signal state_reg : std_logic_vector(0 to 1599) := (others => '0');
  signal byte_cnt  : integer range 0 to 136 := 0;

  -- =========================
  -- FSM
  -- =========================
  type state_type is (IDLE, ABSORB, PAD, DONE);
  signal fsm : state_type := IDLE;

begin

  -- =========================
  -- Selección de modo
  -- =========================
  process(mode)
  begin
    case mode is
      when "00" => -- SHA3-256
        rate_bytes <= 136;
        suffix     <= "01000000";
        fbp        <= "00100000";

      when "01" => -- SHA3-512
        rate_bytes <= 72;
        suffix     <= "01000000";
        fbp        <= "00100000";

      when "10" => -- SHAKE256
        rate_bytes <= 136;
        suffix     <= "11110000";
        fbp        <= "00001000";

      when others =>
        rate_bytes <= 136;
        suffix     <= "01000000";
        fbp        <= "00100000";
    end case;
  end process;

  -- =========================
  -- Lógica secuencial
  -- =========================
  process(clk)
  begin
    if rising_edge(clk) then

      if rst = '1' then
        fsm         <= IDLE;
        byte_cnt    <= 0;
        state_reg   <= (others => '0');
        state_valid <= '0';

      else
        case fsm is

          -- =========================
          when IDLE =>
            state_valid <= '0';

            if din_valid = '1' then
              fsm <= ABSORB;
            end if;

          -- =========================
          when ABSORB =>
            if din_valid = '1' then

              -- Byte 0
state_reg((byte_cnt*8) to (byte_cnt*8)+7) <=
  din(7) & din(6) & din(5) & din(4) &
  din(3) & din(2) & din(1) & din(0);

-- Byte 1
state_reg((byte_cnt*8)+8 to (byte_cnt*8)+15) <=
  din(15) & din(14) & din(13) & din(12) &
  din(11) & din(10) & din(9) & din(8);

-- Byte 2
state_reg((byte_cnt*8)+16 to (byte_cnt*8)+23) <=
  din(23) & din(22) & din(21) & din(20) &
  din(19) & din(18) & din(17) & din(16);

-- Byte 3
state_reg((byte_cnt*8)+24 to (byte_cnt*8)+31) <=
  din(31) & din(30) & din(29) & din(28) &
  din(27) & din(26) & din(25) & din(24);


              byte_cnt <= byte_cnt + 4;
            end if;

            if last = '1' then
              fsm <= PAD;

            elsif byte_cnt >= rate_bytes then
              fsm <= DONE;
            end if;

          -- =========================
          when PAD =>

            -- suffix + padding inicial
            state_reg((byte_cnt*8) to (byte_cnt*8)+7) <=
              state_reg((byte_cnt*8) to (byte_cnt*8)+7) xor suffix xor fbp;

            -- padding final (bit 1)
            state_reg(((rate_bytes-1)*8) to ((rate_bytes-1)*8)+7) <=
              state_reg(((rate_bytes-1)*8) to ((rate_bytes-1)*8)+7) xor "00000001";

            fsm <= DONE;

          -- =========================
          when DONE =>
            state_valid <= '1';
            byte_cnt    <= 0;
            fsm         <= IDLE;

        end case;
      end if;
    end if;
  end process;

  -- =========================
  -- Salida
  -- =========================
  state_out <= state_reg;

end rtl;