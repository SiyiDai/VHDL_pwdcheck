ARCHITECTURE mem_a OF mem_e IS
------------------------------------------------------------------------------
SIGNAL d1_i_s : std_logic_vector (7 DOWNTO 0) := (OTHERS => '0');
SIGNAL d2_i_s : std_logic_vector (7 DOWNTO 0) := (OTHERS => '0');
SIGNAL d3_i_s : std_logic_vector (7 DOWNTO 0) := (OTHERS => '0');
SIGNAL d4_i_s : std_logic_vector (7 DOWNTO 0) := (OTHERS => '0');
SIGNAL d5_i_s : std_logic_vector (7 DOWNTO 0) := (OTHERS => '0');
SIGNAL d6_i_s : std_logic_vector (7 DOWNTO 0) := (OTHERS => '0');

SIGNAL check_s: std_logic := '0'; --!!!!!!!

SIGNAL cnt_s  : integer RANGE 0 TO int_10 := 0;
SIGNAL cnt2_s : integer RANGE 0 TO int_10 := 0;

SIGNAL act_s  : std_logic;
------------------------------------------------------------------------------
BEGIN
------------------------------------------------------------------------------
get_char: PROCESS (rst_i, clk_i)
	    BEGIN
	      IF(rst_i = '1') THEN	
		cnt_s  <=  0 ;
		act_s  <= '0';
		cnt2_s <=  0 ;
		g_o    <= '0';
		d_o    <= (OTHERS => '0');
		d1_i_s <= (OTHERS => '0');
		d2_i_s <= (OTHERS => '0');
		d3_i_s <= (OTHERS => '0');
		d4_i_s <= (OTHERS => '0');
		d5_i_s <= (OTHERS => '0');
		d6_i_s <= (OTHERS => '0');
	      ELSIF(clk_i'EVENT AND clk_i = '1') THEN
		IF(check_s = '0') THEN	
		  IF(par_i = '1' AND mem_i = '1') THEN
		    IF(cnt_s = 0) THEN
		      d1_i_s <= dat_i;
		      cnt_s  <= cnt_s + 1;
		    END IF;
		    IF(cnt_s = int_1) THEN
		      d2_i_s <= dat_i;
		      cnt_s  <= cnt_s + 1;
		    END IF;
		    IF(cnt_s = int_2) THEN
		      d3_i_s <= dat_i;
		      cnt_s  <= cnt_s + 1;
		    END IF;
		    IF(cnt_s = int_3) THEN
		      d4_i_s <= dat_i;
		      cnt_s  <= cnt_s + 1;
		    END IF;
		    IF(cnt_s = int_4) THEN
		      d5_i_s <= dat_i;
		      cnt_s  <= cnt_s + 1;
		    END IF;
		    IF(cnt_s = int_5) THEN
		      d6_i_s <= dat_i;
		      cnt_s <= cnt_s + 1;
		    END IF;
		  END IF;
	        END IF;
	          IF(cnt_s = int_6) THEN
		    cnt_s <=  0 ;
		    act_s <= '1';
	          END IF;
		  IF(par_i = '0') THEN
		    check_s <= '1';
		    cnt_s   <= 0;
		    d1_i_s  <= (OTHERS => '0');
		    d2_i_s  <= (OTHERS => '0');
		    d3_i_s  <= (OTHERS => '0');
		    d4_i_s  <= (OTHERS => '0');
		    d5_i_s  <= (OTHERS => '0');
		    d6_i_s  <= (OTHERS => '0');	
	          END IF;
		  IF(fs_i = '1') THEN
		    check_s <= '0';
		  END IF;
------------------------------------------------------------------------------					    
		IF (act_s = '1' AND m_i = '1') THEN         --SEND THE DATA TO PASS MODULE
		  IF(cnt2_s = 0) THEN
	 	    d_o    <= d1_i_s;
		    cnt2_s <= cnt2_s + 1;
		    g_o    <= '1';
		  END IF;
		  IF(cnt2_s = int_1) THEN	
		    d_o    <= d2_i_s;
   		    cnt2_s <= cnt2_s + 1;
		  END IF;
		  IF(cnt2_s = int_2) THEN
		    d_o    <= d3_i_s;
		    cnt2_s <= cnt2_s + 1;
		  END IF;
		  IF(cnt2_s = int_3) THEN
		    d_o    <= d4_i_s;
		    cnt2_s <= cnt2_s + 1;
		  END IF;
		  IF(cnt2_s = int_4) THEN
		    d_o    <= d5_i_s;
		    cnt2_s <= cnt2_s + 1;
		  END IF;
		  IF(cnt2_s = int_5) THEN
	       	    d_o    <= d6_i_s;
		    cnt2_s <= cnt2_s + 1;
		  END IF;
		  IF(cnt2_s = int_6) THEN
		    d_o    <= (OTHERS => '0');
		    cnt2_s <=  0 ;
		    act_s  <= '0';
		    g_o    <= '0';
	          END IF;
		END IF;
	      END IF;
	END PROCESS;
------------------------------------------------------------------------------
END mem_a;
