library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all ;

entity pass_e is

	port(clk_i: in std_logic;
		 rst_i: in std_logic;
		 s_i1 : in std_logic;
		 s_i2 : in std_logic;
		 dat_i: in std_logic_vector(7 downto 0);
		 g_i: in std_logic;
		 iskluci: in std_logic;
		 m_o  : out std_logic;
		 p_o  : out std_logic);
end pass_e;

architecture pass_a of pass_e is

--signals

--pass 1:
constant p1_1: std_logic_vector(7 downto 0) := "01000001"; --A "01000001"
constant p1_2: std_logic_vector(7 downto 0) := "01000010"; --B "01000010"
constant p1_3: std_logic_vector(7 downto 0) := "01000011"; --C "01000011"
constant p1_4: std_logic_vector(7 downto 0) := "01000100"; --D "01000100"

--pass 2:
constant p2_1: std_logic_vector(7 downto 0) := "01000101"; --E "01000101"
constant p2_2: std_logic_vector(7 downto 0) := "01000110"; --F "01000110"
constant p2_3: std_logic_vector(7 downto 0) := "01000111"; --G "01000111"
constant p2_4: std_logic_vector(7 downto 0) := "01001000"; --H "01001000"

--pass 3:
constant p3_1: std_logic_vector(7 downto 0) := "00110001"; --1 "0011 0001"
constant p3_2: std_logic_vector(7 downto 0) := "00110010"; --2 "0011 0010"
constant p3_3: std_logic_vector(7 downto 0) := "00110011"; --3 "0011 0011"
constant p3_4: std_logic_vector(7 downto 0) := "00110100"; --4 "0011 0100"

--pass 4:
constant p4_1: std_logic_vector(7 downto 0) := "01100001"; --a "0110 0001"
constant p4_2: std_logic_vector(7 downto 0) := "01100010"; --b "0110 0010"
constant p4_3: std_logic_vector(7 downto 0) := "01100011"; --c "0110 0011"
constant p4_4: std_logic_vector(7 downto 0) := "01100100"; --d "0110 0100"


constant p_lf: std_logic_vector(7 downto 0) := "00001010"; --LF "00001010"
constant p_cr: std_logic_vector(7 downto 0) := "00001101"; --CR "00001101"

--other signals 

signal get_mem: std_logic := '0';
signal sw_val : std_logic_vector (1 downto 0);
signal cnt: integer range 0 to 100 := 0;
--signal cmp: std_logic;
signal data_in: std_logic_vector(7 downto 0) := "00000000";
signal pas_vec: std_logic_vector(5 downto 0) := "000000";
signal dat_int: integer := 0;


begin

	sw_val(0) <= s_i1;
	sw_val(1) <= s_i2;
	m_o <= get_mem;

	pass_switch: process(rst_i, clk_i)
	
	begin
	
		if(rst_i = '1') then
			
			get_mem <= '0';
			
		elsif(clk_i'event and clk_i = '1') then
		
			if(sw_val = "00" or sw_val = "01" or sw_val = "10" or sw_val = "11") then
			
				get_mem <= '1';
				
			else
				
				get_mem <= '0';
			end if;
			
		end if;
	
	end process;
	
	data_input: process(rst_i, clk_i)
	
	begin
	
		if(rst_i = '1') then
			
			cnt <= 0;
			data_in <= "00000000";
			
		elsif(clk_i'event and clk_i = '1') then
		
			if(g_i = '1' and cnt < 7) then
			
				data_in <= dat_i;
				cnt <= cnt + 1;
			end if;
			
			if(cnt = 6) then
			
				cnt <= 0;
			end if;
		end if;
	
	end process;
	
	compare: process(rst_i, clk_i)
	
	begin
		
		if(rst_i = '1') then
			
			pas_vec <= "000000";
			
		elsif(clk_i'event and clk_i = '1') then
		
			if(sw_val = "00") then				-- PASSWORD 1 ABCD
			
				if(cnt = 1) then 
					
					if(data_in = p1_1) then
						pas_vec(0) <= '1'; 
					else 
						pas_vec(0) <= '0';
					end if;
				end if;
			
				if(cnt = 2) then 

					if(data_in = p1_2) then 
						pas_vec(1) <= '1'; 
					else 
						pas_vec(1) <= '0';
					end if;
				end if;
			
				if(cnt = 3) then 

					if(data_in = p1_3) then 
						pas_vec(2) <= '1'; 
					else 
						pas_vec(2) <= '0';
					end if;
				end if;
			
				if(cnt = 4) then 
					
					if(data_in = p1_4) then 
						pas_vec(3) <= '1'; 
					else 
						pas_vec(3) <= '0';
					end if;
				end if;
				
				if(cnt = 5) then 
					
					if(data_in = p_cr) then 
						pas_vec(4) <= '1'; 
					else 
						pas_vec(4) <= '0';
					end if;
				end if;
				
				if(cnt = 6) then 
					
					if(data_in = p_lf) then 
						pas_vec(5) <= '1'; 
					else 
						pas_vec(5) <= '0';
					end if;
				end if;
			end if;
			
			if(sw_val = "01") then					-- PASSWORD 2 EFGH
			
				if(cnt = 1) then 
			
					if(data_in = p2_1) then 
						pas_vec(0) <= '1'; 
					else 
						pas_vec(0) <= '0';
					end if;
				end if;
			
				if(cnt = 2) then 

					if(data_in = p2_2) then 
						pas_vec(1) <= '1'; 
					else 
						pas_vec(1) <= '0';
					end if;
				end if;
			
				if(cnt = 3) then 
					
					if(data_in = p2_3) then 
						pas_vec(2) <= '1'; 
					else 
						pas_vec(2) <= '0';
					end if;
				end if;
			
				if(cnt = 4) then 
					
					if(data_in = p2_4) then 
						pas_vec(3) <= '1'; 
					else 
						pas_vec(3) <= '0';
					end if;
				end if;
				
				if(cnt = 5) then 
					
					if(data_in = p_cr) then 
						pas_vec(4) <= '1'; 
					else 
						pas_vec(4) <= '0';
					end if;
				end if;
				
				if(cnt = 6) then 
					
					if(data_in = p_lf) then 
						pas_vec(5) <= '1'; 
					else 
						pas_vec(5) <= '0';
					end if;	
				end if;
			end if;
			
			if(sw_val = "10") then					-- PASSWORD 3 1234
			
				if(cnt = 1) then 
			
					if(data_in = p3_1) then 
						pas_vec(0) <= '1'; 
					else 
						pas_vec(0) <= '0';
					end if;
				end if;
			
				if(cnt = 2) then 

					if(data_in = p3_2) then 
						pas_vec(1) <= '1'; 
					else 
						pas_vec(1) <= '0';
					end if;
				end if;
			
				if(cnt = 3) then 
					
					if(data_in = p3_3) then 
						pas_vec(2) <= '1'; 
					else 
						pas_vec(2) <= '0';
					end if;
				end if;
			
				if(cnt = 4) then 
					
					if(data_in = p3_4) then 
						pas_vec(3) <= '1'; 
					else 
						pas_vec(3) <= '0';
					end if;
				end if;
				
				if(cnt = 5) then 
					
					if(data_in = p_cr) then 
						pas_vec(4) <= '1'; 
					else 
						pas_vec(4) <= '0';
					end if;
				end if;
				
				if(cnt = 6) then 
					
					if(data_in = p_lf) then 
						pas_vec(5) <= '1'; 
					else 
						pas_vec(5) <= '0';
					end if;	
				end if;
			end if;
			
			if(sw_val = "11") then					-- PASSWORD 4 abcd
			
				if(cnt = 1) then 
			
					if(data_in = p4_1) then 
						pas_vec(0) <= '1'; 
					else 
						pas_vec(0) <= '0';
					end if;
				end if;
			
				if(cnt = 2) then 

					if(data_in = p4_2) then 
						pas_vec(1) <= '1'; 
					else 
						pas_vec(1) <= '0';
					end if;
				end if;
			
				if(cnt = 3) then 
					
					if(data_in = p4_3) then 
						pas_vec(2) <= '1'; 
					else 
						pas_vec(2) <= '0';
					end if;
				end if;
			
				if(cnt = 4) then 
					
					if(data_in = p4_4) then 
						pas_vec(3) <= '1'; 
					else 
						pas_vec(3) <= '0';
					end if;
				end if;
				
				if(cnt = 5) then 
					
					if(data_in = p_cr) then 
						pas_vec(4) <= '1'; 
					else 
						pas_vec(4) <= '0';
					end if;
				end if;
				
				if(cnt = 6) then 
					
					if(data_in = p_lf) then 
						pas_vec(5) <= '1'; 
					else 
						pas_vec(5) <= '0';
					end if;	
				end if;
			end if;
			
			if (pas_vec = "111111") then
			
				p_o <= '1';
			else
				p_o <= '0';
			end if;
			
			if(iskluci = '1') then
			
				p_o <= '0';
				pas_vec <= "000000";
			end if;
			
		end if;
		
	end process;


end pass_a;
