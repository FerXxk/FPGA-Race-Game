----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2024 17:36:37
-- Design Name: 
-- Module Name: FSM_RX - Behavioral
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

entity FSM_RX is
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
valid : in STD_LOGIC;
posx : out STD_LOGIC_VECTOR(9 DOWNTO 0);
poscircuito : out STD_LOGIC_VECTOR(9 DOWNTO 0);
data :  in STD_LOGIC_VECTOR(19 DOWNTO 0));
end FSM_RX;

architecture Behavioral of FSM_RX is
type tipo_estado is
(espera_valid,rx_posx);
signal estado,p_estado: tipo_estado;
signal auxposx, p_auxposx: STD_LOGIC_VECTOR(9 downto 0);
signal dircircuito,p_dircircuito: STD_LOGIC_VECTOR(9 downto 0);
begin
sinc : process (clk,reset)
begin
if (reset = '1') then
estado <= espera_valid;
auxposx <=(others=>'0');
dircircuito <=(others=>'0');
elsif(rising_edge(clk)) then
estado <= p_estado;
auxposx<=p_auxposx;
dircircuito<=p_dircircuito;
end if;
end process;

comb :process(auxposx,estado,valid,data,dircircuito)
begin
p_dircircuito<=dircircuito;
p_estado<= estado;
p_auxposx<=auxposx;
case estado is
when espera_valid=> 
if(valid='1') then
p_estado<=rx_posx;
end if;

when rx_posx=>
p_auxposx<=data(19 downto 10);
p_dircircuito<=data(9 downto 0);
p_estado<=espera_valid;
when others=> 
p_estado<=espera_valid;
end case;
end process;

posx<=auxposx;
poscircuito<=dircircuito;
end Behavioral;
