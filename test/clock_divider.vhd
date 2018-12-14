library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity clkDiv_e is 
port ( clk_i, rst_i : in std_logic;
       hb_o :         out std_logic);
end clkDiv_e;

architecture clkDiv_a of clkDiv_e is 

signal count_s: integer:=1;
signal tmp_s:   std_logic:='0';

begin

    process(clk_i,rst_i)
    begin
        if(rst_i = '1') then 
        count_s <= 1;
        tmp_s <= '0';
        elsif(clk_i'event and clk_i = '1') then
            count_s <= count_s+1;
            if (count_s = 25000000) then
                tmp_s <= NOT tmp_s;
                count_s <= 1;
            end if;
        end if;
        hb_o <= tmp_s;
    end process;

end clkDiv_a;
