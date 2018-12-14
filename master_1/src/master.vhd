library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity master_e is

	port (clk_i: in std_logic;
		  rst_i: in std_logic;
		  rx_i : in std_logic;
		  sw1  : in std_logic;
		  sw2  : in std_logic;
		  l_o: out std_logic;
		  pas_o: out std_logic;
		  dat_o: out std_logic_vector(7 downto 0));
end master_e;

architecture master_a of master_e is


component uart_e is

	port(clk_i: in std_logic;
		  rst_i: in std_logic;
		  rx_i : in std_logic;
		  l_o: out std_logic;
		  par_o: out std_logic;
		  mem_o: out std_logic;
		  bd_tst: out std_logic;
		  dat_o: out std_logic_vector(7 downto 0);
		  flag_o: out std_logic;
		  cn_o: out std_logic);
end component;

component mem_e is

	port(clk_i: in std_logic;
		 rst_i: in std_logic;
		 par_i: in std_logic;
		 m_i  : in std_logic;
		 mem_i: in std_logic;
		 dat_i: in std_logic_vector (7 downto 0);
		 fs_i: in std_logic;
		 g_o: out std_logic;
		 d_o  : out std_logic_vector (7 downto 0));
end component;

component pass_e is

	port(clk_i: in std_logic;
		 rst_i: in std_logic;
		 s_i1 : in std_logic;
		 s_i2 : in std_logic;
		 dat_i: in std_logic_vector(7 downto 0);
		 g_i: in std_logic;
		 iskluci: in std_logic;
		 m_o  : out std_logic;
		 p_o  : out std_logic);
end component;


--signals UART
signal l_o_s: std_logic;
signal par_o_s: std_logic;
signal mem_o_s: std_logic;
signal bd_tst_s: std_logic;
signal dat_u_s: std_logic_vector(7 downto 0);
signal flag_o_s: std_logic;
signal cn_o_s: std_logic;

--signals MEMORY
signal dat_i_s: std_logic_vector (7 downto 0);
signal d_o_s  : std_logic_vector (7 downto 0);
signal m_i_s  : std_logic;
signal g_o_s: std_logic;
signal fs_i_s: std_logic;

--signals PASSWORD
signal m_o_s  : std_logic;
signal pass: std_logic;
signal g_i_s: std_logic;
signal iskluci_s: std_logic;

begin

	dat_o <= d_o_s;
	l_o <= l_o_s;
	
	m_i_s <= m_o_s;
	g_i_s <= g_o_s;

	pas_o <= pass;
	
	fs_i_s <= flag_o_s;
	iskluci_s <= cn_o_s;
	
	
	u_comp: uart_e port map (clk_i, rst_i, rx_i, l_o_s, par_o_s, mem_o_s, bd_tst_s, dat_u_s, flag_o_s, cn_o_s);
	m_comp: mem_e  port map (clk_i, rst_i, par_o_s, m_i_s, mem_o_s, dat_u_s, fs_i_s, g_o_s , d_o_s);
	p_comp: pass_e port map (clk_i, rst_i, sw1, sw2, d_o_s, g_i_s, iskluci_s, m_o_s, pass);


end master_a;
