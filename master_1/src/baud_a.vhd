ARCHITECTURE bd_a OF bd_e IS
------------------------------------------------------------------------------
SIGNAL divider_s 	  : integer RANGE 0 TO int_6k := 0;
SIGNAL divider2_s 	  : integer RANGE 0 TO int_6k := 0;
SIGNAL bd_clk_s    	  : std_logic := '0';
SIGNAL trig_clk_s         : std_logic := '0';
------------------------------------------------------------------------------
BEGIN
  bd_t_o <= trig_clk_s;
------------------------------------------------------------------------------
-- this is the normal baud which can be turnd off as well
bd_9k6: PROCESS(clk_i, rst_i)
          BEGIN
	    IF (rst_i = '1') THEN
              divider_s <=  0 ;
	      bd_clk_s  <= '0';
	    ELSIF (rising_edge(clk_i)) THEN
	      IF (ena_i = '1') THEN     -- On each rising edge of the 50MHz clock, do the following...
		IF (divider_s < bd_cons) THEN  -- The number comes from system clock / desired baud !!!!!
		  divider_s <= divider_s + 1;  
		ELSE
		  divider_s <= 0;            -- reset counter back to 0.
		  bd_clk_s  <= NOT bd_clk_s;          -- Toggle the new output
		END IF; 
	      END IF;
	    END IF;
	END PROCESS;
------------------------------------------------------------------------------
--this is the baud used for triggering the signal
trig:   PROCESS (clk_i, rst_i)
	  BEGIN
            IF(rst_i = '1') THEN
	      trig_clk_s <= '0';
	      divider2_s <=  0 ;
	    ELSIF(rising_edge(clk_i)) THEN 
	      IF(ena_i = '1') THEN
	        IF(bd_clk_s = '1' AND divider2_s < bd_cons) THEN 	
		  IF(divider2_s = trig_cons) THEN
		    divider2_s <= divider2_s + 1;
		    trig_clk_s <= '1';
		  ELSE
		    divider2_s <= divider2_s + 1;
		    trig_clk_s <= '0';
		  END IF;
		ELSIF(bd_clk_s = '0' AND divider2_s < bd_cons) THEN
		  IF(divider2_s = trig_cons) THEN
		    divider2_s <= divider2_s + 1;
		    trig_clk_s <= '1';
		  ELSE
		    divider2_s <= divider2_s + 1;
		    trig_clk_s <= '0';
		  END IF;
		ELSE
		  divider2_s <=  0 ;
		  trig_clk_s <= '0';
		END IF;
	      ELSE
		trig_clk_s <= '0';
		divider2_s <=  0 ;
	      END IF;
	    END IF;
	END PROCESS;
------------------------------------------------------------------------------			
END bd_a;		
		
		

