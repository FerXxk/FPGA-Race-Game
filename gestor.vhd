----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2023 11:24:11
-- Design Name: 
-- Module Name: gestor - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity gestor is
 Port ( 
RGB_coche: in STD_LOGIC_VECTOR(11 downto 0);
RGB_coche2:in STD_LOGIC_VECTOR(11 downto 0);
RGB_circuito: in STD_LOGIC_VECTOR(11 downto 0);
RGB_circuito2: in STD_LOGIC_VECTOR(11 downto 0);
RGB_driver: out STD_LOGIC_VECTOR(11 downto 0);
Muerte: out STD_LOGIC
 );
end gestor;

architecture Behavioral of gestor is
begin
process(RGB_coche,RGB_circuito,RGB_coche2,RGB_circuito2)
begin
RGB_driver<=RGB_coche or RGB_circuito or RGB_coche2 or RGB_circuito2;
if(RGB_coche>"000000000000" and RGB_circuito>"000000000000") then
Muerte<='1';
else
Muerte<='0';
end if;
end process;
end Behavioral;
