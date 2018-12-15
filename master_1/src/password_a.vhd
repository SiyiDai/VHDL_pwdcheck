ARCHITECTURE pass_a OF pass_e IS
------------------------------------------------------------------------------
--other signals 
SIGNAL get_mem_s        : std_logic := '0';
SIGNAL sw_val_s         : std_logic_vector (1 DOWNTO 0);
SIGNAL cnt_s            : integer RANGE 0 TO int_10 := 0;
SIGNAL data_in_s        : std_logic_vector (7 DOWNTO 0) := (OTHERS => '0');
SIGNAL pas_vec_s        : std_logic_vector (5 DOWNTO 0) := (OTHERS => '0');
------------------------------------------------------------------------------
BEGIN
  sw_val_s(0) <= s_i1;
  sw_val_s(1) <= s_i2;
  m_o         <= get_mem_s;
------------------------------------------------------------------------------
pass_switch: PROCESS(rst_i, clk_i)
	       BEGIN
	         IF(rst_i = '1') THEN
	           get_mem_s <= '0';
		 ELSIF(clk_i'EVENT AND clk_i = '1') THEN
		   IF(sw_val_s = sw0 or sw_val_s = sw1 or sw_val_s = sw2 or sw_val_s = sw3) THEN
		     get_mem_s <= '1';
		   ELSE
                     get_mem_s <= '0';
		   END IF;
		 END IF;
	     END PROCESS;
------------------------------------------------------------------------------
data_input : PROCESS(rst_i, clk_i)
	       BEGIN
		 IF(rst_i = '1') THEN
		   cnt_s     <= 0;
		   data_in_s <= (OTHERS => '0');	
		 ELSIF(clk_i'EVENT AND clk_i = '1') THEN
		    IF(g_i = '1' AND cnt_s < int_7) THEN
		      data_in_s <= dat_i;
		      cnt_s     <= cnt_s + 1;
		    END IF;
		    IF(cnt_s = int_6) THEN
		      cnt_s <= 0;
		    END IF;
		  END IF;
             END PROCESS;
------------------------------------------------------------------------------
compare    : PROCESS(rst_i, clk_i)
               BEGIN
		 IF(rst_i = '1') THEN
		   pas_vec_s <= (OTHERS => '0');
		 ELSIF(clk_i'EVENT AND clk_i = '1') THEN
		   IF(sw_val_s = sw0) THEN				-- PASSWORD 1 ABCD
		     IF(cnt_s = 1) THEN 
		       IF(data_in_s = p1_1) THEN
			 pas_vec_s(0) <= '1'; 
		       ELSE 
			 pas_vec_s(0) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 2) THEN 
                       IF(data_in_s = p1_2) THEN 
			 pas_vec_s(1) <= '1'; 
		       ELSE 
			 pas_vec_s(1) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 3) THEN 
                       IF(data_in_s = p1_3) THEN 
			 pas_vec_s(2) <= '1'; 
		       ELSE 
			 pas_vec_s(2) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 4) THEN 
		       IF(data_in_s = p1_4) THEN 
			 pas_vec_s(3) <= '1'; 
		       ELSE 
			 pas_vec_s(3) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 5) THEN 
		       IF(data_in_s = p_cr) THEN 
			 pas_vec_s(4) <= '1'; 
		       ELSE 
			 pas_vec_s(4) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 6) THEN 
		       IF(data_in_s = p_lf) THEN 
			 pas_vec_s(5) <= '1'; 
		       ELSE 
			 pas_vec_s(5) <= '0';
		       END IF;
		     END IF;
		   END IF;
------------------------------------------------------------------------------		   
                   IF(sw_val_s = sw1) THEN					-- PASSWORD 2 EFGH
		     IF(cnt_s = 1) THEN 
		       IF(data_in_s = p2_1) THEN
			 pas_vec_s(0) <= '1'; 
		       ELSE 
			 pas_vec_s(0) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 2) THEN 
                       IF(data_in_s = p2_2) THEN 
			 pas_vec_s(1) <= '1'; 
		       ELSE 
			 pas_vec_s(1) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 3) THEN 
                       IF(data_in_s = p2_3) THEN 
			 pas_vec_s(2) <= '1'; 
		       ELSE 
			 pas_vec_s(2) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 4) THEN 
		       IF(data_in_s = p2_4) THEN 
			 pas_vec_s(3) <= '1'; 
		       ELSE 
			 pas_vec_s(3) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 5) THEN 
		       IF(data_in_s = p_cr) THEN 
			 pas_vec_s(4) <= '1'; 
		       ELSE 
			 pas_vec_s(4) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 6) THEN 
		       IF(data_in_s = p_lf) THEN 
			 pas_vec_s(5) <= '1'; 
		       ELSE 
			 pas_vec_s(5) <= '0';
		       END IF;
		     END IF;
		   END IF;
------------------------------------------------------------------------------
		   IF(sw_val_s = sw2) THEN					-- PASSWORD 3 1234
                     IF(cnt_s = 1) THEN 
		       IF(data_in_s = p3_1) THEN
			 pas_vec_s(0) <= '1'; 
		       ELSE 
			 pas_vec_s(0) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 2) THEN 
                       IF(data_in_s = p3_2) THEN 
			 pas_vec_s(1) <= '1'; 
		       ELSE 
			 pas_vec_s(1) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 3) THEN 
                       IF(data_in_s = p3_3) THEN 
			 pas_vec_s(2) <= '1'; 
		       ELSE 
			 pas_vec_s(2) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 4) THEN 
		       IF(data_in_s = p3_4) THEN 
			 pas_vec_s(3) <= '1'; 
		       ELSE 
			 pas_vec_s(3) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 5) THEN 
		       IF(data_in_s = p_cr) THEN 
			 pas_vec_s(4) <= '1'; 
		       ELSE 
			 pas_vec_s(4) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 6) THEN 
		       IF(data_in_s = p_lf) THEN 
			 pas_vec_s(5) <= '1'; 
		       ELSE 
			 pas_vec_s(5) <= '0';
		       END IF;
		     END IF;
		   END IF;
------------------------------------------------------------------------------
		   IF(sw_val_s = sw3) THEN					-- PASSWORD 4 abcd
                     IF(cnt_s = 1) THEN 
		       IF(data_in_s = p4_1) THEN
			 pas_vec_s(0) <= '1'; 
		       ELSE 
			 pas_vec_s(0) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 2) THEN 
                       IF(data_in_s = p4_2) THEN 
			 pas_vec_s(1) <= '1'; 
		       ELSE 
			 pas_vec_s(1) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 3) THEN 
                       IF(data_in_s = p4_3) THEN 
			 pas_vec_s(2) <= '1'; 
		       ELSE 
			 pas_vec_s(2) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 4) THEN 
		       IF(data_in_s = p4_4) THEN 
			 pas_vec_s(3) <= '1'; 
		       ELSE 
			 pas_vec_s(3) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 5) THEN 
		       IF(data_in_s = p_cr) THEN 
			 pas_vec_s(4) <= '1'; 
		       ELSE 
			 pas_vec_s(4) <= '0';
		       END IF;
		     END IF;
		     IF(cnt_s = 6) THEN 
		       IF(data_in_s = p_lf) THEN 
			 pas_vec_s(5) <= '1'; 
		       ELSE 
			 pas_vec_s(5) <= '0';
		       END IF;
		     END IF;
		   END IF;
------------------------------------------------------------------------------
		 IF (pas_vec_s = "111111") THEN
		   p_o <= '1';
		 ELSE
		   p_o <= '0';
		 END IF;
		 IF(iskluci = '1') THEN
		   p_o <= '0';
		   pas_vec_s <= (OTHERS => '0');
		 END IF;
	       END IF;
	END PROCESS;
------------------------------------------------------------------------------
END pass_a;
