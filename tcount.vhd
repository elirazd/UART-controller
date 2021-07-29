library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all ;
entity tcount is
	generic (totcount : integer := 217) ; --totcount = fclk/baud
	port( clrN, clk, te	:in std_logic;
		t1				:out std_logic);
end tcount ;
architecture arc_tcount of tcount is
	signal count :std_logic_vector (12 downto 0);
begin
	process (clrN, clk)
	begin
		if clrN = '0' then 
		 count <= (others => '0');
		elsif rising_edge(clk) then
				if te = '1' then 
					if count /= totcount then 
						count<=count+1;
					end if;
				else
					count <= (others => '0');
				end if;
         end if;
		end process;
	t1<= '1' when (totcount <= count) else '0' ;
end arc_tcount ;


