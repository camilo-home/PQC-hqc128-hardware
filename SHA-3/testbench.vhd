library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.all;

library altera;
USE altera.altera_primitives_components.all;

entity testbench is
generic(n: integer:=25;
		  addsize: integer:=8);
end testbench;
	    
ARCHITECTURE union OF testbench IS

component keccak_core is
	port(
			clk: in std_logic;
			reset,start: in std_logic;
			clrout: in std_logic;
			sin: in std_logic_vector(0 to 1600-1);			 
			sout: out std_logic_vector(0 to 1600-1);
			enout: out std_logic	
		  );
end component;
		  

signal clk: std_logic;
signal reset,clrout: std_logic:='1';
signal start: std_logic:='0';
signal sin: std_logic_vector(0 to 1600-1);			 
signal sout: std_logic_vector(0 to 1600-1);
signal enout: std_logic;

Begin

seq1: process
   begin	   
	   wait for 1200 ns;
	   reset <= '0';
		clrout <= '0';	
    end process;
	 
seq2: process
   begin	   
	   wait for 2200 ns;
	   start <= '1';	        
    end process;	 
	 
seq3: process 
    begin	   
	   clk <= '0';
	   wait for 500 ns;
	   clk <= '1';
	   wait for 500 ns;	        
    end process;	

sin <= (others => '0');

gen_keccak: keccak_core
	port map(
			clk,
			reset,start,
			clrout,
			sin,			 
			sout,
			enout
		  );
	
end Architecture;

