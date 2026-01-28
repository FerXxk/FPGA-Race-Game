----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2023 20:34:35
-- Design Name: 
-- Module Name: dibuja_circuito - Behavioral
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

entity dibuja_circuito is
  Port (
   
  ADIR: out STD_LOGIC_VECTOR(9 DOWNTO 0);
  ejex:in STD_LOGIC_VECTOR(9 downto 0);
  ejey: in STD_LOGIC_VECTOR(9 downto 0);
  data: in STD_LOGIC_VECTOR(15 downto 0);
  data_cesped: in STD_LOGIC_VECTOR(11 downto 0);
  ADIR_cesped: out STD_LOGIC_VECTOR(7 DOWNTO 0);
  clk :in STD_LOGIC;
  Reset: in STD_LOGIC;
  muerte: in STD_LOGIC;
  RGB: out STD_LOGIC_VECTOR(11 downto 0);
  avanza:in STD_LOGIC;
  start: in STD_LOGIC;
  dir_basedef : out STD_LOGIC_VECTOR(9 downto 0)
   );
end dibuja_circuito;

architecture Behavioral of dibuja_circuito is

type tipo_estado is
(reposo,danzakuduro,muelte9999);
signal estadillo,p_estadillo : tipo_estado;

signal lim_izda,lim_dcha : unsigned(8 downto 0);
signal sup_ejey, dir_base,p_dir_base: unsigned(9 downto 0);
signal auxADIR: STD_LOGIC_VECTOR(9 DOWNTO 0);
begin 
ADIR<=STD_LOGIC_VECTOR(dir_base+unsigned(ejey(8 downto 4)));
auxADIR<=STD_LOGIC_VECTOR(dir_base+unsigned(ejey(8 downto 4)));
lim_izda(7 downto 0)<=unsigned(data(15 downto 8));
lim_dcha(7 downto 0)<=unsigned(data(7 downto 0));

sinc:process(clk,reset)
begin
    if (reset='1') then
        dir_base <= (others => '1');
        estadillo<=reposo;
    elsif(rising_edge(clk))then
        dir_base <= p_dir_base;
        estadillo<=p_estadillo;
        end if;
end process;
avanzadilla:process(avanza,dir_base,estadillo,start,muerte)
begin
p_estadillo<=estadillo;
case estadillo is
when reposo =>
p_dir_base<=dir_base;
if(start='1') then
p_estadillo<=danzakuduro;
end if;
when danzakuduro =>
if(avanza='1') then 
p_dir_base<=dir_base-1;
else
p_dir_base<=dir_base;
end if;

if(muerte='1') then
p_estadillo<=muelte9999;
end if;

when muelte9999 => 
p_dir_base<=dir_base;
end case;
end process;

process(ejex,ejey,data,data_cesped,lim_izda,lim_dcha)
begin
adir_cesped <= (OTHERS => '1');
if(unsigned(ejex)>0 and unsigned(ejex)<320) then
if((unsigned(ejex)>(lim_izda) and unsigned(ejex)<lim_izda+10) or ((unsigned(ejex)>lim_dcha+10) and (unsigned(ejex)<(lim_dcha+20)))) then
    if(ejey(4)='1') then
    RGB<="110100000000";
    else
    RGB<="111111111111";
    end if;
else if(unsigned(ejex)<(lim_izda+10) or unsigned(ejex)>(lim_dcha+10)) then
                ADIR_cesped(3 DOWNTO 0) <= STD_LOGIC_VECTOR((unsigned(ejex(5 DOWNTO 2))));
                ADIR_cesped(7 DOWNTO 4) <= STD_LOGIC_VECTOR((unsigned(ejey(5 DOWNTO 2)) ));
                RGB<=data_cesped;
                               
else
RGB <= ( others => '0'); -- estoy dentro de los límites de la carretera, es negro
end if;
end if;
else
RGB <= ( others => '0'); -- estoy dentro de los límites de la carretera, es negro

end if;
end process;
dir_basedef<=STD_LOGIC_VECTOR(dir_base);





end Behavioral;