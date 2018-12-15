LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.numeric_std.ALL;
-- -----------------------------------------------------------
PACKAGE package_p IS
-- -----------------------------------------------------------
CONSTANT int_1    : integer := 1;
CONSTANT int_2    : integer := 2;
CONSTANT int_3    : integer := 3;
CONSTANT int_4    : integer := 4;
CONSTANT int_5    : integer := 5;
CONSTANT int_6    : integer := 6;
CONSTANT int_7    : integer := 7;
CONSTANT int_10   : integer := 10;
CONSTANT int_11   : integer := 11;
CONSTANT int_13   : integer := 13;
CONSTANT int_15   : integer := 15;
CONSTANT int_6k   : integer := 6000;
CONSTANT int_6m   : integer := 6000000;
CONSTANT bd_cons  : integer := 5209;
CONSTANT trig_cons: integer := 2603;
CONSTANT hb_cnt   : integer := 5000000;
-- -----------------------------------------------------------
CONSTANT sw0: std_logic_vector(1 DOWNTO 0) := "00";
CONSTANT sw1: std_logic_vector(1 DOWNTO 0) := "01";
CONSTANT sw2: std_logic_vector(1 DOWNTO 0) := "10";
CONSTANT sw3: std_logic_vector(1 DOWNTO 0) := "11";
-- -----------------------------------------------------------
-- password 1:
CONSTANT p1_1: std_logic_vector(7 DOWNTO 0) := "01000001"; --A 
CONSTANT p1_2: std_logic_vector(7 DOWNTO 0) := "01000010"; --B 
CONSTANT p1_3: std_logic_vector(7 DOWNTO 0) := "01000011"; --C 
CONSTANT p1_4: std_logic_vector(7 DOWNTO 0) := "01000100"; --D 

-- password 2:
CONSTANT p2_1: std_logic_vector(7 DOWNTO 0) := "01000101"; --E 
CONSTANT p2_2: std_logic_vector(7 DOWNTO 0) := "01000110"; --F 
CONSTANT p2_3: std_logic_vector(7 DOWNTO 0) := "01000111"; --G 
CONSTANT p2_4: std_logic_vector(7 DOWNTO 0) := "01001000"; --H 

-- password 3:
CONSTANT p3_1: std_logic_vector(7 DOWNTO 0) := "00110001"; --1 
CONSTANT p3_2: std_logic_vector(7 DOWNTO 0) := "00110010"; --2 
CONSTANT p3_3: std_logic_vector(7 DOWNTO 0) := "00110011"; --3 
CONSTANT p3_4: std_logic_vector(7 DOWNTO 0) := "00110100"; --4 

-- password 4:
CONSTANT p4_1: std_logic_vector(7 DOWNTO 0) := "01100001"; --a 
CONSTANT p4_2: std_logic_vector(7 DOWNTO 0) := "01100010"; --b 
CONSTANT p4_3: std_logic_vector(7 DOWNTO 0) := "01100011"; --c 
CONSTANT p4_4: std_logic_vector(7 DOWNTO 0) := "01100100"; --d 

-- LF and CR
CONSTANT p_lf: std_logic_vector(7 DOWNTO 0) := "00001010"; --LF 
CONSTANT p_cr: std_logic_vector(7 DOWNTO 0) := "00001101"; --CR 
---------------------------------------------------------------

---------------------------------------------------------------
COMPONENT bd_e IS
  PORT(
    clk_i    : IN  std_logic;
    rst_i    : IN  std_logic;
    ena_i    : IN  std_logic;
    bd_t_o   : OUT std_logic
  );	
END COMPONENT;
---------------------------------------------------------------
COMPONENT uart_e IS
  PORT(
    clk_i    : IN  std_logic;
    rst_i    : IN  std_logic;
    bd_i     : IN  std_logic;
    rx_i     : IN  std_logic;
    dat_o    : OUT std_logic_vector(7 DOWNTO 0);
    ena_o    : OUT std_logic;
    l_o      : OUT std_logic;
    par_o    : OUT std_logic;
    mem_o    : OUT std_logic;
    flag_o   : OUT std_logic;
    cn_o     : OUT std_logic
    );	  
END COMPONENT;
---------------------------------------------------------------
COMPONENT mem_e IS
  PORT(
    clk_i    : IN  std_logic;
    rst_i    : IN  std_logic;
    par_i    : IN  std_logic;
    m_i      : IN  std_logic;
    mem_i    : IN  std_logic;
    dat_i    : IN  std_logic_vector (7 DOWNTO 0);
    fs_i     : IN  std_logic;
    g_o      : OUT std_logic;
    d_o      : OUT std_logic_vector (7 DOWNTO 0)
    );	
END COMPONENT;
---------------------------------------------------------------
COMPONENT pass_e IS
  PORT(
    clk_i    : IN  std_logic;
    rst_i    : IN  std_logic;
    s1_i     : IN  std_logic;
    s2_i     : IN  std_logic;
    dat_i    : IN  std_logic_vector(7 DOWNTO 0);
    g_i      : IN  std_logic;
    iskluci_i: IN  std_logic;
    m_o      : OUT std_logic;
    p_o      : OUT std_logic
    );
END COMPONENT;
---------------------------------------------------------------
COMPONENT hb_e IS
  PORT(
    clk_i    : IN  std_logic;
    rst_i    : IN  std_logic;
    hb_o     : OUT std_logic
    );	 
END COMPONENT;
---------------------------------------------------------------
END PACKAGE package_p;
