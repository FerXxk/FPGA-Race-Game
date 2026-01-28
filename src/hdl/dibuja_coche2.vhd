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

entity dibuja_coche2 is
  Port (eje_x : in STD_LOGIC_VECTOR (9 downto 0);
eje_y : in STD_LOGIC_VECTOR (9 downto 0);
refresh :in STD_LOGIC;
clk  : in STD_LOGIC;
reset : in STD_LOGIC;
posxRX : in STD_LOGIC_VECTOR(9 downto 0);
ADIR: out STD_LOGIC_VECTOR(8 DOWNTO 0);
data: in STD_LOGIC_VECTOR(11 downto 0);
RED : out STD_LOGIC_VECTOR(3 downto 0);
GRN : out STD_LOGIC_VECTOR(3 downto 0);
BLU : out STD_LOGIC_VECTOR(3 downto 0)
);
end dibuja_coche2;

architecture Behavioral of dibuja_coche2 is
signal posx,p_posx: unsigned(9 downto 0);
signal posy : unsigned(9 downto 0);
signal posyabs,posxabs : unsigned(9 downto 0);

begin
p_posx<=unsigned(posxRX);
sinc:process(clk,reset)
begin
    if (reset='1') then
        posx <= (others => '0');
        
    elsif(rising_edge(clk))then
        posx <= p_posx;
        end if;
end process;


dibuja: process(eje_x, eje_y,posx,posy,posxabs,posyabs,data)
begin
posxabs<=posx+320;
posyabs<=posy+275;
RED<="0000"; GRN<="0000"; BLU<="0000";
adir <= (OTHERS => '1');
IF ((unsigned(posxabs) - 1 < unsigned(eje_x) AND unsigned(eje_x) < (unsigned(posxabs) + 16))) THEN
            IF ((unsigned(posyabs) - 1 < unsigned(eje_y) AND unsigned(eje_y) < (unsigned(posyabs) + 32))) THEN
                ADIR(3 DOWNTO 0) <= STD_LOGIC_VECTOR((unsigned(eje_x(3 DOWNTO 0)) - unsigned(posxabs(3 DOWNTO 0))));
                ADIR(8 DOWNTO 4) <= STD_LOGIC_VECTOR((unsigned(eje_y(4 DOWNTO 0)) - unsigned(posyabs(4 DOWNTO 0))));
                RED<=data(11 downto 8);GRN<=data(7 downto 4);BLU<=data(3 downto 0);
            END IF;
        END IF;
end process;

end Behavioral;