ARCHITECTURE master_a OF master_e IS
------------------------------------------------------------------------------
--signals BAUD
SIGNAL ena_i_s    : std_logic;
SIGNAL bd_o_s     : std_logic;
SIGNAL bd_t_s     : std_logic;
------------------------------------------------------------------------------
--signals UART
SIGNAL dat_u_s    : std_logic_vector(7 DOWNTO 0);
SIGNAL bd_i_s     : std_logic;
SIGNAL ena_o_s    : std_logic;
SIGNAL l_o_s      : std_logic;
SIGNAL par_o_s    : std_logic;
SIGNAL mem_o_s    : std_logic;
SIGNAL flag_o_s   : std_logic;
SIGNAL cn_o_s     : std_logic;
------------------------------------------------------------------------------
--signals MEMORY
SIGNAL dat_i_s    : std_logic_vector (7 DOWNTO 0);
SIGNAL d_o_s      : std_logic_vector (7 DOWNTO 0);
SIGNAL m_i_s      : std_logic;
SIGNAL g_o_s      : std_logic;
SIGNAL fs_i_s     : std_logic;
------------------------------------------------------------------------------
--signals PASSWORD
SIGNAL m_o_s      : std_logic;
SIGNAL pass_s     : std_logic;
SIGNAL g_i_s      : std_logic;
SIGNAL iskluci_s  : std_logic;
------------------------------------------------------------------------------
--signals HEART BEAT
SIGNAL hb_o_s     : std_logic;
------------------------------------------------------------------------------
BEGIN
  ena_i_s   <= ena_o_s;
  bd_i_s    <= bd_t_s;
  l_o       <= l_o_s;
  m_i_s     <= m_o_s;
  g_i_s     <= g_o_s;
  pas_o     <= pass_s;
  fs_i_s    <= flag_o_s;
  iskluci_s <= cn_o_s;
  hb_o      <= hb_o_s;
------------------------------------------------------------------------------
  b_com :  bd_e   PORT MAP (clk_i, rst_i, ena_i_s, bd_t_s);

  u_comp:  uart_e PORT MAP (clk_i, rst_i, bd_i_s, rx_i, ena_o_s, l_o_s, par_o_s, mem_o_s, dat_u_s, flag_o_s, cn_o_s);

  m_comp:  mem_e  PORT MAP (clk_i, rst_i, par_o_s, m_i_s, mem_o_s, dat_u_s, fs_i_s, g_o_s , d_o_s);

  p_comp:  pass_e PORT MAP (clk_i, rst_i, sw1_i, sw2_i, d_o_s, g_i_s, iskluci_s, m_o_s, pass_s);

  h_comp:  hb_e   PORT MAP (clk_i, rst_i, hb_o_s);
------------------------------------------------------------------------------
END master_a;
