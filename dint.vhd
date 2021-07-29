library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity dint is
	generic ( depth : integer :=8) ; --din width is 8 bit
	port (
		clrN , clk , PL , SE :in std_logic ;
		din 	:in std_logic_vector (depth - 1 downto 0);
		dout	:out std_logic );
end dint ;

architecture arc_dint of dint is
signal dint : std_logic_vector (depth -1 downto 0);
begin
	process(clrN , clk)
	begin
		if clrN ='0' then
			dint <= (others => '0') ;
		elsif PL = '1' then
			dint <= din ;
		elsif SE = '1' then
			if rising_edge(clk) then
				for i in depth - 2 downto 0 loop
					dint(i) <= dint(i + 1);
				end loop;
				dint(depth - 1) <= '0';	
			end if;
		end if;
	end process;
	dout <= dint(0) when clrN = '1' else '0' ;
end arc_dint ;


