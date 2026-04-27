
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
	
entity iota is	
	port
	(
		clk: in std_logic;
		s: in std_logic_vector(0 to 1600-1);
		addrct: in std_logic_vector(4 downto 0);	
		sout: out std_logic_vector(0 to 1600-1)		
	);
end iota;

architecture rtl of iota is

component rct_rom is
	generic(init_file : STRING);
	port
	(
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (0 DOWNTO 0)
	);
end component;

component convadd is
	generic(i:integer:=0);
	port(
			add: out std_logic_vector(7 downto 0) 
		  );
end component;

type plane is array (0 to 4) of std_logic_vector(0 to 63);

signal pl0: plane;
signal pl1: plane;
signal pl2: plane;
signal pl3: plane;
signal pl4: plane;

signal pl0t: plane;
signal pl1t: plane;
signal pl2t: plane;
signal pl3t: plane;
signal pl4t: plane;

signal pl0p: plane;
signal pl1p: plane;
signal pl2p: plane;
signal pl3p: plane;
signal pl4p: plane;

signal rc: std_logic_vector(0 to 63);

begin

-----------------------------------------------
-- Map s to an state array pl0,pl1,pl2,pl3,pl4
-----------------------------------------------
 
-- pl0 y=0, x=0:4, z=0:63
gen_pl0: 
	for i in 0 to 4 generate
		pl0(i) <= s(i*64 to i*64+63);
	end generate;

-- pl1 y=1, x=0:4, z=0:63
gen_pl1: 
	for i in 0 to 4 generate
		pl1(i) <= s(64*(5+i) to 64*(5+i)+63);
	end generate;	

-- pl2 y=2, x=0:4, z=0:63
gen_pl2: 
	for i in 0 to 4 generate
		pl2(i) <= s(64*(5*2+i) to 64*(5*2+i)+63);
	end generate;
	
-- pl3 y=3, x=0:4, z=0:63
gen_pl3: 
	for i in 0 to 4 generate
		pl3(i) <= s(64*(5*3+i) to 64*(5*3+i)+63);
	end generate;

-- pl4 y=4, x=0:4, z=0:63
gen_pl4: 
	for i in 0 to 4 generate
		pl4(i) <= s(64*(5*4+i) to 64*(5*4+i)+63);
	end generate;	

---------------------------------------------------------------	

gen_plt:
	for i in 0 to 4 generate
		pl0t(i) <= pl0(i);
		pl1t(i) <= pl1(i);
		pl2t(i) <= pl2(i);
		pl3t(i) <= pl3(i);
		pl4t(i) <= pl4(i);
	end generate;	

rc(2) <= '0';
rc(4 to 6) <= (others => '0');
rc(8 to 14) <= (others => '0');
rc(16 to 30) <= (others => '0');
rc(32 to 62) <= (others => '0');

-- rct
		
gen_rct0: rct_rom
	generic map(init_file => "rct0.mif")	
	port map
	(
		address => addrct,		
		clock => clk,		
		q => rc(0 to 0)		
	);
gen_rct1: rct_rom
	generic map(init_file => "rct1.mif")	
	port map
	(
		address => addrct,		
		clock => clk,		
		q => rc(1 to 1)		
	);
gen_rct2: rct_rom
	generic map(init_file => "rct2.mif")	
	port map
	(
		address => addrct,		
		clock => clk,		
		q => rc(3 to 3)		
	);
gen_rct3: rct_rom
	generic map(init_file => "rct3.mif")	
	port map
	(
		address => addrct,		
		clock => clk,		
		q => rc(7 to 7)		
	);
gen_rct4: rct_rom
	generic map(init_file => "rct4.mif")	
	port map
	(
		address => addrct,		
		clock => clk,		
		q => rc(15 to 15)		
	);
gen_rct5: rct_rom
	generic map(init_file => "rct5.mif")	
	port map
	(
		address => addrct,		
		clock => clk,		
		q => rc(31 to 31)		
	);
gen_rct6: rct_rom
	generic map(init_file => "rct6.mif")	
	port map
	(
		address => addrct,		
		clock => clk,		
		q => rc(63 to 63)		
	);					

pl0p(0) <= pl0t(0) xor rc;

gen_pl0p_14:
	for i in 1 to 4 generate
		pl0p(i) <= pl0t(i);
	end generate;

gen_plip_1_4:
	for i in 0 to 4 generate
		pl1p(i) <= pl1t(i);
		pl2p(i) <= pl2t(i);
		pl3p(i) <= pl3t(i);
		pl4p(i) <= pl4t(i);
	end generate;	
				    
-----------------------------------------------------------
-- Map output state array pl0p,pl1p,pl2p,pl3p,pl4p to sout 
-----------------------------------------------------------
 
-- sout 0
gen_sout0: 
	for i in 0 to 4 generate
		sout(i*64 to i*64+63) <= pl0p(i);
	end generate;

-- sout 1
gen_sout1: 
	for i in 0 to 4 generate
		sout(64*(5+i) to 64*(5+i)+63) <= pl1p(i);
	end generate;	

-- sout 2
gen_sout2: 
	for i in 0 to 4 generate
		sout(64*(5*2+i) to 64*(5*2+i)+63) <= pl2p(i);
	end generate;
	
-- sout 3
gen_sout3: 
	for i in 0 to 4 generate
		sout(64*(5*3+i) to 64*(5*3+i)+63) <= pl3p(i);
	end generate;

-- sout 4
gen_sout4: 
	for i in 0 to 4 generate
		sout(64*(5*4+i) to 64*(5*4+i)+63) <= pl4p(i);
	end generate;	
	
end rtl;
