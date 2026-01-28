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

entity cont_mov is
Generic (Nbit: INTEGER := 10);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           enable2 : in STD_LOGIC;
           movext: out STD_LOGIC_VECTOR (Nbit-1 downto 0));
end cont_mov;

architecture Behavioral of cont_mov is
signal patras,p_patras : STD_LOGIC;
signal cuenta, p_cuenta: unsigned (9 downto 0);
begin

sinc:process(clk,reset)
begin
    if (reset='1') then
        cuenta <= (others => '0');
    elsif(rising_edge(clk))then
        cuenta <= p_cuenta;
        patras <= p_patras;
        end if;
end process;
comb: process(cuenta,enable,enable2,patras)
begin

if(enable='1' and enable2='1' and patras='0') then
     p_cuenta <= cuenta + 1;
     elsif(enable='1' and enable2='1' and patras='1') then
     p_cuenta <= cuenta - 1;
else
 p_cuenta <=cuenta;
end if;

if(cuenta="000000000") then
p_patras<='0';
elsif(cuenta="001111111")then
p_patras<='1';
else
p_patras<=patras;
end if;
end process;
movext <= STD_LOGIC_VECTOR(cuenta);
end Behavioral;
