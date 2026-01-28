----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2023 20:38:24
-- Design Name: 
-- Module Name: Gen_color - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Gen_color is
  Port ( blank_h : in STD_LOGIC;
blank_v : in STD_LOGIC;
RED_in : in STD_LOGIC_VECTOR (3 downto 0);
GRN_in : in STD_LOGIC_VECTOR (3 downto 0);
BLU_in : in STD_LOGIC_VECTOR (3 downto 0);
RED : out STD_LOGIC_VECTOR (3 downto 0);
GRN : out STD_LOGIC_VECTOR (3 downto 0);
BLU : out STD_LOGIC_VECTOR (3 downto 0));
end Gen_color;

architecture Behavioral of Gen_color is

begin
gen_color:process(Blank_H, Blank_V, RED_in, GRN_in,
BLU_in)
begin
if (Blank_H='1' or Blank_V='1') then
RED<=(others => '0'); GRN<=(others => '0');
BLU<=(others => '0');
else
RED<=RED_in; GRN<=GRN_in; BLU<=BLU_in;
end if;
end process;


end Behavioral;
