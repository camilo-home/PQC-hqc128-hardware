library IEEE;
use ieee.std_logic_1164.all;

entity keccak_core is
	port(
			clk: in std_logic;
			reset,start: in std_logic;
			clrout: in std_logic;
			sin: in std_logic_vector(0 to 1600-1);			 
			sout: out std_logic_vector(0 to 1600-1);
			enout: out std_logic	
		  );
end keccak_core;

architecture rtl of keccak_core is

component keccak is
	port(
			clk: in std_logic;
			en,clrcnt,encnt,clr,clrin,clrout: in std_logic;
			addrct: in std_logic_vector(4 downto 0); 
			sin: in std_logic_vector(0 to 1600-1);			
			sout: out std_logic_vector(0 to 1600-1) 
		  );
end component;

component cntir is
	PORT
	(
		aclr		: IN STD_LOGIC ;
		clk_en		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
end component;

component fsm_keccak is
	port(
		clk				 : in	std_logic;
		reset,start,fc	 : in	std_logic;		
		en,clrcnt,encnt,enout,clr,clrin	 : out	std_logic
	);
end component;

signal sel,en,clrcnt,encnt,fc,clr,clrin: std_logic;
signal addrct: std_logic_vector(4 downto 0);  

begin

gen_ir: cntir 
	port map
	(
		aclr => clrcnt,
		clk_en => encnt,		
		clock => clk,
		q => addrct
	);

fc <= addrct(4) and not(addrct(3)) and addrct(2) and addrct(1) and addrct(0); 

control: fsm_keccak 
	port map(
				clk,				 
				reset,start,fc,	 		
				en,clrcnt,encnt,enout,clr,clrin	 	 
			);

gen_keccak: keccak 
	port map(
			clk,
			en,clrcnt,encnt,clr,clrin,clrout,
			addrct,
			sin,			
			sout			
		  );
end rtl;
