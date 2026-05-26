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
      din_ready   : out std_logic;
      din_last    : in  std_logic;
      din_keep    : in  std_logic_vector(3 downto 0);

      absorb_state       : out std_logic_vector(0 to 1599);
      absorb_state_valid : out std_logic
    );
end absorb;

architecture rtl of absorb is

  signal rate_bytes : integer := 136;
  signal suffix     : std_logic_vector(7 downto 0);
  signal fbp        : std_logic_vector(7 downto 0);

  signal state_reg : std_logic_vector(0 to 1599) := (others => '0');
  signal byte_position  : integer range 0 to 136 := 0;

  type state_type is (IDLE, ABSORB, PAD, DONE);
  signal fsm : state_type := IDLE;

begin
  -- =========================
  -- MODE
  -- =========================
  process(mode)
  begin
    case mode is
      when "00" => rate_bytes <= 136; suffix <= "01000000"; fbp <= "00100000";
      when "01" => rate_bytes <= 72;  suffix <= "01000000"; fbp <= "00100000";
      when "10" => rate_bytes <= 136; suffix <= "11110000"; fbp <= "00001000";
      when others => rate_bytes <= 136; suffix <= "01000000"; fbp <= "00100000";
    end case;
  end process;

  din_ready <= '1' when (fsm = IDLE or fsm = ABSORB) else '0';

  -- =========================
  -- FSM + DATAPATH
  -- =========================
  process(clk)
    variable next_cnt : integer;
  begin
    if rising_edge(clk) then

      if rst = '1' then
        fsm <= IDLE;
        byte_position <= 0;
        state_reg <= (others => '0');
        absorb_state_valid <= '0';

      else

        absorb_state_valid <= '0';

        case fsm is

        -- =====================
        when IDLE =>
          byte_position <= 0;

          if din_valid = '1' then
	    state_reg <= (others => '0');
            fsm <= ABSORB;
          end if;

        -- =====================
        when ABSORB =>

          if din_valid = '1' then

            next_cnt := byte_position;

--            -- BYTE 0
--            if din_keep(0) = '1' and next_cnt < rate_bytes then
--              state_reg((next_cnt*8) to (next_cnt*8)+7) <= din(7) & din(6) & din(5) & din(4) &
--  din(3) & din(2) & din(1) & din(0);
--              next_cnt := next_cnt + 1;
--            end if;
--
--            -- BYTE 1
--            if din_keep(1) = '1' and next_cnt < rate_bytes then
--              state_reg((next_cnt*8) to (next_cnt*8)+7) <= din(15) & din(14) & din(13) & din(12) &
--  din(11) & din(10) & din(9) & din(8);
--              next_cnt := next_cnt + 1;
--            end if;
--
--            -- BYTE 2
--            if din_keep(2) = '1' and next_cnt < rate_bytes then
--              state_reg((next_cnt*8) to (next_cnt*8)+7) <= din(23) & din(22) & din(21) & din(20) &
--  din(19) & din(18) & din(17) & din(16);
--              next_cnt := next_cnt + 1;
--            end if;
--
--            -- BYTE 3
--            if din_keep(3) = '1' and next_cnt < rate_bytes then
--              state_reg((next_cnt*8) to (next_cnt*8)+7) <= din(31) & din(30) & din(29) & din(28) &
--  din(27) & din(26) & din(25) & din(24);
--              next_cnt := next_cnt + 1;
--            end if;

	-- DEBUG
	    if din_keep(0) = '1' and next_cnt < rate_bytes then
              state_reg((next_cnt*8) to (next_cnt*8)+7) <= din(0 to 7);
              next_cnt := next_cnt + 1;
            end if;

            if din_keep(1) = '1' and next_cnt < rate_bytes then
              state_reg((next_cnt*8) to (next_cnt*8)+7) <= din(8 to 15);
              next_cnt := next_cnt + 1;
            end if;

            if din_keep(2) = '1' and next_cnt < rate_bytes then
              state_reg((next_cnt*8) to (next_cnt*8)+7) <= din(16 to 23);
              next_cnt := next_cnt + 1;
            end if;

            if din_keep(3) = '1' and next_cnt < rate_bytes then
              state_reg((next_cnt*8) to (next_cnt*8)+7) <= din(24 to 31);
              next_cnt := next_cnt + 1;
            end if;

            byte_position <= next_cnt;

          end if;

          if byte_position >= rate_bytes then
            fsm <= DONE;

          elsif din_last = '1' then
            fsm <= PAD;
          end if;

        -- =====================
        when PAD =>

          -- padding correcto
          state_reg((byte_position*8) to (byte_position*8)+7) <=
            state_reg((byte_position*8) to (byte_position*8)+7)
            xor suffix xor fbp;

          state_reg(((rate_bytes-1)*8) to ((rate_bytes-1)*8)+7) <=
            state_reg(((rate_bytes-1)*8) to ((rate_bytes-1)*8)+7)
            xor "00000001";

          fsm <= DONE;

        -- =====================
        when DONE =>
          absorb_state_valid <= '1'; -- enviar bloque
	  absorb_state <= state_reg;
          fsm <= IDLE;

        end case;
      end if;
    end if;
  end process;

end rtl;
