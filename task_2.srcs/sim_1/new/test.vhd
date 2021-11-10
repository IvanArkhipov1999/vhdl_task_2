library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity test is end entity;

architecture rtl of test is
constant N : integer := 8;

signal reset, clk, in_tvalid, in_tlast : std_logic;
signal in_tdata : std_logic_vector(N - 1 downto 0);

procedure delay(n : integer; signal clk : std_logic) is
begin
  for i in 1 to n loop
    wait until clk'event and clk = '1' ;
  end loop;
end delay;

begin

DUT : entity work.polynomial generic map( N => N) port map 
(reset => reset, clk => clk, in_tvalid => in_tvalid, in_tlast => in_tlast,
in_tdata => in_tdata);

process is
begin
  clk <= '0';
  wait for 5 ns;
  clk <= '1';
  wait for 5 ns;
end process;

process is
begin
    -- 13
    reset <= '1';
    delay(1, clk);
    reset <= '0';
    delay(10, clk);
    in_tvalid <= '1';
    in_tlast <= '0';
    in_tdata <= std_logic_vector(conv_signed(5, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(2, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(3, N));
    in_tlast <= '1';
    delay(1, clk);
    in_tvalid <= '0';
    
    -- 69
    delay(10, clk);
    in_tvalid <= '1';
    in_tlast <= '0';
    in_tdata <= std_logic_vector(conv_signed(5, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(2, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(3, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(4, N));
    in_tlast <= '1';
    delay(1, clk);
    in_tvalid <= '0';
    
    -- 2
    delay(10, clk);
    in_tvalid <= '1';
    in_tlast <= '0';
    in_tdata <= std_logic_vector(conv_signed(5, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(2, N));
    in_tlast <= '1';
    delay(1, clk);
    in_tvalid <= '0';
 
    -- 19  
    delay(10, clk);
    in_tvalid <= '1';
    in_tlast <= '0';
    in_tdata <= std_logic_vector(conv_signed(5, N));
    delay(1, clk);
    in_tvalid <= '0';
    delay(10, clk);
    in_tvalid <= '1';
    in_tdata <= std_logic_vector(conv_signed(3, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(4, N));
    in_tlast <= '1';
    delay(1, clk);
    in_tvalid <= '0';
    
    -- 14
    delay(10, clk);
    in_tvalid <= '1';
    in_tlast <= '0';
    in_tdata <= std_logic_vector(conv_signed(5, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(2, N));
    delay(1, clk);
    in_tvalid <= '0';
    delay(10, clk);
    in_tvalid <= '1';
    in_tdata <= std_logic_vector(conv_signed(4, N));
    in_tlast <= '1';
    delay(1, clk);
    in_tvalid <= '0';
    
    -- 6
    delay(10, clk);
    in_tvalid <= '1';
    in_tlast <= '0';
    in_tdata <= std_logic_vector(conv_signed(5, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(6, N));
    in_tlast <= '1';
    delay(1, clk);
    -- 7
    in_tlast <= '0';
    in_tdata <= std_logic_vector(conv_signed(5, N));
    delay(1, clk);
    in_tdata <= std_logic_vector(conv_signed(7, N));
    in_tlast <= '1';
    delay(1, clk);
    in_tvalid <= '0';
    in_tvalid <= '0';
end process;

end rtl;