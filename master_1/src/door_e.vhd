LIBRARY ieee;
	USE ieee.std_logic_1164.ALL;
	USE ieee.numeric_std.ALL;
	USE work.package_p.ALL;
------------------------------------------------------------------------------
ENTITY master_e IS
PORT(
  clk_i     : IN  std_logic;
  rst_i     : IN  std_logic;
  rx_i      : IN  std_logic;
  sw1_i     : IN  std_logic;
  sw2_i     : IN  std_logic;
  l_o       : OUT std_logic;
  hb_o      : OUT std_logic;
  pas_o     : OUT std_logic
  );
END master_e;
