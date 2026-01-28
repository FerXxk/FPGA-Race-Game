----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.10.2023 12:23:21
-- Design Name: 
-- Module Name: contador - Behavioral
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

entity contador is
Generic (Nbit: INTEGER := 10);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           resets : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (Nbit-1 downto 0));
end contador;

architecture Behavioral of contador is
signal cuenta, p_cuenta: unsigned (Nbit-1 downto 0);
begin

sinc:process(clk,reset)
begin
    if (reset='1') then
        cuenta <= (others => '0');
    elsif(rising_edge(clk))then
    if(resets='1') then
    cuenta<=(others=>'0');
    else
        cuenta <= p_cuenta;
        end if;
        end if;
end process;
comb: process(cuenta,enable)
begin
if(enable='1') then
     p_cuenta <= cuenta + 1;    
else
 p_cuenta <=cuenta;
end if;

end process;
Q <= STD_LOGIC_VECTOR(cuenta);
end Behavioral;
