library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity squeeze is
  port(
    clk   : in std_logic;
    rst   : in std_logic;

    mode  : in std_logic_vector(1 downto 0);

    -- Entrada desde Keccak-f
    state_in    : in std_logic_vector(0 to 1087); -- salida de keccak
    state_valid : in std_logic; -- confirmacion desde keccak de estado listo

    -- Bits de SHAKE
    shake_len   : in unsigned(15 downto 0); --  bytes a extraer

    -- Control hacia SHA-3 fsm
    next_block : out std_logic;
    sq : in std_logic;

    -- Salida
    dout       : out std_logic_vector(0 to 31); -- 4 bytes
    dout_valid : out std_logic;
    dout_empty       : out std_logic
  );
end squeeze;

architecture rtl of squeeze is

signal rate_bytes : integer := 136;	
signal out_bytes  : integer := 0; 

signal state_reg : std_logic_vector(0 to 1087);

signal byte_cnt  : integer := 0;
signal out_cnt   : integer := 0;
signal sq_d : std_logic := '0';

type state_type is (IDLE, OUTPUT, REQ_STATE,WAIT_STATE, DONE);
signal fsm : state_type := IDLE;

begin

process(mode, shake_len)
begin
  case mode is
    when "00" => -- SHA3-256
      out_bytes  <= 32;

    when "01" => -- SHA3-512
      out_bytes  <= 64;

    when "10" => -- SHAKE256
      out_bytes <= to_integer(shake_len);

    when others =>
      out_bytes  <= 32;
  end case;
end process;

process(clk)
begin
if rising_edge(clk) then

	if rst = '1' then
	      state_reg <= (others => '0');
	      fsm <= IDLE;
	      dout_valid <= '0';
	      next_block <= '0';
	      dout_empty <= '1';
	      byte_cnt <= 0;
	      out_cnt <= 0;
	      sq_d <= '0';
	else
	
	case fsm is

        when IDLE =>
          dout_empty <= '1';
          dout_valid <= '0';

          if state_valid = '1' then
            state_reg <= state_in;
            byte_cnt <= 0;
            out_cnt <= 0;
            fsm <= OUTPUT;
          end if;

        when OUTPUT =>
	  dout_empty <= '0';
	  dout_valid <= '0';
	  sq_d <= sq;

	  if sq = '1' and sq_d = '0' then
	
	    -- primero verificar si hay que recargar, solo sucede en shake
	    if byte_cnt >= rate_bytes and mode = "10" then
	      fsm <= REQ_STATE;
	      sq_d <= '0';
	
	    -- luego verificar fin global
	    elsif out_cnt >= out_bytes then
	      fsm <= DONE;
	      sq_d <= '0';	
	    -- Si todo OK, leer
	    else
	      for i in 0 to 31 loop
		dout(i) <= state_reg(byte_cnt*8 + i);
	      end loop;

	      dout_valid <= '1';
	      byte_cnt <= byte_cnt + 4;
	      out_cnt  <= out_cnt + 4;
	    end if;
	
	  end if;

        when REQ_STATE =>
	dout_valid <= '0';
	dout_empty <= '1';
	next_block <= '1';
	fsm <= WAIT_STATE;
	
	when WAIT_STATE =>
	dout_valid <= '0';
	next_block <= '0';
          if state_valid = '1' then
            next_block <= '0';
            state_reg <= state_in; -- nuevo estado
            byte_cnt <= 0;
            fsm <= OUTPUT;
          end if;

        -- =====================
        when DONE =>
          dout_valid <= '0';
          fsm <= IDLE;

      end case;
    end if;
  end if;
end process;
end rtl;
