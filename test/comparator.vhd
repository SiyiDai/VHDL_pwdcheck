--libraries to be used are specified here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--entity declaration with port definitions
entity cpr_e is
port(   clk_i, rst_i :  in std_logic;
        mmr_i :         in std_logic_vector(31 downto 0);  --input 1
        psw_i :         in std_logic_vector(31 downto 0);  --input 2
        led_d_o :       out std_logic   -- wether they are equal
);
end cpr_e;

--architecture of entity
architecture cpr_a of cpr_e is
    signal mp_s:        std_logic_vector(31 downto 0);  -- temporary variables
    signal result_s:    std_logic
    begin
        -- compare every bit
        mp_s(0) <= (not mmr_i(0)) xnor (not psw_i(0));
        mp_s(1) <= (not mmr_i(1)) xnor (not psw_i(1));
        mp_s(2) <= (not mmr_i(2)) xnor (not psw_i(2));
        mp_s(3) <= (not mmr_i(3)) xnor (not psw_i(3));
        mp_s(4) <= (not mmr_i(4)) xnor (not psw_i(4));
        mp_s(5) <= (not mmr_i(5)) xnor (not psw_i(5));
        mp_s(6) <= (not mmr_i(6)) xnor (not psw_i(6));
        mp_s(7) <= (not mmr_i(7)) xnor (not psw_i(7));
        mp_s(8) <= (not mmr_i(8)) xnor (not psw_i(8));
        mp_s(9) <= (not mmr_i(9)) xnor (not psw_i(9));
        mp_s(10) <= (not mmr_i(10)) xnor (not psw_i(10));
        mp_s(11) <= (not mmr_i(11)) xnor (not psw_i(11));
        mp_s(12) <= (not mmr_i(12)) xnor (not psw_i(12));
        mp_s(13) <= (not mmr_i(13)) xnor (not psw_i(13));
        mp_s(14) <= (not mmr_i(14)) xnor (not psw_i(14));
        mp_s(15) <= (not mmr_i(15)) xnor (not psw_i(15));
        mp_s(16) <= (not mmr_i(16)) xnor (not psw_i(16));
        mp_s(17) <= (not mmr_i(17)) xnor (not psw_i(17));
        mp_s(18) <= (not mmr_i(18)) xnor (not psw_i(18));
        mp_s(19) <= (not mmr_i(19)) xnor (not psw_i(19));
        mp_s(20) <= (not mmr_i(20)) xnor (not psw_i(20));
        mp_s(21) <= (not mmr_i(21)) xnor (not psw_i(21));
        mp_s(22) <= (not mmr_i(22)) xnor (not psw_i(22));
        mp_s(23) <= (not mmr_i(23)) xnor (not psw_i(23));
        mp_s(24) <= (not mmr_i(24)) xnor (not psw_i(24));
        mp_s(25) <= (not mmr_i(25)) xnor (not psw_i(25));
        mp_s(26) <= (not mmr_i(26)) xnor (not psw_i(26));
        mp_s(27) <= (not mmr_i(27)) xnor (not psw_i(27));
        mp_s(28) <= (not mmr_i(28)) xnor (not psw_i(28));
        mp_s(29) <= (not mmr_i(29)) xnor (not psw_i(29));
        mp_s(30) <= (not mmr_i(30)) xnor (not psw_i(30));
        mp_s(31) <= (not mmr_i(31)) xnor (not psw_i(31));
         
        -- the 'not' for both signal is to make the signal stronger based on the 74L521 model(old one)

        -- compare 8 bits
        --cmp1_s <= '1' when (mmr1_i = psw1_i) else '0';
        --cmp2_s <= '1' when (mmr2_i = psw2_i) else '0';
        --cmp3_s <= '1' when (mmr3_i = psw3_i) else '0';
        --cmp4_s <= '1' when (mmr4_i = psw4_i) else '0';


        
        process(clk_i, rst_i)
        begin    -- process starts with a 'begin' statement
        if(rising_edge(clk_i))then
            if(mp_s = '0') then         
                  -- check whether memory = password
                    result_s <= '1';
            else
                    result_s <= '0';
                end if;
            end if;
        end process;

        led_d_o <= result_s;

end cpr_a;