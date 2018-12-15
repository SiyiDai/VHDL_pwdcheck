LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.numeric_std.ALL;
    USE work.package_p.ALL;
------------------------------------------------------------------------------
ENTITY bd_e IS
PORT(
  clk_i      : IN  std_logic;
  rst_i      : IN  std_logic;
  ena_i      : IN  std_logic;
  bd_t_o     : OUT std_logic
  );
END bd_e;
