
library ieee;
use ieee.std_logic_1164.all;

entity fsm_keccak is

	port(
		clk				 : in	std_logic;
		reset,start,fc	 : in	std_logic;		
		en,clrcnt,encnt,enout,clr,clrin	 : out	std_logic
	);

end entity;

architecture rtl of fsm_keccak is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s01, s1, s2, s3);

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
					if start = '1' then
						state <= s01;					
					else
						state <= s0;
					end if;
				when s01=>
					state <= s2;
				when s1=>					
					state <= s2;									
				when s2=>					
					if fc = '1' then
						state <= s3;
					else
						state <= s1;
					end if;
				when s3=>					
					state <= s0;						
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when s0 =>
				en			<= '0';
				clrcnt	<= '1';
				encnt		<= '0';
				enout		<= '0';
				clr <= '1';
				clrin <= '0';	
			when s01 =>
				en			<= '0';
				clrcnt	<= '0';
				encnt		<= '0';
				enout		<= '0';
				clr <= '0';	
				clrin <= '0';
			when s1 =>
				en			<= '0';
				clrcnt	<= '0';
				encnt		<= '0';
				enout		<= '0';
				clr <= '0';	
				clrin <= '1';
			when s2 =>
				en			<= '1';
				clrcnt	<= '0';
				encnt		<= '1';
				enout		<= '0';
				clr <= '0';
				clrin <= '1';
			when s3 =>
				en			<= '0';
				clrcnt	<= '0';
				encnt		<= '1';
				enout		<= '1';
				clr <= '0';
				clrin <= '1';	
		end case;
	end process;
	
end rtl;
