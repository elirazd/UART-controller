library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_transmitter is
 -- no ports
end tb_transmitter ;
architecture arc_tb_transmitter of tb_transmitter is
component transmitter
   port (  resetN , clk	, write_din : in  std_logic ;
		  din	   : in std_logic_vector (7 downto 0);
          tx , tx_ready  : out std_logic ) ;
end component ;
signal resetN , clk, send , tx , txready : std_logic;
signal din : std_logic_vector (7 downto 0) ;
begin

eut: transmitter port map (resetN , clk ,send , din ,tx , txready) ;
process
	constant dt : time := 40 ns ; 
	begin
	-- resetN operate
	resetN <= '0' ;
	wait for dt ;
	assert not(resetN = '0')
		report "reseN functionality is enabled"
		severity error;

	--get an input
	resetN <= '1' ; send <= '1' ;
	din <= "10100101" ;
	wait for dt ;
	report "got an input" ;

	
	-- send start bit
	for i in 1 to 217 loop
		resetN <= '1' ; send <= '0' ;
		wait for dt ;
	end loop ;
	assert(tx = '0')
		report "start bit not succeeded"
		severity error;
	assert not(tx = '0')
		report "start bit succeeded"
		severity note;
	
	--send the whole messeage
	for i in 1 to 8 loop
		for i in 1 to 217 loop
			resetN <= '1' ; send <= '0' ;
			wait for dt ;
		end loop ;
	end loop ;
	
		-- send start bit
	for i in 1 to 217 loop
		resetN <= '1' ; send <= '0' ;
		wait for dt ;
	end loop ;
	assert(tx = '1')
		report "stop bit not succeeded"
		severity error;
	assert not(tx = '1')
		report "stop bit succeeded"
		severity note;
	--end of test !!!!
			-- send start bit
	for i in 1 to 217 loop
		resetN <= '1' ; send <= '0' ;
		wait for dt ;
	end loop ;
	--get an input
	resetN <= '1' ; send <= '1' ;
	din <= "10100101" ;
	wait for dt ;
	report "got an input" ;

	
	-- send start bit
	for i in 1 to 217 loop
		resetN <= '1' ; send <= '0' ;
		wait for dt ;
	end loop ;
	assert(tx = '0')
		report "start bit not succeeded"
		severity error;
	assert not(tx = '0')
		report "start bit succeeded"
		severity note;
	
	--send the whole messeage
	for i in 1 to 8 loop
		for i in 1 to 217 loop
			resetN <= '1' ; send <= '0' ;
			wait for dt ;
		end loop ;
	end loop ;
	
		-- send start bit
	for i in 1 to 217 loop
		resetN <= '1' ; send <= '0' ;
		wait for dt ;
	end loop ;
	assert(tx = '1')
		report "stop bit not succeeded"
		severity error;
	assert not(tx = '1')
		report "stop bit succeeded"
		severity note;
	--end of test !!!!


	wait ; 
	end process ;
end arc_tb_transmitter;