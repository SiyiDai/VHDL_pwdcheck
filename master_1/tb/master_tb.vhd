library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity master_tb is
end master_tb;

architecture master_tb_a of master_tb is

component master_e is

	port (clk_i: in std_logic;
		  rst_i: in std_logic;
		  rx_i : in std_logic;
		  sw1  : in std_logic;
		  sw2  : in std_logic;
		  l_o: out std_logic;
	      pas_o: out std_logic;
		  dat_o: out std_logic_vector(7 downto 0));
end component;

signal clk_i : std_logic := '0';
signal rst_i: std_logic;
signal rx_i: std_logic;
signal sw1 : std_logic;
signal sw2 : std_logic;
signal l_o : std_logic;
signal pas_o: std_logic;
signal dat_o: std_logic_vector(7 downto 0);

--data to be sent:

constant dat1_1: std_logic_vector(7 downto 0) := "01000001"; --A
constant dat1_2: std_logic_vector(7 downto 0) := "01000010"; --B
constant dat1_3: std_logic_vector(7 downto 0) := "01000011"; --C
constant dat1_4: std_logic_vector(7 downto 0) := "01000100"; --D

constant dat2_1: std_logic_vector(7 downto 0) := "00110001"; --1 "00110001"
constant dat2_2: std_logic_vector(7 downto 0) := "00110010"; --2 "00110010"
constant dat2_3: std_logic_vector(7 downto 0) := "00110011"; --3 "00110011"
constant dat2_4: std_logic_vector(7 downto 0) := "00110100"; --4 "00110100"


signal dat_lf: std_logic_vector(7 downto 0) := "00001010"; --LF
signal dat_cr: std_logic_vector(7 downto 0) := "00001101"; --CR



begin

	uut: master_e port map (clk_i, rst_i, rx_i, sw1, sw2, l_o, pas_o, dat_o);
	
	clk_process :process
	
        begin
		  
		  rst_i <= '1'; wait for 5 ns;
		  rst_i <= '0';
		  report "Re-set of the system!" severity note;

		  sw1 <= '0';
		  sw2 <= '1';
		
          for Z in 1 to 420000
		  
          loop
            clk_i  <= '0'  ;
            wait for 10 ns; -- half period
            clk_i  <= '1'  ;
            wait for 10 ns; --half period
          end  loop;
		  
		  sw1 <= '0';
		  sw2 <= '0';
		
          for Z in 1 to 430000
		  
          loop
            clk_i  <= '0'  ;
            wait for 10 ns; -- half period
            clk_i  <= '1'  ;
            wait for 10 ns; --half period
          end  loop;
	
		  
		  sw1 <= '0';
		  sw2 <= '0';
		
          for Z in 1 to 440000
		  
          loop
            clk_i  <= '0'  ;
            wait for 10 ns; -- half period
            clk_i  <= '1'  ;
            wait for 10 ns; --half period
          end  loop;

		  
		  rst_i <= '1'; wait for 5 ns;
		  rst_i <= '0';
		  report "Re-set of the system because of parity!" severity note;

		  sw1 <= '1';
		  sw2 <= '0';
		
          for Z in 1 to 430000
		  
          loop
            clk_i  <= '0'  ;
            wait for 10 ns; -- half period
            clk_i  <= '1'  ;
            wait for 10 ns; --half period
          end  loop;

		  
		  sw1 <= '0';
		  sw2 <= '1';
		
          for Z in 1 to 600000
		  
          loop
            clk_i  <= '0'  ;
            wait for 10 ns; -- half period
            clk_i  <= '1'  ;
            wait for 10 ns; --half period
          end  loop;
	  
	--assert false report "End of test!";
        wait;
		
end process;


data_transmit_correct :process						
	
        begin
		
-- -----------------------------------------------------------CORRECT DATA, PAR, SW
		
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat2_1(7); wait for 104 us;
		  rx_i <= dat2_1(6); wait for 104 us;
		  rx_i <= dat2_1(5); wait for 104 us;
		  rx_i <= dat2_1(4); wait for 104 us;
		  rx_i <= dat2_1(3); wait for 104 us;
		  rx_i <= dat2_1(2); wait for 104 us;
		  rx_i <= dat2_1(1); wait for 104 us;
		  rx_i <= dat2_1(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity 
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat2_2(7); wait for 104 us;
		  rx_i <= dat2_2(6); wait for 104 us;
		  rx_i <= dat2_2(5); wait for 104 us;
		  rx_i <= dat2_2(4); wait for 104 us;
		  rx_i <= dat2_2(3); wait for 104 us;
		  rx_i <= dat2_2(2); wait for 104 us;
		  rx_i <= dat2_2(1); wait for 104 us;
		  rx_i <= dat2_2(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity 
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat2_3(7); wait for 104 us;
		  rx_i <= dat2_3(6); wait for 104 us;
		  rx_i <= dat2_3(5); wait for 104 us;
		  rx_i <= dat2_3(4); wait for 104 us;
		  rx_i <= dat2_3(3); wait for 104 us;
		  rx_i <= dat2_3(2); wait for 104 us;
		  rx_i <= dat2_3(1); wait for 104 us;
		  rx_i <= dat2_3(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat2_4(7); wait for 104 us;
		  rx_i <= dat2_4(6); wait for 104 us;
		  rx_i <= dat2_4(5); wait for 104 us;
		  rx_i <= dat2_4(4); wait for 104 us;
		  rx_i <= dat2_4(3); wait for 104 us;
		  rx_i <= dat2_4(2); wait for 104 us;
		  rx_i <= dat2_4(1); wait for 104 us;
		  rx_i <= dat2_4(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_cr(7); wait for 104 us;
		  rx_i <= dat_cr(6); wait for 104 us;
		  rx_i <= dat_cr(5); wait for 104 us;
		  rx_i <= dat_cr(4); wait for 104 us;
		  rx_i <= dat_cr(3); wait for 104 us;
		  rx_i <= dat_cr(2); wait for 104 us;
		  rx_i <= dat_cr(1); wait for 104 us;
		  rx_i <= dat_cr(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_lf(7); wait for 104 us;
		  rx_i <= dat_lf(6); wait for 104 us;
		  rx_i <= dat_lf(5); wait for 104 us;
		  rx_i <= dat_lf(4); wait for 104 us;
		  rx_i <= dat_lf(3); wait for 104 us;
		  rx_i <= dat_lf(2); wait for 104 us;
		  rx_i <= dat_lf(1); wait for 104 us;
		  rx_i <= dat_lf(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 600 us;

		--assert(pas_o = '1') report "Door opens now! SW: 01" severity note;
		report "First password sent!" severity note;
		report "Door opens now! SW: 01" severity note;
		  
		  
-- -----------------------------------------------------------CORRECT DATA, PAR, SW		  
		  
		  
		  --SENDING ANOTHER PASS HERE
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_1(7); wait for 104 us;
		  rx_i <= dat1_1(6); wait for 104 us;
		  rx_i <= dat1_1(5); wait for 104 us;
		  rx_i <= dat1_1(4); wait for 104 us;
		  rx_i <= dat1_1(3); wait for 104 us;
		  rx_i <= dat1_1(2); wait for 104 us;
		  rx_i <= dat1_1(1); wait for 104 us;
		  rx_i <= dat1_1(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_2(7); wait for 104 us;
		  rx_i <= dat1_2(6); wait for 104 us;
		  rx_i <= dat1_2(5); wait for 104 us;
		  rx_i <= dat1_2(4); wait for 104 us;
		  rx_i <= dat1_2(3); wait for 104 us;
		  rx_i <= dat1_2(2); wait for 104 us;
		  rx_i <= dat1_2(1); wait for 104 us;
		  rx_i <= dat1_2(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_3(7); wait for 104 us;
		  rx_i <= dat1_3(6); wait for 104 us;
		  rx_i <= dat1_3(5); wait for 104 us;
		  rx_i <= dat1_3(4); wait for 104 us;
		  rx_i <= dat1_3(3); wait for 104 us;
		  rx_i <= dat1_3(2); wait for 104 us;
		  rx_i <= dat1_3(1); wait for 104 us;
		  rx_i <= dat1_3(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity 
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_4(7); wait for 104 us;
		  rx_i <= dat1_4(6); wait for 104 us;
		  rx_i <= dat1_4(5); wait for 104 us;
		  rx_i <= dat1_4(4); wait for 104 us;
		  rx_i <= dat1_4(3); wait for 104 us;
		  rx_i <= dat1_4(2); wait for 104 us;
		  rx_i <= dat1_4(1); wait for 104 us;
		  rx_i <= dat1_4(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_cr(7); wait for 104 us;
		  rx_i <= dat_cr(6); wait for 104 us;
		  rx_i <= dat_cr(5); wait for 104 us;
		  rx_i <= dat_cr(4); wait for 104 us;
		  rx_i <= dat_cr(3); wait for 104 us;
		  rx_i <= dat_cr(2); wait for 104 us;
		  rx_i <= dat_cr(1); wait for 104 us;
		  rx_i <= dat_cr(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle

		  wait for 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_lf(7); wait for 104 us;
		  rx_i <= dat_lf(6); wait for 104 us;
		  rx_i <= dat_lf(5); wait for 104 us;
		  rx_i <= dat_lf(4); wait for 104 us;
		  rx_i <= dat_lf(3); wait for 104 us;
		  rx_i <= dat_lf(2); wait for 104 us;
		  rx_i <= dat_lf(1); wait for 104 us;
		  rx_i <= dat_lf(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 600 us;

		--assert(pas_o = '1') report "Door opens now! SW: 00" severity note;
		report "Second password sent!" severity note;
		  report "Door opens now! SW: 00" severity note;
		  
-- -----------------------------------------------------------WRONG PAR	  
		  
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_1(7); wait for 104 us;
		  rx_i <= dat1_1(6); wait for 104 us;
		  rx_i <= dat1_1(5); wait for 104 us;
		  rx_i <= dat1_1(4); wait for 104 us;
		  rx_i <= dat1_1(3); wait for 104 us;
		  rx_i <= dat1_1(2); wait for 104 us;
		  rx_i <= dat1_1(1); wait for 104 us;
		  rx_i <= dat1_1(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_2(7); wait for 104 us;
		  rx_i <= dat1_2(6); wait for 104 us;
		  rx_i <= dat1_2(5); wait for 104 us;
		  rx_i <= dat1_2(4); wait for 104 us;
		  rx_i <= dat1_2(3); wait for 104 us;
		  rx_i <= dat1_2(2); wait for 104 us;
		  rx_i <= dat1_2(1); wait for 104 us;
		  rx_i <= dat1_2(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity !!!!!!!!!!!
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_3(7); wait for 104 us;
		  rx_i <= dat1_3(6); wait for 104 us;
		  rx_i <= dat1_3(5); wait for 104 us;
		  rx_i <= dat1_3(4); wait for 104 us;
		  rx_i <= dat1_3(3); wait for 104 us;
		  rx_i <= dat1_3(2); wait for 104 us;
		  rx_i <= dat1_3(1); wait for 104 us;
		  rx_i <= dat1_3(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity 
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_4(7); wait for 104 us;
		  rx_i <= dat1_4(6); wait for 104 us;
		  rx_i <= dat1_4(5); wait for 104 us;
		  rx_i <= dat1_4(4); wait for 104 us;
		  rx_i <= dat1_4(3); wait for 104 us;
		  rx_i <= dat1_4(2); wait for 104 us;
		  rx_i <= dat1_4(1); wait for 104 us;
		  rx_i <= dat1_4(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_cr(7); wait for 104 us;
		  rx_i <= dat_cr(6); wait for 104 us;
		  rx_i <= dat_cr(5); wait for 104 us;
		  rx_i <= dat_cr(4); wait for 104 us;
		  rx_i <= dat_cr(3); wait for 104 us;
		  rx_i <= dat_cr(2); wait for 104 us;
		  rx_i <= dat_cr(1); wait for 104 us;
		  rx_i <= dat_cr(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle

		  wait for 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_lf(7); wait for 104 us;
		  rx_i <= dat_lf(6); wait for 104 us;
		  rx_i <= dat_lf(5); wait for 104 us;
		  rx_i <= dat_lf(4); wait for 104 us;
		  rx_i <= dat_lf(3); wait for 104 us;
		  rx_i <= dat_lf(2); wait for 104 us;
		  rx_i <= dat_lf(1); wait for 104 us;
		  rx_i <= dat_lf(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 600 us;
		  

		--assert(pas_o = '0') report "Wrong parity! Door is closed!" severity note;
		report "Third password sent!" severity note;
		  report "Wrong parity! Door is closed!" severity note;


-- -----------------------------------------------------------WRONG SW	  
		  
		  
		  --SENDING ANOTHER PASS HERE
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_1(7); wait for 104 us;
		  rx_i <= dat1_1(6); wait for 104 us;
		  rx_i <= dat1_1(5); wait for 104 us;
		  rx_i <= dat1_1(4); wait for 104 us;
		  rx_i <= dat1_1(3); wait for 104 us;
		  rx_i <= dat1_1(2); wait for 104 us;
		  rx_i <= dat1_1(1); wait for 104 us;
		  rx_i <= dat1_1(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_2(7); wait for 104 us;
		  rx_i <= dat1_2(6); wait for 104 us;
		  rx_i <= dat1_2(5); wait for 104 us;
		  rx_i <= dat1_2(4); wait for 104 us;
		  rx_i <= dat1_2(3); wait for 104 us;
		  rx_i <= dat1_2(2); wait for 104 us;
		  rx_i <= dat1_2(1); wait for 104 us;
		  rx_i <= dat1_2(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_3(7); wait for 104 us;
		  rx_i <= dat1_3(6); wait for 104 us;
		  rx_i <= dat1_3(5); wait for 104 us;
		  rx_i <= dat1_3(4); wait for 104 us;
		  rx_i <= dat1_3(3); wait for 104 us;
		  rx_i <= dat1_3(2); wait for 104 us;
		  rx_i <= dat1_3(1); wait for 104 us;
		  rx_i <= dat1_3(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity 
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat1_4(7); wait for 104 us;
		  rx_i <= dat1_4(6); wait for 104 us;
		  rx_i <= dat1_4(5); wait for 104 us;
		  rx_i <= dat1_4(4); wait for 104 us;
		  rx_i <= dat1_4(3); wait for 104 us;
		  rx_i <= dat1_4(2); wait for 104 us;
		  rx_i <= dat1_4(1); wait for 104 us;
		  rx_i <= dat1_4(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_cr(7); wait for 104 us;
		  rx_i <= dat_cr(6); wait for 104 us;
		  rx_i <= dat_cr(5); wait for 104 us;
		  rx_i <= dat_cr(4); wait for 104 us;
		  rx_i <= dat_cr(3); wait for 104 us;
		  rx_i <= dat_cr(2); wait for 104 us;
		  rx_i <= dat_cr(1); wait for 104 us;
		  rx_i <= dat_cr(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle

		  wait for 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_lf(7); wait for 104 us;
		  rx_i <= dat_lf(6); wait for 104 us;
		  rx_i <= dat_lf(5); wait for 104 us;
		  rx_i <= dat_lf(4); wait for 104 us;
		  rx_i <= dat_lf(3); wait for 104 us;
		  rx_i <= dat_lf(2); wait for 104 us;
		  rx_i <= dat_lf(1); wait for 104 us;
		  rx_i <= dat_lf(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 600 us;
		  

		--assert(pas_o = '0') report "Wrong switch! Door is closed!" severity note;
		report "Fourth password sent!" severity note;
		  report "Wrong switch! Door is closed!" severity note;

		  
-- -----------------------------------------------------------CORRECT DATA, PAR, SW
		
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat2_1(7); wait for 104 us;
		  rx_i <= dat2_1(6); wait for 104 us;
		  rx_i <= dat2_1(5); wait for 104 us;
		  rx_i <= dat2_1(4); wait for 104 us;
		  rx_i <= dat2_1(3); wait for 104 us;
		  rx_i <= dat2_1(2); wait for 104 us;
		  rx_i <= dat2_1(1); wait for 104 us;
		  rx_i <= dat2_1(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity 
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 2 
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat2_2(7); wait for 104 us;
		  rx_i <= dat2_2(6); wait for 104 us;
		  rx_i <= dat2_2(5); wait for 104 us;
		  rx_i <= dat2_2(4); wait for 104 us;
		  rx_i <= dat2_2(3); wait for 104 us;
		  rx_i <= dat2_2(2); wait for 104 us;
		  rx_i <= dat2_2(1); wait for 104 us;
		  rx_i <= dat2_2(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity 
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 3
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat2_3(7); wait for 104 us;
		  rx_i <= dat2_3(6); wait for 104 us;
		  rx_i <= dat2_3(5); wait for 104 us;
		  rx_i <= dat2_3(4); wait for 104 us;
		  rx_i <= dat2_3(3); wait for 104 us;
		  rx_i <= dat2_3(2); wait for 104 us;
		  rx_i <= dat2_3(1); wait for 104 us;
		  rx_i <= dat2_3(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package 4
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat2_4(7); wait for 104 us;
		  rx_i <= dat2_4(6); wait for 104 us;
		  rx_i <= dat2_4(5); wait for 104 us;
		  rx_i <= dat2_4(4); wait for 104 us;
		  rx_i <= dat2_4(3); wait for 104 us;
		  rx_i <= dat2_4(2); wait for 104 us;
		  rx_i <= dat2_4(1); wait for 104 us;
		  rx_i <= dat2_4(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 200 us;
		  
		  --package CR 0000 1101
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_cr(7); wait for 104 us;
		  rx_i <= dat_cr(6); wait for 104 us;
		  rx_i <= dat_cr(5); wait for 104 us;
		  rx_i <= dat_cr(4); wait for 104 us;
		  rx_i <= dat_cr(3); wait for 104 us;
		  rx_i <= dat_cr(2); wait for 104 us;
		  rx_i <= dat_cr(1); wait for 104 us;
		  rx_i <= dat_cr(0); wait for 104 us;
		  
		  rx_i <= '1';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle

		  wait for 200 us;

		-- package LN 0000 1010
		  
		  rx_i <= '0';				-- start bit
		  wait for 104 us;
		  
		  rx_i <= dat_lf(7); wait for 104 us;
		  rx_i <= dat_lf(6); wait for 104 us;
		  rx_i <= dat_lf(5); wait for 104 us;
		  rx_i <= dat_lf(4); wait for 104 us;
		  rx_i <= dat_lf(3); wait for 104 us;
		  rx_i <= dat_lf(2); wait for 104 us;
		  rx_i <= dat_lf(1); wait for 104 us;
		  rx_i <= dat_lf(0); wait for 104 us;
		  
		  rx_i <= '0';				-- parity
		  wait for 104 us;
		  
		  rx_i <= '1';				-- stop bit
		  wait for 104 us;
		  
		  rx_i <= '1';				-- idle
		  wait for 600 us;
		  
		--assert(pas_o = '1') report "Door opens! SW: 01" severity note;
		  report "Door opens! SW: 01" severity note;
		report "Fifth password sent!" severity note;  
		--assert false report "Data sent!";
        	wait;
		
end process;
end master_tb_a;
