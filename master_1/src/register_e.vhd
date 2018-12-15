LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.numeric_std.ALL;
    USE work.package_p.ALL;
---------------------------------------------------------------
ENTITY mem_e is
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
END mem_e;
