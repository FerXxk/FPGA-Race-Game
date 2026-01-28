-------------------------------------------------------------------------
---------
-- Company:
-- Engineer:
--
-- Create Date: 08.11.2022 11:41:47
-- Design Name:
-- Module Name: FSM - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-------------------------------------------------------------------------
---------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity TXserie is
generic (
VAL_SAT_CONT : integer := 20000;
ANCHO_CONTADOR : integer :=20
);
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
data : in STD_LOGIC_VECTOR (19 downto 0);
valid: in STD_LOGIC;
TX : out STD_LOGIC;
ready : out STD_LOGIC);
end TXserie;


architecture Behavioral of TXserie is
type tipo_estado is
(reposo,inicio,b_start,b_0,b_1,b_2,b_3,b_4,b_5,b_6,b_7,b_8,b_9,b_10,b_11,b_12,b_13,b_14,b_15,b_16,b_17,b_18,b_19,b_stop);
signal estado,p_estado : tipo_estado;
-- contador interno 1 : contador del numero de ciclos
signal cont, p_cont: unsigned (14 downto 0);
-- contador interno 2 : se incrementa cada vez que se trasmite un bit
signal auxready,p_ready,texto,p_texto : STD_LOGIC;
begin



sinc : process (clk,reset)
begin
if (reset = '1') then
estado <= reposo;
cont <= (others =>'0');
texto<='1';
auxready<='1';
elsif(rising_edge(clk)) then
texto<=p_texto;
estado <= p_estado;
cont <= p_cont;
auxready <= p_ready;
end if;
end process;


comb :process(cont,data,valid,estado,auxready,texto)
begin
p_estado <= estado;
p_ready <= auxready;
p_cont <= cont;
p_texto<=texto;
case estado is


when reposo =>
p_texto <= '1';
p_ready <= '1';
p_cont <= (others => '0');
if (valid = '1') then
p_estado <= inicio;
end if;


when inicio =>
p_texto<='1';
p_ready<='0';
if(valid='0') then
p_estado <= b_start;
end if;
--TX <= '1';
--when espera =>
--TX <= '1';
--p_estado <= b_start;


--when test_data =>
--TX <= '1';
--if (data = "00000000") then
--p_estado <= no_button;
--else
--p_estado <= b_start;
--end if;


--when no_button =>

--p_estado <= reposo;



when b_start =>
p_texto <= '0';
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_0;
end if;


when b_0 =>
p_texto<=data(0);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_1;
end if;


when b_1 =>
p_texto<=data(1);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_2;
end if;


when b_2 =>
p_texto<=data(2);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_3;
end if;


when b_3 =>
p_texto<=data(3);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_4;
end if;


when b_4 =>
p_texto<=data(4);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_5;
end if;


when b_5 =>
p_texto<=data(5);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_6;
end if;


when b_6 =>
p_texto<=data(6);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_7;
end if;


when b_7 =>
p_texto<=data(7);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_8;
end if;

when b_8 =>
p_texto<=data(8);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_9;
end if;

when b_9 =>
p_texto<=data(9);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_10;
end if;

when b_10 =>
p_texto<=data(10);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_11;
end if;

when b_11 =>
p_texto<=data(11);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_12;
end if;

when b_12 =>
p_texto<=data(12);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_13;
end if;

when b_13=>
p_texto<=data(13);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_14;
end if;

when b_14 =>
p_texto<=data(14);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_15;
end if;

when b_15 =>
p_texto<=data(15);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_16;
end if;

when b_16 =>
p_texto<=data(16);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_17;
end if;

when b_17 =>
p_texto<=data(17);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_18;
end if;

when b_18=>
p_texto<=data(18);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_19;
end if;

when b_19 =>
p_texto<=data(19);
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_stop;
end if;



--when b_paridad =>
--TX <= data(0) xor data(1) xor data(2) xor data(3) xor data(4) xor
--data(5) xor data(6) xor data(7);
--p_cont <= cont + 1;
--if (cont = VAL_SAT_CONT) then
--p_cont <= (others => '0');
--p_estado <= b_stop;
--end if;


when b_stop =>
p_texto<= '1';
p_cont <= cont+1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= reposo;
end if;
when others => 
p_estado<=reposo;
end case;
end process;
ready<=auxready;
TX<=texto;
end Behavioral;
