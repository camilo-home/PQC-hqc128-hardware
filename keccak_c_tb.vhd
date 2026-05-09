library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity keccak_c_tb is
end entity;

architecture sim of keccak_c_tb is

--==================================================
-- DUT
--==================================================

component keccak_c is
	port(
		clk           : in  std_logic;
		rst         : in  std_logic;

		start         : in  std_logic;
		permute       : in  std_logic;

		state_in      : in  std_logic_vector(0 to 1599);

		state_out     : out std_logic_vector(0 to 1599);
		state_valid   : out std_logic
	);
end component;

--==================================================
-- SIGNALS
--==================================================

signal clk         : std_logic := '0';
signal rst       : std_logic := '0';

signal start       : std_logic := '0';
signal permute : std_logic := '0';

signal state_in    : std_logic_vector(0 to 1599) := (others => '0');

signal state_out   : std_logic_vector(0 to 1599);

signal state_valid : std_logic;

constant CLK_PERIOD : time := 10 ns;

begin

--==================================================
-- CLOCK
--==================================================

clk <= not clk after CLK_PERIOD/2;

--==================================================
-- DUT
--==================================================

dut : keccak_c
port map(
	clk           => clk,
	rst           => rst,

	start         => start,
	permute       => permute,

	state_in      => state_in,

	state_out     => state_out,
	state_valid   => state_valid
);

--==================================================
-- STIMULUS
--==================================================

process
begin

	--==============================================
	-- RESET
	--==============================================

	rst <= '1';

	wait for 10 ns;

	rst <= '0';

	wait for 10 ns;

	--==============================================
	-- TEST 1
	-- NUEVA PERMUTACION
	--==============================================
	permute <= '0';

	-- ejemplo simple
	--state_in <= x"E7BB87029EF1A48F51E203CC9F33AB2177955A65786419ABB29201F60CE2A8BDEA0BCA46A07214D12BF671FEB425E9FF23E2622505A77F096E74986B305BDA3139A098D8EF650CB5263FF10BED5AC90CAC6BE8C4FC955AD7C0848EB064676595FAAAF3DB683EA5816413E2C0B38C1DC2F96AA58858F44F8086759B845AC6A7A04F0E93314F7F7D26886623DEA90E6C86D3700BF2AA5A3E1D134CF33851177C3128645C75449E30292790A345249F821843A620E764ACAF68DC850CFE97226FAE9245373ADEFF8F57";
	state_in <= (others => '0');
	start <= '1';

	wait for CLK_PERIOD;

	start <= '0';

	-- esperar resultado

	wait until state_valid = '1';

	--==============================================
	-- TEST 2
	-- REUTILIZAR ESTADO ANTERIOR
	--==============================================

	wait for 100 ns;

	permute <= '1';

	start <= '1';

	wait for CLK_PERIOD;

	start <= '0';

	wait until state_valid = '1';

	wait;

end process;

end architecture;