ARCHITECTURE uart_a OF uart_e IS 
------------------------------------------------------------------------------
SIGNAL bd_o_s    : std_logic;			-- this is not used
SIGNAL clk_bd_s  : std_logic;                       -- Baud clock
SIGNAL ena_bd_s  : std_logic := '0';	         	 -- Enable for the baud
SIGNAL cnt_s     : integer RANGE 0 TO int_15 := 0;   -- Counter for selecting bit being transmitted
SIGNAL cnt2_s    : integer RANGE 0 TO int_10 := 0;
SIGNAL cnt3_s    : integer RANGE 0 TO int_10 := 0;
SIGNAL data_i_s  : std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');   -- Receive shift register
SIGNAL dat_o_s   : std_logic_vector(8 DOWNTO 0) := (OTHERS => '0');
SIGNAL get_par_s : std_logic; -- don't put this to 0!!!!!!!!
SIGNAL mem_tog_s : std_logic := '0';
SIGNAL pomosen_s : std_logic := '0';
SIGNAL led_s     : std_logic := '0';
SIGNAL fl_s      : std_logic;
------------------------------------------------------------------------------
BEGIN
  ena_o    <= ena_bd_s;
  clk_bd_s <= bd_i;
  mem_o    <= mem_tog_s;
  par_o    <= get_par_s;
  cn_o     <= led_s;
------------------------------------------------------------------------------
--This PROCESS triggers the falling edge of the incoming data stream
------------------------------------------------------------------------------
trig_rx:  PROCESS(rst_i, clk_i)
	    BEGIN
	      IF(rst_i = '1') THEN
	        ena_bd_s    <= '0';
		mem_tog_s   <= '0';
		pomosen_s   <= '0';
		cnt2_s      <=  0 ;
		cnt3_s      <=  0 ;
		flag_o      <= '0';
		fl_s        <= '0';
	      ELSIF(clk_i'EVENT AND clk_i = '1') THEN   
		IF(rx_i = '0' AND cnt_s = 0)	 THEN
		  ena_bd_s  <= '1';            -- start the baud clock generator/bit count
		END IF;
		IF(cnt_s = int_11) THEN              -- IF the number of bits counted is equal to 11,
		  ena_bd_s  <= '0';             -- stop the baud clock generator/bit counter.
		  pomosen_s <= '1';
		END IF;
		IF(pomosen_s = '1' AND cnt2_s < int_3) THEN
		  cnt2_s    <= cnt2_s + 1;
		END IF;
		IF(cnt2_s = int_2) THEN
		  mem_tog_s <= '1';
		  pomosen_s <= '0';
		  cnt2_s    <=  0 ;
		END IF;
		IF(mem_tog_s = '1') THEN
		  mem_tog_s <= '0';
		END IF;
		IF(mem_tog_s = '1' AND cnt3_s < int_7) THEN
		  cnt3_s    <= cnt3_s + 1;
		END IF;
		IF(cnt3_s = 0 AND mem_tog_s = '0') THEN
		  flag_o    <= '1';
		END IF;
		IF(cnt3_s = 0 AND mem_tog_s = '1') THEN
		  flag_o    <= '0';
		  fl_s      <= '0';
		END IF;
		IF(cnt3_s = int_6) THEN
		  cnt3_s    <= 0;
		  fl_s      <= '1';
		END IF;
	      END IF;			
	  END PROCESS;
------------------------------------------------------------------------------		
    -- Increments to count how many bits have been sampled
------------------------------------------------------------------------------	
bit_counter: PROCESS(rst_i, clk_i)
	       BEGIN
		 IF(rst_i = '1') THEN
		   cnt_s <= 0;
	         ELSIF(clk_i'EVENT AND clk_i = '1') THEN -- Only count when the receiver is 'running'
                   IF(clk_bd_s = '1' AND ena_bd_s = '1') THEN  -- Increment counter on each baud clock pulse
                     cnt_s <= cnt_s + 1;
                   END IF;
		   IF(cnt_s = int_11) THEN             -- if we received 11 bits
		     cnt_s <= 0;                 -- set the counter to 0
		   END IF;
	         END IF;
	     END PROCESS;
------------------------------------------------------------------------------	
    -- Input to the data register at the bit specified by the bit counter.
------------------------------------------------------------------------------
input_data: PROCESS(rst_i, clk_i)
              BEGIN
	        IF(rst_i = '1') THEN
		  data_i <= (OTHERS => '0');
	        ELSIF(clk_i'EVENT AND clk_i = '1') THEN               
                  IF(clk_bd_s = '0' AND ena_bd_s = '1') THEN     
                    data_i_s(cnt_s) <= rx_i;        
                  END IF;
                END IF;
            END PROCESS;	
------------------------------------------------------------------------------
    -- When all 8-bits are received, make it available on the output.
------------------------------------------------------------------------------
output_data: PROCESS(rst_i, clk_i, ena_bd_s)
               BEGIN
	         IF(rst_i = '1') THEN
		   dat_o <= (OTHERS => '0');
		   l_o   <= '0';
		   led_s <= '0';	
		 ELSIF(clk_i'EVENT AND clk_i = '1') THEN 
                   IF(ena_bd_s = '0') THEN
		     dat_o_s   <= data_i_s (9 DOWNTO 1);
		     get_par_s <= NOT (dat_o_s(8) xor dat_o_s(7) xor
				       dat_o_s(6) xor dat_o_s(5) xor
				       dat_o_s(4) xor dat_o_s(3) xor
				       dat_o_s(2) xor dat_o_s(1) xor
				       dat_o_s(0));
		     IF(get_par_s = '1') THEN
		       dat_o(0)  <= dat_o_s(7);
		       dat_o(1) <= dat_o_s(6);
		       dat_o(2) <= dat_o_s(5);
		       dat_o(3) <= dat_o_s(4);
		       dat_o(4) <= dat_o_s(3);
		       dat_o(5) <= dat_o_s(2);
		       dat_o(6) <= dat_o_s(1);
		       dat_o(7) <= dat_o_s(0);
		     END IF;
		     IF(get_par_s = '0') THEN
		       dat_o <= (OTHERS => '0');
		       l_o   <= '1';
		       led_s <= '1';
		     END IF;				
		   END IF;	
		   IF(fl_s = '1' AND led_s = '1') THEN
		     led_s <= '0';
		   END IF;
	         END IF;
             END PROCESS;
------------------------------------------------------------------------------
END uart_a;




