----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.10.2023 18:04:38
-- Design Name: 
-- Module Name: comparador - Behavioral
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

entity comparador is
    Generic (Nbit: integer :=10;
    End_Of_Screen: integer :=639;
    Start_Of_Pulse: integer :=655;
    End_Of_Pulse: integer := 751;
    End_Of_Line: integer := 799);
    Port ( clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    data : in STD_LOGIC_VECTOR (Nbit-1 downto 0);
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC);
end comparador;

architecture Behavioral of comparador is

signal unacuenta :unsigned(Nbit-1 downto 0);
signal p_O1,p_O2,p_O3: std_logic;
signal data2: integer;
begin

process(clk,reset)
begin
    if (reset='1') then
        O1 <= '0';
        O2 <= '0';
        O3 <='0';
    elsif(rising_edge(clk))then
        O1 <= p_O1;
        O2 <= p_O2;
        O3 <= p_O3;
        
    end if;
end process;
comb: process(data2,unacuenta)

begin
data2 <= to_integer(unacuenta);
if(data2 > End_Of_Screen) then
p_O1<='1';
else
p_O1<='0';
end if;
if(Start_Of_Pulse < data2 AND End_Of_Pulse > data2) then
p_O2<='1';
else
p_O2<='0';
end if;
if(data2 = End_Of_Line) then
p_O3<='1';
else
p_O3<='0';
end if;
end process;
unacuenta<=unsigned(data);
end Behavioral;
