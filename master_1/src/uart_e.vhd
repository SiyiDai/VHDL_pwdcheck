LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.numeric_std.ALL;
    USE work.package_p.ALL;
---------------------------------------------------------------
ENTITY uart_e IS 
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
END uart_e;
