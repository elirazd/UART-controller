library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity smt is
	port (	clrN , clk , write_din , t1 , eoc :in std_logic ;
			tx_ready , te , ena_load , clr_dcount , clr_tx , ena_tx , ena_shift , ena_dcount ,set_tx	:out std_logic );
end smt ;

architecture arc_smt of smt is
	type state is ( idle , send_start , clear_timer , send_data , test_eoc , shift_count , send_stop) ;
	signal present_state , next_state : state ;
begin
	process(clrN , clk)
	begin
		if clrN ='0' then 
			present_state <= idle ;
		elsif rising_edge(clk) then
			present_state <= next_state ;
		end if;
	end process;
	process( present_state , write_din , t1 , eoc )
	begin
		next_state <= idle ;
		tx_ready <= '1' ;
		te <= '0' ;
		ena_load <='0';
		clr_dcount <='0';
		clr_tx <='0';
		ena_tx <='0';
		ena_shift <='0';
		ena_dcount <='0';
		set_tx <='0';
		case present_state is
			when idle =>
				tx_ready <= '0' ;
				ena_load <= '1' ; 
				clr_dcount <= '1' ;
				if write_din = '1' then
					next_state <= send_start ;
				else 
					next_state <= idle ;
				end if ;
			when send_start =>
				te <= '1' ;
				clr_tx <= '1' ;
				if t1 = '1' then
					next_state <= clear_timer ;
				else 
					next_state <= send_start ;
				end if ;
			when clear_timer =>
					next_state <= send_data ;
			when send_data =>
				te <= '1' ;
				ena_tx <= '1' ;
				if t1 = '1' then
					next_state <= test_eoc ;
				else 
					next_state <= send_data ;
				end if ;
			when test_eoc =>
				if eoc = '1' then
					next_state <= send_stop ;
				else 
					next_state <= shift_count ;
				end if ;
			when shift_count =>
				ena_shift <= '1' ;
				ena_dcount <= '1' ;
				next_state <= send_data ;
			when send_stop =>
				te <= '1' ;
				set_tx <= '1' ;
				if t1 = '1' then
					next_state <= idle ;
				else 
					next_state <= send_stop ;
				end if ;
			when others => next_state <= idle ;
		end case;
	end process ;
end arc_smt ;


