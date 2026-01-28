----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2023 14:42:45
-- Design Name: 
-- Module Name: frec_pixel - Behavioral
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

entity frec_pixel is
  Port (clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sat : out STD_LOGIC;
           sat2:out STD_LOGIC;
           cuenta_dig : out STD_LOGIC_VECTOR (1 downto 0) );
end frec_pixel;

architecture Behavioral of frec_pixel is

signal cuenta, p_cuenta: unsigned (1 downto 0);
signal cuenta2, p_cuenta2: unsigned (23 downto 0);
begin

sinc:process(clk,reset)
begin
    if (reset='1') then
        cuenta <= (others => '0');
        cuenta2 <=(others =>'0');
    elsif(rising_edge(clk))then
        cuenta <= p_cuenta;
        cuenta2<= p_cuenta2;
        end if;
end process;
comb: process(cuenta2)
begin
 if(cuenta2="111111111111111111111111") then 
    p_cuenta2 <=(others => '0');
    sat2 <='1';
    else
     p_cuenta2 <= cuenta2 + 1;
     sat2 <= '0';  
     end if;
end process;
comb2: process(cuenta)
begin
 if(cuenta="11") then 
    p_cuenta <=(others => '0');
    sat <='1';
    else
     p_cuenta <= cuenta + 1;
     sat <= '0';  
     end if;
end process;
cuenta_dig <= STD_LOGIC_VECTOR(cuenta);


end Behavioral;
