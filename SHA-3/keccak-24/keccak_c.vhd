library IEEE;
use ieee.std_logic_1164.all;

entity keccak_c is
	port(
			clk: in std_logic;
			rst: in std_logic;
			start: in std_logic; -- iniciar fsm
			permute: in std_logic; -- reusar estado actual para permutacion

			state_in: in std_logic_vector(0 to 1600-1);			 
			state_out: out std_logic_vector(0 to 1600-1);
			state_valid: out std_logic
		  );
end keccak_c;

architecture rtl of keccak_c is

-- declaracion de keccak permutation
component keccak_p is
	port(
			clk: in std_logic;
			round_cnt: in std_logic_vector(4 downto 0); 
			permutation_in: in std_logic_vector(0 to 1600-1);			
			permutation_out: out std_logic_vector(0 to 1600-1) 
		  );
end component;

-- declaracion del contador de rondas
component cntir is
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clk_en		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
end component;

-- FSM
type state_type is (
	IDLE,
	LOAD,
	PERMUTING,
	DONE
);
signal state      : state_type;

-- SEÑALES
signal permutation_done, clr_counter, en_counter, load_state, update_state: std_logic;
signal round_cnt: std_logic_vector(4 downto 0);
signal state_reg: std_logic_vector(0 to 1600-1);
signal out_reg: std_logic_vector(0 to 1600-1);
signal state_next: std_logic_vector(0 to 1600-1);

begin

gen_ir: cntir 
	port map
	(
		aclr => clr_counter,
		clk_en => en_counter,		
		clock => clk,
		q => round_cnt
	);

-- comparador indicador de 24 rondas hechas (23 decimal = 10111)
permutation_done <= round_cnt(4) and
                    not(round_cnt(3)) and
                    round_cnt(2) and
                    round_cnt(1) and
                    round_cnt(0);

gen_keccak_p: keccak_p
	port map(
			clk,
			round_cnt,
			state_reg,			
			state_next			
		  );

--====================================================
-- FSM
--====================================================
process(clk, rst)
begin

	if rst = '1' then
		state <= IDLE;
	elsif rising_edge(clk) then
		case state is
			when IDLE =>
				if start = '1' then
					if permute = '0' then
						state <= LOAD;
					else
						state <= PERMUTING;
					end if;
				else
					state <= IDLE;
				end if;
	
			when LOAD =>
				state <= PERMUTING;
	
			when PERMUTING =>
				if permutation_done = '1' then
					state <= DONE;
				else
					state <= PERMUTING;
				end if;
			when DONE =>
				state <= IDLE;
		end case;
	end if;
end process;
		
process(state)
begin

	-- defaults
	en_counter <= '0';
	clr_counter <= '0';
	load_state  <= '0';
	update_state <= '0';
	state_valid <= '0';

	case state is
		when IDLE =>
			clr_counter <= '1';

		when LOAD =>
			load_state <= '1';

		when PERMUTING =>
			update_state <= '1';
			en_counter <= '1';

		when DONE =>
			state_valid <= '1';
	end case;
end process;

process(clk, rst)
begin

	if rst = '1' then
		state_reg <= (others => '0');
	elsif rising_edge(clk) then
		if load_state = '1' then
			state_reg <= state_in;
		elsif update_state = '1' then
			state_reg <= state_next;
		end if;
		if permutation_done = '1' then
			out_reg <= state_next;
		end if;
	end if;
end process;

state_out <= out_reg;

end rtl;
