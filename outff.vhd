library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
entity outff is
   port ( preN , clk , set , en , d , reset : in  std_logic ;
		  q  : out std_logic ) ;
end outff ;
architecture arc_outff of outff is
	begin
	   process ( clk , preN )
		begin
			if preN = '0' then
				q <= '0' ;
			elsif rising_edge(clk) then 
				if reset = '1' then
					q <= '0' ;
				elsif set = '1' then
					q <= '1' ;
				elsif en = '1' then
					q <= d ;
				end if ;
			end if ;
		end process ;
end arc_outff ;