
-------------------------------------------------------------------------
---------
-- Company:
-- Engineer:
--
-- Create Date: 08.11.2022 12:44:04
-- Design Name:
-- Module Name: serie - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity FSM_TX is
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
ready : in STD_LOGIC;
valid : out STD_LOGIC;
posx : in STD_LOGIC_VECTOR(9 DOWNTO 0);
poscircuito : in STD_LOGIC_VECTOR(9 DOWNTO 0);
data :  out STD_LOGIC_VECTOR(19 DOWNTO 0));
end FSM_TX;

architecture Behavioral of FSM_TX is

type tipo_estado2 is
(reposo,espera_ready,tx_posx);
signal estado2,p_estado2:tipo_estado2;
signal auxdata, p_auxdata: STD_LOGIC_VECTOR(19 downto 0);
signal valido,p_valido : STD_LOGIC;
begin

sinc : process (clk,reset)
begin
if (reset = '1') then
estado2 <=reposo;
auxdata <=(others=>'0');
valido<= '0';
elsif(rising_edge(clk)) then
estado2 <= p_estado2;
auxdata<=p_auxdata;
valido<=p_valido;
end if;
end process;

comb :process(estado2,ready,posx,auxdata,valido,poscircuito)
begin
p_estado2 <= estado2;
p_auxdata<=auxdata;
p_valido<=valido;
case estado2 is
when reposo=>
p_valido<='0';
p_estado2<=espera_ready;

when espera_ready=> 
if(ready='1') then

p_estado2<=tx_posx;
end if;

when tx_posx=>
p_auxdata(19 downto 10)<=posx;
p_auxdata(9 downto 0)<=poscircuito;
p_valido<='1';
p_estado2<=reposo;
when others=> 
p_estado2<=reposo;
end case;
end process;

data<=auxdata ;
valid<=valido;

end Behavioral;
