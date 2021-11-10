library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity polynomial is
    generic ( N : integer := 16 );
    port (
--        reset импульс
        reset : in std_logic;
--        тактовый импульс
        clk : in std_logic;
--        маркирует наличие данных в потоке в текущем такте
        in_tvalid : in std_logic;
--        маркирует конец пакета
        in_tlast : in std_logic;
--        входные данные
        in_tdata : in std_logic_vector(N - 1 downto 0);
--        маркирует наличие данных в потоке в текущем такте
        out_tvalid : out std_logic;
--        выходные данные
        out_tdata : out std_logic_vector(N - 1 downto 0)
    );
end polynomial;

architecture rtl of polynomial is
signal is_started : std_logic;
signal is_first : std_logic;
signal is_end : std_logic;
signal is_definitly_end : std_logic;
signal x : unsigned(N - 1 downto 0);
signal current : unsigned(N - 1 downto 0);
begin
    process (clk) is
    variable a : unsigned(2 * N - 1 downto 0);
    begin
    if clk'event and clk = '1' then
      if reset = '1' then
         is_started <= '0';
         is_definitly_end <= '0';
         is_end <= '1';
      else 
            if in_tvalid = '1' then
                if is_started = '0' and is_end = '1' then
                    x <= unsigned(in_tdata);
                    is_started <= '1';
                    is_end <= '0';
                    is_first <= '1';
                    is_definitly_end <= '0';
                else 
                    if is_first = '1' then
                        current <= unsigned(in_tdata);
                        is_first <= '0';
                    else
                        a := x * current;
                        current <= unsigned(in_tdata) + a(N - 1 downto 0);
                    end if;
                    
                    if in_tlast = '1' then
                       is_started <= '0';
                       is_end <= in_tlast;
                       is_definitly_end <= in_tlast;
                    end if;
                end if;
            else
                if is_end /= '0' then     
                    is_started <= '0';
                    is_definitly_end <= '0';
                end if;
            end if;
        end if;
    end if;
    end process;
    
    out_tvalid <= is_definitly_end;
    out_tdata <= std_logic_vector(current);
end rtl;
