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
entity RXserie is
generic (
VAL_SAT_CONT : integer := 20000;
ANCHO_CONTADOR : integer :=20
);
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
data : out STD_LOGIC_VECTOR (19 downto 0);
valid: out STD_LOGIC;
RX : in STD_LOGIC
);      
end RXserie;


architecture Behavioral of RXserie is
type tipo_estado is
(reposo,b_start,b_0,b_1,b_2,b_3,b_4,b_5,b_6,b_7,b_8,b_9,b_10,b_11,b_12,b_13,b_14,b_15,b_16,b_17,b_18,b_19,b_stop);
signal estado,p_estado : tipo_estado;
-- contador interno 1 : contador del numero de ciclos
signal cont, p_cont: unsigned (14 downto 0);
-- contador interno 2 : se incrementa cada vez que se trasmite un bit
signal auxvalid,p_valid,primero,p_primero : STD_LOGIC;
signal auxdata,p_data : STD_LOGIC_VECTOR(19 downto 0);
begin


sinc : process (clk,reset)
begin
if (reset = '1') then
estado <= reposo;
cont <= (others =>'0');
auxdata<=(others =>'0');
auxvalid<='0';
primero<='0';
elsif(rising_edge(clk)) then
estado <= p_estado;
cont <= p_cont;
auxvalid <= p_valid;
auxdata<=p_data;
primero<=p_primero;
end if;
end process;


comb :process(cont,estado,auxvalid,auxdata,RX,primero)
begin
p_estado <= estado;
p_valid <= auxvalid;
p_cont <= cont;
p_data<=auxdata;
p_primero<=primero;
case estado is


when reposo =>
p_valid <= '0';
p_cont <= (others => '0');
if (RX= '0') then
p_estado <= b_start;
end if;






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
p_primero<='0';
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_0;
end if;


when b_0 =>
if(primero='0') then

p_data(0)<=RX;
p_primero<='1';
end if;

p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_1;
end if;


when b_1 =>
if(primero='1') then

p_data(1)<=RX;
p_primero<='0';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_2;
end if;


when b_2 =>
if(primero='0') then

p_data(2)<=RX;
p_primero<='1';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_3;
end if;


when b_3 =>
if(primero='1') then

p_data(3)<=RX;
p_primero<='0';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_4;
end if;


when b_4 =>
if(primero='0') then

p_data(4)<=RX;
p_primero<='1';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_5;
end if;


when b_5 =>
if(primero='1') then

p_data(5)<=RX;
p_primero<='0';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_6;
end if;


when b_6 =>
if(primero='0') then

p_data(6)<=RX;
p_primero<='1';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_7;
end if;


when b_7 =>
if(primero='1') then

p_data(7)<=RX;
p_primero<='0';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_8;
end if;

when b_8 =>
if(primero='0') then

p_data(8)<=RX;
p_primero<='1';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_9;
end if;

when b_9 =>
if(primero='1') then

p_data(9)<=RX;
p_primero<='0';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_10;
end if;

when b_10 =>
if(primero='0') then

p_data(10)<=RX;
p_primero<='1';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_11;
end if;

when b_11 =>
if(primero='1') then

p_data(11)<=RX;
p_primero<='0';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_12;
end if;

when b_12 =>
if(primero='0') then

p_data(12)<=RX;
p_primero<='1';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_13;
end if;

when b_13=>
if(primero='1') then

p_data(13)<=RX;
p_primero<='0';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_14;
end if;

when b_14 =>
if(primero='0') then

p_data(14)<=RX;
p_primero<='1';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_15;
end if;

when b_15 =>
if(primero='1') then

p_data(15)<=RX;
p_primero<='0';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_16;
end if;

when b_16 =>
if(primero='0') then

p_data(16)<=RX;
p_primero<='1';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_17;
end if;

when b_17 =>
if(primero='1') then

p_data(17)<=RX;
p_primero<='0';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_18;
end if;

when b_18=>
if(primero='0') then

p_data(18)<=RX;
p_primero<='1';
end if;
p_cont <= cont + 1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_estado <= b_19;
end if;

when b_19 =>
if(primero='1') then

p_data(19)<=RX;
p_primero<='0';
end if;
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
p_cont <= cont+1;
if (cont = VAL_SAT_CONT) then
p_cont <= (others => '0');
p_valid <='1';

p_estado <= reposo;
end if;
when others=>
p_estado<=reposo;
end case;
end process;
valid<=auxvalid;
data<=auxdata;
end Behavioral;
