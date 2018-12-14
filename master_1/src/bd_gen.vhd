library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bd_e is

	port(clk_i: in  std_logic;
		 rst_i: in 	std_logic;
		 ena_i: in  std_logic;
		 bd_o : out std_logic;
		 bd_t : out std_logic);
end bd_e;

architecture bd_a of bd_e is

signal divider 	: integer range 0 to 10000 := 0;
signal divider2 	: integer range 0 to 10000 := 0;
signal bd_clk  	: std_logic := '0';
signal trig_clk : std_logic := '0';


begin

bd_o <= bd_clk;
bd_t <= trig_clk;


-- this is the normal baud which can be turnd off as well
bd_9k6: process(clk_i, rst_i)
			begin
			
				if (rst_i = '1') then
					divider <= 0;
					bd_clk <= '0';
				
				elsif (rising_edge(clk_i)) then
					
					if (ena_i = '1') then     -- On each rising edge of the 50MHz clock, do the following...
						if (divider < 5209) then  -- The number comes from system clock / desired baud !!!!!
							divider <= divider + 1;  
						else
							divider <= 0;            -- reset counter back to 0.
							bd_clk <= not bd_clk;          -- Toggle the new output
						end if; 
					end if;
				end if;
					
end process;


--this is the baud used for triggering the signal
trig: process (clk_i, rst_i)
		
		begin
		
		if(rst_i = '1') then
		
			trig_clk <= '0';
			divider2 <= 0;
			
		elsif(rising_edge(clk_i)) then 
				
			if(ena_i = '1') then
			
				if(bd_clk = '1' and divider2 < 5209) then 	
					if(divider2 = 2603) then
						divider2 <= divider2 + 1;
						trig_clk <= '1';
					else
						divider2 <= divider2 + 1;
						trig_clk <= '0';
					end if;
				
				elsif(bd_clk = '0' and divider2 < 5209) then
					if(divider2 = 2603) then
						divider2 <= divider2 + 1;
						trig_clk <= '1';
					else
						divider2 <= divider2 + 1;
						trig_clk <= '0';
					end if;
				else
					divider2 <= 0;
					trig_clk <= '0';
				end if;
				
			else
				
				trig_clk <= '0';
				divider2 <= 0;
			end if;
		end if;
		
end process;
						
end bd_a;		
		
		

