library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_e is 

	port (clk_i: in std_logic;
		  rst_i: in std_logic;
		  rx_i : in std_logic;
		  l_o: out std_logic;
		  par_o: out std_logic;
		  mem_o: out std_logic;
		  bd_tst: out std_logic;
		  dat_o: out std_logic_vector(7 downto 0);
		  flag_o: out std_logic;
		  cn_o: out std_logic);
		  
end uart_e;

architecture uart_a of uart_e is 

--baud generator component

component bd_e 

	port(clk_i: in  std_logic;
		 rst_i: in 	std_logic;
		 ena_i: in  std_logic;
		 bd_o : out std_logic;
		 bd_t : out std_logic);
		 
end component;

-- signals for baud component
--signal ena_i_s: std_logic;
signal bd_o_s: std_logic;			-- this is not used
--signal bd_t_s :std_logic;

-- signals for uart

signal clk_bd : std_logic;                       -- Baud clock
-- signal rx_s   : std_logic;                    -- Signals the module is currently receiving
signal ena_bd : std_logic := '0';						 -- Enable for the baud
signal cnt    : integer range 0 to 100 := 0;   -- Counter used for selecting bit being transmitted
signal cnt2    : integer range 0 to 10 := 0;
signal cnt3    : integer range 0 to 10 := 0;
signal data_i  : std_logic_vector(11 downto 0) := "000000000000";   -- Receive shift register
signal dat_o_s: std_logic_vector(8 downto 0) := "000000000";
signal get_par: std_logic; -- don't put this to 0!!!!!!!!
signal mem_tog: std_logic := '0';
signal pomosen: std_logic := '0';
signal led_s: std_logic := '0';
signal fl_s: std_logic;





begin

	--clk_bd <= bd_t_s;
	bd_tst <= ena_bd;
	mem_o <= mem_tog;
	par_o <= get_par;
	cn_o <= led_s;

	bd_comp: bd_e port map (clk_i => clk_i,
							rst_i => rst_i,
							ena_i => ena_bd, 
							bd_o => bd_o_s, 
							bd_t => clk_bd); -- connects the baud generator
	
	
	--This process triggers the falling edge of the incoming data stream
	
	trig_rx: process(rst_i, clk_i)
			
		begin
				
			if(rst_i = '1') then
				
				ena_bd <= '0';
				mem_tog <= '0';
				pomosen <= '0';
				cnt2 <= 0;
				cnt3 <= 0;
				flag_o <= '0';
				fl_s <= '0';
			
			elsif(clk_i'event and clk_i = '1') then   
				
				if( rx_i = '0' and cnt = 0)	 then
					
					ena_bd <= '1';            -- start the baud clock generator/bit count
				end if;
				
				if(cnt = 11) then              -- If the number of bits counted is equal to 11,
					
					ena_bd <= '0';             -- stop the baud clock generator/bit counter.
					pomosen <= '1';
				end if;
				
				if(pomosen = '1' and cnt2 < 3) then
				
					cnt2 <= cnt2 + 1;
				end if;
				
				if(cnt2 = 2) then
				
					mem_tog <= '1';
					pomosen <= '0';
					cnt2 <= 0;
				end if;
				
				if(mem_tog = '1') then
				
					mem_tog <= '0';
				end if;
				
				if(mem_tog = '1' and cnt3 < 7) then
			
					cnt3 <= cnt3 + 1;
				end if;
				
				if(cnt3 = 0 and mem_tog = '0') then
					
					flag_o <= '1';
				end if;
				
				if(cnt3 = 0 and mem_tog = '1') then
				
					flag_o <= '0';
					fl_s <= '0';
				end if;
				
				if(cnt3 = 6) then
				
					cnt3 <= 0;
					fl_s <= '1';
				end if;
				
			end if;
				
	end process;
	
			
    -- Increments to count how many bits have been sampled
	
    bit_counter: process(rst_i, clk_i)
		
		begin
		
		if(rst_i = '1') then
			cnt <= 0;
		
        elsif(clk_i'event and clk_i = '1') then        				-- Only count when the receiver is 'running'
            if(clk_bd = '1' and ena_bd = '1') then 	    -- Increment counter on each baud clock pulse
                cnt <= cnt + 1;
            end if;
			
			if(cnt = 11) then             -- If we received 11 bits
				cnt <= 0;                 -- set the counter to 0
			end if;
		end if;
		
    end process;
	
	
	
    -- Input to the data register at the bit specified by the bit counter.
    input_data: process(rst_i, clk_i)
    
	begin
	
		if(rst_i = '1') then
		
			data_i <= "000000000000";
		
        elsif(clk_i'event and clk_i = '1') then               
            if(clk_bd = '0' and ena_bd = '1') then     
                                            
                data_i(cnt) <= rx_i;        
            end if;
        end if;
		
    end process;
	
	
	
    -- When all 8-bits are received, make it available on the output.
    output_data: process(rst_i, clk_i, ena_bd)
    
	begin
	
		if(rst_i = '1') then
	
			dat_o <= "00000000";
			l_o <= '0';
			led_s <= '0';
			
		elsif(clk_i'event and clk_i = '1') then 
            
			if(ena_bd = '0') then
				
				dat_o_s <= data_i (9 downto 1);
				
				get_par <= not (dat_o_s(8) xor dat_o_s(7) xor
								dat_o_s(6) xor dat_o_s(5) xor
								dat_o_s(4) xor dat_o_s(3) xor
								dat_o_s(2) xor dat_o_s(1) xor
								dat_o_s(0));
				
				if(get_par = '1') then
				
					dat_o(0) <= dat_o_s(7);
					dat_o(1) <= dat_o_s(6);
					dat_o(2) <= dat_o_s(5);
					dat_o(3) <= dat_o_s(4);
					dat_o(4) <= dat_o_s(3);
					dat_o(5) <= dat_o_s(2);
					dat_o(6) <= dat_o_s(1);
					dat_o(7) <= dat_o_s(0);
					
				end if;
				
				if(get_par = '0') then
					
					dat_o <= "00000000";
					l_o <= '1';
					led_s <= '1';
				end if;				
			end if;	
			
			if(fl_s = '1' and led_s = '1') then
				
				--l_o <= '0';
				led_s <= '0';
			end if;
			
		end if;
    end process;
	

end uart_a;




