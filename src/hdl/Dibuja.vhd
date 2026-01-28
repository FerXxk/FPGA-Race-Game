----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2023 21:41:02
-- Design Name: 
-- Module Name: Dibuja - Behavioral
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
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Dibuja is
  Port (eje_x : in STD_LOGIC_VECTOR (9 downto 0);
eje_y : in STD_LOGIC_VECTOR (9 downto 0);
refresh :in STD_LOGIC;
left : in STD_LOGIC;
right : in STD_LOGIC;
clk  : in STD_LOGIC;
reset : in STD_LOGIC;
start : in STD_LOGIC;
posxdef : out STD_LOGIC_VECTOR (9 downto 0);
ADIR: out STD_LOGIC_VECTOR(8 DOWNTO 0);
data: in STD_LOGIC_VECTOR(11 downto 0);
RED : out STD_LOGIC_VECTOR(3 downto 0);
GRN : out STD_LOGIC_VECTOR(3 downto 0);
BLU : out STD_LOGIC_VECTOR(3 downto 0);
muerte: in STD_LOGIC);
end Dibuja;

architecture Behavioral of Dibuja is
signal posx,p_posx: unsigned(9 downto 0);
signal posy : unsigned(9 downto 0);
signal posyabs,posxabs : unsigned(9 downto 0);

type tipo_estado is
(reposo,danzakuduro,muelte9999);
signal estado,p_estado : tipo_estado;

begin

sinc:process(clk,reset)
begin
    if (reset='1') then
        posx <="0001101001";
        estado<=reposo;
    elsif(rising_edge(clk))then
        posx <= p_posx;
        estado<=p_estado;
        end if;
end process;




comb: process(right,left,refresh,posx,estado,start,muerte)
begin
p_estado<=estado;
case estado is
when reposo =>
p_posx<=posx;
if(start='1') then
p_estado<=danzakuduro;
end if;
when danzakuduro =>

if(refresh='1')then
    if(left='1') then
    p_posx<=posx-1;
    elsif(right='1') then
    p_posx<=posx+1;
    else
    p_posx<=posx;
   end if;
else 
p_posx<=posx;
end if;
if(muerte='1') then
p_estado<=muelte9999;
end if;
when muelte9999=>
p_posx<=posx;
end case;
end process;


dibuja: process(eje_x, eje_y,posx,posy,posxabs,posyabs,data)
begin
posyabs<=posy+275;
RED<="0000"; GRN<="0000"; BLU<="0000";
adir <= (OTHERS => '1');
IF ((unsigned(posx) - 1 < unsigned(eje_x) AND unsigned(eje_x) < (unsigned(posx) + 16))) THEN
            IF ((unsigned(posyabs) - 1 < unsigned(eje_y) AND unsigned(eje_y) < (unsigned(posyabs) + 32))) THEN
                ADIR(3 DOWNTO 0) <= STD_LOGIC_VECTOR((unsigned(eje_x(3 DOWNTO 0)) - unsigned(posx(3 DOWNTO 0))));
                ADIR(8 DOWNTO 4) <= STD_LOGIC_VECTOR((unsigned(eje_y(4 DOWNTO 0)) - unsigned(posyabs(4 DOWNTO 0))));
                RED<=data(11 downto 8);GRN<=data(7 downto 4);BLU<=data(3 downto 0);
            END IF;
        END IF;
end process;
posxdef<=STD_LOGIC_VECTOR(posx);
end Behavioral;