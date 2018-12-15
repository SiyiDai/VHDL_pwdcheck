ARCHITECTURE hb_a OF hb_e IS
------------------------------------------------------------------------------
SIGNAL temp_s    : std_logic := '0';
SIGNAL cnt_s     : integer RANGE 0 TO int_6m := 0;
------------------------------------------------------------------------------
BEGIN
  hb_o <= temp_s;
------------------------------------------------------------------------------
hb_5Hz: PROCESS (clk_i, rst_i) 
          BEGIN
            IF (rst_i = '1') THEN
              temp_s <= '0';
              cnt_s <= 0;
	    ELSIF (rising_edge(clk_i)) THEN
	      IF (cnt_s = hb_cnt) THEN
		cnt_s <= 0;
                temp_s <= NOT temp_s; 
              ELSE
		cnt_s<= cnt_s + 1;
              END IF;
	    END IF;
        END PROCESS;
------------------------------------------------------------------------------
END hb_a;
