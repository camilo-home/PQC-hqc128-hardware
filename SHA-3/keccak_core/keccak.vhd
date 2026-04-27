
library IEEE;
use ieee.std_logic_1164.all;
	
entity keccak is
	port(
			clk: in std_logic;
			en,clrcnt,encnt,clr,clrin,clrout: in std_logic;
			addrct: in std_logic_vector(4 downto 0); 
			sin: in std_logic_vector(0 to 1600-1);			
			sout: out std_logic_vector(0 to 1600-1) 
		  );
end keccak;

architecture rtl of keccak is

component theta is
	port
	(
		s: in std_logic_vector(0 to 1600-1);
		sout: out std_logic_vector(0 to 1600-1)		
	);
end component;

component rho is
	port
	(
		s: in std_logic_vector(0 to 1600-1);
		sout: out std_logic_vector(0 to 1600-1)		
	);
end component;

component pi is
	port
	(
		s: in std_logic_vector(0 to 1600-1);
		sout: out std_logic_vector(0 to 1600-1)		
	);
end component;

component chi is
	port
	(
		s: in std_logic_vector(0 to 1600-1);
		sout: out std_logic_vector(0 to 1600-1)		
	);
end component;

component iota is	
	port
	(
		clk: in std_logic;
		s: in std_logic_vector(0 to 1600-1);
		addrct: in std_logic_vector(4 downto 0);	
		sout: out std_logic_vector(0 to 1600-1)		
	);
end component;

signal st0: std_logic_vector(0 to 1600-1);
signal st1: std_logic_vector(0 to 1600-1);

signal st,sti: std_logic_vector(0 to 1600-1);
signal sr: std_logic_vector(0 to 1600-1);
signal soutt,soutr: std_logic_vector(0 to 1600-1);
signal spi,soutpi: std_logic_vector(0 to 1600-1);
signal schi,soutchi: std_logic_vector(0 to 1600-1);
signal siota,soutiota: std_logic_vector(0 to 1600-1);
signal sinr: std_logic_vector(0 to 1600-1);

begin

-- Input Register
process(clk,clrin)
begin
	if clrin='1' then
		sinr <= (others => '0');
	elsif rising_edge(clk) then
		sinr <= sin;
	end if;
end process;	

-- Output Register
process(clk,clrout)
begin
	if clrout='1' then
		sti <= (others => '0');
	elsif rising_edge(clk) and en='1' then
		sti <= soutiota;
	end if;
end process;

sout <= sti;

st <= sti xor sinr;	

-----------------------------------------------------
-- Rnd
-----------------------------------------------------

gen_theta: theta 
	port map
	(
		st,
		soutt 		
	);

sr <= soutt;	
	
gen_rho: rho 
	port map
	(
		sr,
		soutr		
	);

spi <= soutr;
	
gen_pi: pi 
	port map
	(
		spi,
		soutpi		
	);	

schi <= soutpi;	
	
gen_chi: chi 
	port map
	(
		schi,
		soutchi	
	);
	
process(clk,clr)
begin
	if clr = '1' then
		siota <= (others => '0');
	elsif rising_edge(clk) then
		siota <= soutchi;
	end if;
end process;		
	
gen_iota: iota	
	port map
	(
		clk,		
		siota,
		addrct,
		soutiota		
	);	
	
end rtl;
