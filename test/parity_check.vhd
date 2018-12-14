library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity prtCk_e is 
port ( clk_i, rst_i : in std_logic;
       Rx_m_i :       in std_logic_vector (7 downto 0);
       led_prt_o :    out std_logic);
end prtCk_e;

architecture prtCk_a of prtCk_e is 

signal a_m_s: std_logic_vector(7 downto 1) := (others => '0');

begin

    a_m_s(1) <= Rx_m_i(0) xor Rx_m_i(1);
    a_m_s(2) <= Rx_m_i(1) xor a_m_s(1);
    a_m_s(3) <= Rx_m_i(2) xor a_m_s(2);
    a_m_s(4) <= Rx_m_i(3) xor a_m_s(3);
    a_m_s(5) <= Rx_m_i(4) xor a_m_s(4);
    a_m_s(6) <= Rx_m_i(5) xor a_m_s(5);
    a_m_s(7) <= Rx_m_i(6) xor a_m_s(6);
    led_prt_o <= Rx_m_i(7) xor a_m_s(7);

end prtCk_a;