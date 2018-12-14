library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_e is

	port(clk_i: in std_logic;
		 rst_i: in std_logic;
		 par_i: in std_logic;
		 m_i  : in std_logic;
		 mem_i: in std_logic;
		 dat_i: in std_logic_vector (7 downto 0);
		 fs_i: in std_logic;
		 g_o: out std_logic;
		 d_o  : out std_logic_vector (7 downto 0));
	
end mem_e;

architecture mem_a of mem_e is


--signals

signal d1_i_s: std_logic_vector (7 downto 0) := "00000000";
signal d2_i_s: std_logic_vector (7 downto 0) := "00000000";
signal d3_i_s: std_logic_vector (7 downto 0) := "00000000";
signal d4_i_s: std_logic_vector (7 downto 0) := "00000000";

signal d5_i_s: std_logic_vector (7 downto 0) := "00000000";
signal d6_i_s: std_logic_vector (7 downto 0) := "00000000";

signal check_s: std_logic := '0'; --!!!!!!!

signal cnt: integer range 0 to 10 := 0;
signal cnt2: integer range 0 to 10 := 0;

signal act_s: std_logic;



begin
	
	
	get_char: process (rst_i, clk_i)
	
	begin
	
		if(rst_i = '1') then
				
			cnt <= 0;
			act_s <= '0';
			cnt2 <= 0;
			g_o <= '0';
			d_o <= "00000000";
			d1_i_s <= "00000000";
			d2_i_s <= "00000000";
			d3_i_s <= "00000000";
			d4_i_s <= "00000000";
			d5_i_s <= "00000000";
			d6_i_s <= "00000000";
			
		elsif(clk_i'event and clk_i = '1') then
		
			if(check_s = '0') then	
				if(par_i = '1' and mem_i = '1') then
			
					if(cnt = 0) then
				
						d1_i_s <= dat_i;
						cnt <= cnt + 1;
					end if;
				
					if(cnt = 1) then
					
						d2_i_s <= dat_i;
						cnt <= cnt + 1;
					end if;
				
					if(cnt = 2) then
				
						d3_i_s <= dat_i;
						cnt <= cnt + 1;
					end if;
				
					if(cnt = 3) then
				
						d4_i_s <= dat_i;
						cnt <= cnt + 1;
					end if;
					
					if(cnt = 4) then
				
						d5_i_s <= dat_i;
						cnt <= cnt + 1;
					end if;
					
					if(cnt = 5) then
				
						d6_i_s <= dat_i;
						cnt <= cnt + 1;
					end if;
					
				end if;
			end if;
			if(cnt = 6) then
			
				cnt <= 0;
				act_s <= '1';
				--d1_i_s <= "00000000";
				--d2_i_s <= "00000000";
				--d3_i_s <= "00000000";
				--d4_i_s <= "00000000";
				--d5_i_s <= "00000000";
				--d6_i_s <= "00000000";
			end if;
			
			if(par_i = '0') then
				
				check_s <= '1';
				cnt <= 0;
				d1_i_s <= "00000000";
				d2_i_s <= "00000000";
				d3_i_s <= "00000000";
				d4_i_s <= "00000000";
				d5_i_s <= "00000000";
				d6_i_s <= "00000000";
				
			end if;
			
			if(fs_i = '1') then
				
				check_s <= '0';
			end if;
			
			--SEND THE DATA TO PASS MODULE
			
			if (act_s = '1' and m_i = '1') then
			
				if(cnt2 = 0) then
	
					d_o <= d1_i_s;
					cnt2 <= cnt2 + 1;
					g_o <= '1';
				end if;
				
				if(cnt2 = 1) then
				
					d_o <= d2_i_s;
					cnt2 <= cnt2 + 1;
				end if;
				
				if(cnt2 = 2) then
				
					d_o <= d3_i_s;
					cnt2 <= cnt2 + 1;
				end if;
				
				if(cnt2 = 3) then
				
					d_o <= d4_i_s;
					cnt2 <= cnt2 + 1;
				end if;
				
				if(cnt2 = 4) then
				
					d_o <= d5_i_s;
					cnt2 <= cnt2 + 1;
				end if;
				
				if(cnt2 = 5) then
				
					d_o <= d6_i_s;
					cnt2 <= cnt2 + 1;
				end if;
				
				if(cnt2 = 6) then
				
					d_o <= "00000000";
					cnt2 <= 0;
					act_s <= '0';
					g_o <= '0';
				end if;
			
			end if;
			
		end if;
	
	end process;

end mem_a;
