LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
    USE ieee.numeric_std.ALL;
    USE work.package_p.ALL;
---------------------------------------------------------------
ENTITY pass_e IS
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
END pass_e;
