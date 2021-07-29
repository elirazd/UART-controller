library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all ;
entity dcount is
	generic ( depth : integer :=7) ;
	port ( clrN, clk , en , clr_dcount : in std_logic ;
			eoc : out std_logic) ;
end dcount ;
architecture arc_dcount of dcount is
  signal counter : integer range 0 to depth;
begin
   process ( clrN, clk )
   begin
		if clrN = '0' then
			counter <= 0 ;
		elsif clr_dcount = '1' then
			counter <= 0 ;
		elsif en = '1' then
			if rising_edge(clk) then 
				if counter < depth then 
					counter <= counter + 1 ;
				end if ;
			end if ;
      end if ;
   end process ;
   eoc <=  '1'  when counter = depth else '0' ;
end arc_dcount ;


