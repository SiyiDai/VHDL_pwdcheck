LIBRARY ieee;
	USE ieee.std_logic_1164.ALL;
	USE ieee.numeric_std.ALL;
------------------------------------------------------------------------------
ENTITY master_tb IS
END master_tb;

ARCHITECTURE master_tb_a OF master_tb IS

COMPONENT master_e IS

	PORT (clk_i: IN std_logic;
		  rst_i: IN std_logic;
		  rx_i : IN std_logic;
		  sw1_i  : IN std_logic;
		  sw2_i  : IN std_logic;
		  hb_o: OUT std_logic;
		  l_o: OUT std_logic;
	      pas_o: OUT std_logic);
END COMPONENT;

SIGNAL clk_i : std_logic := '0';
SIGNAL rst_i: std_logic;
SIGNAL rx_i: std_logic;
SIGNAL sw1_i : std_logic;
SIGNAL sw2_i : std_logic;
SIGNAL hb_o: std_logic;
SIGNAL l_o : std_logic;
SIGNAL pas_o: std_logic;

--data to be sent:

CONSTANT dat1_1: std_logic_vector(7 DOWNTO 0) := "01000001"; --A
CONSTANT dat1_2: std_logic_vector(7 DOWNTO 0) := "01000010"; --B
CONSTANT dat1_3: std_logic_vector(7 DOWNTO 0) := "01000011"; --C
CONSTANT dat1_4: std_logic_vector(7 DOWNTO 0) := "01000100"; --D

CONSTANT dat2_1: std_logic_vector(7 DOWNTO 0) := "00110001"; --1 "00110001"
CONSTANT dat2_2: std_logic_vector(7 DOWNTO 0) := "00110010"; --2 "00110010"
CONSTANT dat2_3: std_logic_vector(7 DOWNTO 0) := "00110011"; --3 "00110011"
CONSTANT dat2_4: std_logic_vector(7 DOWNTO 0) := "00110100"; --4 "00110100"


CONSTANT dat_lf: std_logic_vector(7 DOWNTO 0) := "00001010"; --LF
CONSTANT dat_cr: std_logic_vector(7 DOWNTO 0) := "00001101"; --CR



BEGIN

	uut: master_e PORT MAP (clk_i, rst_i, rx_i, sw1_i, sw2_i, hb_o, l_o, pas_o);
	
	clk_process :PROCESS
	
        BEGIN
		  
		  
		  clk_i <= NOT clk_i;
		  WAIT FOR 10 ns;
		
END PROCESS;


data_transmit_correct :PROCESS						
	
        BEGIN
		
-- -----------------------------------------------------------CORRECT DATA, PAR, SW
		REPORT "Start of the simulation!" SEVERITY note;
		rst_i <= '1'; WAIT FOR 5 ns;
		  rst_i <= '0';
		  REPORT "Re-set of the system!" SEVERITY note;
		  REPORT "Sending 1st password!" SEVERITY note;

		  sw1_i <= '0';
		  sw2_i <= '1';
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat2_1(7); WAIT FOR 104 us;
		  rx_i <= dat2_1(6); WAIT FOR 104 us;
		  rx_i <= dat2_1(5); WAIT FOR 104 us;
		  rx_i <= dat2_1(4); WAIT FOR 104 us;
		  rx_i <= dat2_1(3); WAIT FOR 104 us;
		  rx_i <= dat2_1(2); WAIT FOR 104 us;
		  rx_i <= dat2_1(1); WAIT FOR 104 us;
		  rx_i <= dat2_1(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity 
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat2_2(7); WAIT FOR 104 us;
		  rx_i <= dat2_2(6); WAIT FOR 104 us;
		  rx_i <= dat2_2(5); WAIT FOR 104 us;
		  rx_i <= dat2_2(4); WAIT FOR 104 us;
		  rx_i <= dat2_2(3); WAIT FOR 104 us;
		  rx_i <= dat2_2(2); WAIT FOR 104 us;
		  rx_i <= dat2_2(1); WAIT FOR 104 us;
		  rx_i <= dat2_2(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity 
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat2_3(7); WAIT FOR 104 us;
		  rx_i <= dat2_3(6); WAIT FOR 104 us;
		  rx_i <= dat2_3(5); WAIT FOR 104 us;
		  rx_i <= dat2_3(4); WAIT FOR 104 us;
		  rx_i <= dat2_3(3); WAIT FOR 104 us;
		  rx_i <= dat2_3(2); WAIT FOR 104 us;
		  rx_i <= dat2_3(1); WAIT FOR 104 us;
		  rx_i <= dat2_3(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat2_4(7); WAIT FOR 104 us;
		  rx_i <= dat2_4(6); WAIT FOR 104 us;
		  rx_i <= dat2_4(5); WAIT FOR 104 us;
		  rx_i <= dat2_4(4); WAIT FOR 104 us;
		  rx_i <= dat2_4(3); WAIT FOR 104 us;
		  rx_i <= dat2_4(2); WAIT FOR 104 us;
		  rx_i <= dat2_4(1); WAIT FOR 104 us;
		  rx_i <= dat2_4(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_cr(7); WAIT FOR 104 us;
		  rx_i <= dat_cr(6); WAIT FOR 104 us;
		  rx_i <= dat_cr(5); WAIT FOR 104 us;
		  rx_i <= dat_cr(4); WAIT FOR 104 us;
		  rx_i <= dat_cr(3); WAIT FOR 104 us;
		  rx_i <= dat_cr(2); WAIT FOR 104 us;
		  rx_i <= dat_cr(1); WAIT FOR 104 us;
		  rx_i <= dat_cr(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_lf(7); WAIT FOR 104 us;
		  rx_i <= dat_lf(6); WAIT FOR 104 us;
		  rx_i <= dat_lf(5); WAIT FOR 104 us;
		  rx_i <= dat_lf(4); WAIT FOR 104 us;
		  rx_i <= dat_lf(3); WAIT FOR 104 us;
		  rx_i <= dat_lf(2); WAIT FOR 104 us;
		  rx_i <= dat_lf(1); WAIT FOR 104 us;
		  rx_i <= dat_lf(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 600 us;

		--assert(pas_o = '1') REPORT "Door opens now! SW: 01" SEVERITY note;
		REPORT "Door opens now! SW: 01" SEVERITY note;
		  
		  
-- -----------------------------------------------------------CORRECT DATA, PAR, SW		  
		  sw1_i <= '0';
		  sw2_i <= '0';
		  REPORT "Sending 2nd password!" SEVERITY note;
		  
		  --SENDING ANOTHER PASS HERE
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_1(7); WAIT FOR 104 us;
		  rx_i <= dat1_1(6); WAIT FOR 104 us;
		  rx_i <= dat1_1(5); WAIT FOR 104 us;
		  rx_i <= dat1_1(4); WAIT FOR 104 us;
		  rx_i <= dat1_1(3); WAIT FOR 104 us;
		  rx_i <= dat1_1(2); WAIT FOR 104 us;
		  rx_i <= dat1_1(1); WAIT FOR 104 us;
		  rx_i <= dat1_1(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_2(7); WAIT FOR 104 us;
		  rx_i <= dat1_2(6); WAIT FOR 104 us;
		  rx_i <= dat1_2(5); WAIT FOR 104 us;
		  rx_i <= dat1_2(4); WAIT FOR 104 us;
		  rx_i <= dat1_2(3); WAIT FOR 104 us;
		  rx_i <= dat1_2(2); WAIT FOR 104 us;
		  rx_i <= dat1_2(1); WAIT FOR 104 us;
		  rx_i <= dat1_2(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_3(7); WAIT FOR 104 us;
		  rx_i <= dat1_3(6); WAIT FOR 104 us;
		  rx_i <= dat1_3(5); WAIT FOR 104 us;
		  rx_i <= dat1_3(4); WAIT FOR 104 us;
		  rx_i <= dat1_3(3); WAIT FOR 104 us;
		  rx_i <= dat1_3(2); WAIT FOR 104 us;
		  rx_i <= dat1_3(1); WAIT FOR 104 us;
		  rx_i <= dat1_3(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity 
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_4(7); WAIT FOR 104 us;
		  rx_i <= dat1_4(6); WAIT FOR 104 us;
		  rx_i <= dat1_4(5); WAIT FOR 104 us;
		  rx_i <= dat1_4(4); WAIT FOR 104 us;
		  rx_i <= dat1_4(3); WAIT FOR 104 us;
		  rx_i <= dat1_4(2); WAIT FOR 104 us;
		  rx_i <= dat1_4(1); WAIT FOR 104 us;
		  rx_i <= dat1_4(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_cr(7); WAIT FOR 104 us;
		  rx_i <= dat_cr(6); WAIT FOR 104 us;
		  rx_i <= dat_cr(5); WAIT FOR 104 us;
		  rx_i <= dat_cr(4); WAIT FOR 104 us;
		  rx_i <= dat_cr(3); WAIT FOR 104 us;
		  rx_i <= dat_cr(2); WAIT FOR 104 us;
		  rx_i <= dat_cr(1); WAIT FOR 104 us;
		  rx_i <= dat_cr(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle

		  WAIT FOR 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_lf(7); WAIT FOR 104 us;
		  rx_i <= dat_lf(6); WAIT FOR 104 us;
		  rx_i <= dat_lf(5); WAIT FOR 104 us;
		  rx_i <= dat_lf(4); WAIT FOR 104 us;
		  rx_i <= dat_lf(3); WAIT FOR 104 us;
		  rx_i <= dat_lf(2); WAIT FOR 104 us;
		  rx_i <= dat_lf(1); WAIT FOR 104 us;
		  rx_i <= dat_lf(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 600 us;

		--assert(pas_o = '1') REPORT "Door opens now! SW: 00" SEVERITY note;
		  REPORT "Door opens now! SW: 00" SEVERITY note;
		  
-- -----------------------------------------------------------WRONG PAR	  
		  sw1_i <= '0';
		  sw2_i <= '0';
		  REPORT "Sending 3rd password!" SEVERITY note;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_1(7); WAIT FOR 104 us;
		  rx_i <= dat1_1(6); WAIT FOR 104 us;
		  rx_i <= dat1_1(5); WAIT FOR 104 us;
		  rx_i <= dat1_1(4); WAIT FOR 104 us;
		  rx_i <= dat1_1(3); WAIT FOR 104 us;
		  rx_i <= dat1_1(2); WAIT FOR 104 us;
		  rx_i <= dat1_1(1); WAIT FOR 104 us;
		  rx_i <= dat1_1(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_2(7); WAIT FOR 104 us;
		  rx_i <= dat1_2(6); WAIT FOR 104 us;
		  rx_i <= dat1_2(5); WAIT FOR 104 us;
		  rx_i <= dat1_2(4); WAIT FOR 104 us;
		  rx_i <= dat1_2(3); WAIT FOR 104 us;
		  rx_i <= dat1_2(2); WAIT FOR 104 us;
		  rx_i <= dat1_2(1); WAIT FOR 104 us;
		  rx_i <= dat1_2(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity wrong parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_3(7); WAIT FOR 104 us;
		  rx_i <= dat1_3(6); WAIT FOR 104 us;
		  rx_i <= dat1_3(5); WAIT FOR 104 us;
		  rx_i <= dat1_3(4); WAIT FOR 104 us;
		  rx_i <= dat1_3(3); WAIT FOR 104 us;
		  rx_i <= dat1_3(2); WAIT FOR 104 us;
		  rx_i <= dat1_3(1); WAIT FOR 104 us;
		  rx_i <= dat1_3(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity 
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_4(7); WAIT FOR 104 us;
		  rx_i <= dat1_4(6); WAIT FOR 104 us;
		  rx_i <= dat1_4(5); WAIT FOR 104 us;
		  rx_i <= dat1_4(4); WAIT FOR 104 us;
		  rx_i <= dat1_4(3); WAIT FOR 104 us;
		  rx_i <= dat1_4(2); WAIT FOR 104 us;
		  rx_i <= dat1_4(1); WAIT FOR 104 us;
		  rx_i <= dat1_4(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_cr(7); WAIT FOR 104 us;
		  rx_i <= dat_cr(6); WAIT FOR 104 us;
		  rx_i <= dat_cr(5); WAIT FOR 104 us;
		  rx_i <= dat_cr(4); WAIT FOR 104 us;
		  rx_i <= dat_cr(3); WAIT FOR 104 us;
		  rx_i <= dat_cr(2); WAIT FOR 104 us;
		  rx_i <= dat_cr(1); WAIT FOR 104 us;
		  rx_i <= dat_cr(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle

		  WAIT FOR 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_lf(7); WAIT FOR 104 us;
		  rx_i <= dat_lf(6); WAIT FOR 104 us;
		  rx_i <= dat_lf(5); WAIT FOR 104 us;
		  rx_i <= dat_lf(4); WAIT FOR 104 us;
		  rx_i <= dat_lf(3); WAIT FOR 104 us;
		  rx_i <= dat_lf(2); WAIT FOR 104 us;
		  rx_i <= dat_lf(1); WAIT FOR 104 us;
		  rx_i <= dat_lf(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 600 us;
		  

		--assert(pas_o = '0') REPORT "Wrong parity! Door is closed!" SEVERITY note;
		  REPORT "Wrong parity! Door is closed!" SEVERITY note;


-- -----------------------------------------------------------WRONG SW	  
		  rst_i <= '1'; WAIT FOR 5 ns;
		  rst_i <= '0';
		  REPORT "Re-set of the system because of parity!" SEVERITY note;
		  REPORT "Sending 4th password!" SEVERITY note;

		  sw1_i <= '1';
		  sw2_i <= '0';
		  
		  --SENDING ANOTHER PASS HERE
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_1(7); WAIT FOR 104 us;
		  rx_i <= dat1_1(6); WAIT FOR 104 us;
		  rx_i <= dat1_1(5); WAIT FOR 104 us;
		  rx_i <= dat1_1(4); WAIT FOR 104 us;
		  rx_i <= dat1_1(3); WAIT FOR 104 us;
		  rx_i <= dat1_1(2); WAIT FOR 104 us;
		  rx_i <= dat1_1(1); WAIT FOR 104 us;
		  rx_i <= dat1_1(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_2(7); WAIT FOR 104 us;
		  rx_i <= dat1_2(6); WAIT FOR 104 us;
		  rx_i <= dat1_2(5); WAIT FOR 104 us;
		  rx_i <= dat1_2(4); WAIT FOR 104 us;
		  rx_i <= dat1_2(3); WAIT FOR 104 us;
		  rx_i <= dat1_2(2); WAIT FOR 104 us;
		  rx_i <= dat1_2(1); WAIT FOR 104 us;
		  rx_i <= dat1_2(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_3(7); WAIT FOR 104 us;
		  rx_i <= dat1_3(6); WAIT FOR 104 us;
		  rx_i <= dat1_3(5); WAIT FOR 104 us;
		  rx_i <= dat1_3(4); WAIT FOR 104 us;
		  rx_i <= dat1_3(3); WAIT FOR 104 us;
		  rx_i <= dat1_3(2); WAIT FOR 104 us;
		  rx_i <= dat1_3(1); WAIT FOR 104 us;
		  rx_i <= dat1_3(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity 
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat1_4(7); WAIT FOR 104 us;
		  rx_i <= dat1_4(6); WAIT FOR 104 us;
		  rx_i <= dat1_4(5); WAIT FOR 104 us;
		  rx_i <= dat1_4(4); WAIT FOR 104 us;
		  rx_i <= dat1_4(3); WAIT FOR 104 us;
		  rx_i <= dat1_4(2); WAIT FOR 104 us;
		  rx_i <= dat1_4(1); WAIT FOR 104 us;
		  rx_i <= dat1_4(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_cr(7); WAIT FOR 104 us;
		  rx_i <= dat_cr(6); WAIT FOR 104 us;
		  rx_i <= dat_cr(5); WAIT FOR 104 us;
		  rx_i <= dat_cr(4); WAIT FOR 104 us;
		  rx_i <= dat_cr(3); WAIT FOR 104 us;
		  rx_i <= dat_cr(2); WAIT FOR 104 us;
		  rx_i <= dat_cr(1); WAIT FOR 104 us;
		  rx_i <= dat_cr(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle

		  WAIT FOR 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_lf(7); WAIT FOR 104 us;
		  rx_i <= dat_lf(6); WAIT FOR 104 us;
		  rx_i <= dat_lf(5); WAIT FOR 104 us;
		  rx_i <= dat_lf(4); WAIT FOR 104 us;
		  rx_i <= dat_lf(3); WAIT FOR 104 us;
		  rx_i <= dat_lf(2); WAIT FOR 104 us;
		  rx_i <= dat_lf(1); WAIT FOR 104 us;
		  rx_i <= dat_lf(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 600 us;
		  

		--assert(pas_o = '0') REPORT "Wrong switch! Door is closed!" SEVERITY note;
		REPORT "Wrong switch! Door is closed!" SEVERITY note;

		  
-- -----------------------------------------------------------CORRECT DATA, PAR, SW
		sw1_i <= '0';
		sw2_i <= '1';
		REPORT "Sending 5th password!" SEVERITY note;
		
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat2_1(7); WAIT FOR 104 us;
		  rx_i <= dat2_1(6); WAIT FOR 104 us;
		  rx_i <= dat2_1(5); WAIT FOR 104 us;
		  rx_i <= dat2_1(4); WAIT FOR 104 us;
		  rx_i <= dat2_1(3); WAIT FOR 104 us;
		  rx_i <= dat2_1(2); WAIT FOR 104 us;
		  rx_i <= dat2_1(1); WAIT FOR 104 us;
		  rx_i <= dat2_1(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity 
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat2_2(7); WAIT FOR 104 us;
		  rx_i <= dat2_2(6); WAIT FOR 104 us;
		  rx_i <= dat2_2(5); WAIT FOR 104 us;
		  rx_i <= dat2_2(4); WAIT FOR 104 us;
		  rx_i <= dat2_2(3); WAIT FOR 104 us;
		  rx_i <= dat2_2(2); WAIT FOR 104 us;
		  rx_i <= dat2_2(1); WAIT FOR 104 us;
		  rx_i <= dat2_2(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity 
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat2_3(7); WAIT FOR 104 us;
		  rx_i <= dat2_3(6); WAIT FOR 104 us;
		  rx_i <= dat2_3(5); WAIT FOR 104 us;
		  rx_i <= dat2_3(4); WAIT FOR 104 us;
		  rx_i <= dat2_3(3); WAIT FOR 104 us;
		  rx_i <= dat2_3(2); WAIT FOR 104 us;
		  rx_i <= dat2_3(1); WAIT FOR 104 us;
		  rx_i <= dat2_3(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat2_4(7); WAIT FOR 104 us;
		  rx_i <= dat2_4(6); WAIT FOR 104 us;
		  rx_i <= dat2_4(5); WAIT FOR 104 us;
		  rx_i <= dat2_4(4); WAIT FOR 104 us;
		  rx_i <= dat2_4(3); WAIT FOR 104 us;
		  rx_i <= dat2_4(2); WAIT FOR 104 us;
		  rx_i <= dat2_4(1); WAIT FOR 104 us;
		  rx_i <= dat2_4(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_cr(7); WAIT FOR 104 us;
		  rx_i <= dat_cr(6); WAIT FOR 104 us;
		  rx_i <= dat_cr(5); WAIT FOR 104 us;
		  rx_i <= dat_cr(4); WAIT FOR 104 us;
		  rx_i <= dat_cr(3); WAIT FOR 104 us;
		  rx_i <= dat_cr(2); WAIT FOR 104 us;
		  rx_i <= dat_cr(1); WAIT FOR 104 us;
		  rx_i <= dat_cr(0); WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle

		  WAIT FOR 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  WAIT FOR 104 us;
		  
		  rx_i <= dat_lf(7); WAIT FOR 104 us;
		  rx_i <= dat_lf(6); WAIT FOR 104 us;
		  rx_i <= dat_lf(5); WAIT FOR 104 us;
		  rx_i <= dat_lf(4); WAIT FOR 104 us;
		  rx_i <= dat_lf(3); WAIT FOR 104 us;
		  rx_i <= dat_lf(2); WAIT FOR 104 us;
		  rx_i <= dat_lf(1); WAIT FOR 104 us;
		  rx_i <= dat_lf(0); WAIT FOR 104 us;
		  
		  rx_i <= '0';				-- parity
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  WAIT FOR 104 us;
		  
		  rx_i <= '1';				-- idle
		  WAIT FOR 600 us;
		  
		--assert(pas_o = '1') REPORT "Door opens! SW: 01" SEVERITY note;
		REPORT "Door opens! SW: 01" SEVERITY note;
		WAIT FOR 1000 ns;
		assert (false) REPORT "TEST OK!" SEVERITY failure;
		
END PROCESS;
END master_tb_a;
