----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2023 00:07:06
-- Design Name: 
-- Module Name: vga_driver - Behavioral
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

entity vga_driver is
  Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC;
REDdentro : in STD_LOGIC_VECTOR (3 downto 0);
GRNdentro : in STD_LOGIC_VECTOR (3 downto 0);
BLUdentro : in STD_LOGIC_VECTOR (3 downto 0);
VS : out STD_LOGIC;
HS : out STD_LOGIC;
Refresh : out STD_LOGIC;
Refresh2: out STD_LOGIC;
ejex : out STD_LOGIC_VECTOR (9 downto 0);
ejey : out STD_LOGIC_VECTOR (9 downto 0);
RED : out STD_LOGIC_VECTOR (3 downto 0);
GRN : out STD_LOGIC_VECTOR (3 downto 0);
BLU : out STD_LOGIC_VECTOR (3 downto 0));
    end vga_driver;

architecture Behavioral of vga_driver is

COMPONENT frec_pixel
  Port (clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sat : out STD_LOGIC;
           sat2:out STD_LOGIC;
           cuenta_dig : out STD_LOGIC_VECTOR (1 downto 0) );
end COMPONENT;


COMPONENT contador is
Generic (Nbit: INTEGER:=10   );
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           resets : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (Nbit-1 downto 0));
end COMPONENT;


COMPONENT comparador is
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
end COMPONENT;


COMPONENT comparador_v is
    Generic (Nbit: integer :=10;
    End_Of_Screen: integer :=479;
    Start_Of_Pulse: integer :=489;
    End_Of_Pulse: integer := 491;
    End_Of_Line: integer := 520);
    Port ( clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    data : in STD_LOGIC_VECTOR (Nbit-1 downto 0);
    O1 : out STD_LOGIC;
    O2 : out STD_LOGIC;
    O3 : out STD_LOGIC);
end COMPONENT;

COMPONENT Gen_color is
  Port ( blank_h : in STD_LOGIC;
blank_v : in STD_LOGIC;
RED_in : in STD_LOGIC_VECTOR (3 downto 0);
GRN_in : in STD_LOGIC_VECTOR (3 downto 0);
BLU_in : in STD_LOGIC_VECTOR (3 downto 0);
RED : out STD_LOGIC_VECTOR (3 downto 0);
GRN : out STD_LOGIC_VECTOR (3 downto 0);
BLU : out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;




signal auxsat1,auxsat2,auxO1h,auxO2h,auxO3h,auxO1v,auxO2v,auxO3v,auxmod,auxresets :std_logic;
signal QH,QV,auxmov :std_logic_vector(9 downto 0);
signal auxRED,auxGRN,auxBLU :std_logic_vector(3 downto 0);
begin

auxresets<=auxO3h AND auxsat1;
    U1: frec_pixel PORT MAP(
        clk => clk,
           reset => reset,
           sat =>auxsat1,
           sat2=>auxsat2
           );
     Conth: contador PORT MAP( 
                            clk       =>  clk,
                            reset     =>  reset,
                           enable     =>    auxsat1,
                           resets    => auxresets,
                           Q        =>    QH
                          );       
        Comph: comparador PORT MAP( 
                            clk       =>  clk,
                            reset     =>  reset,
                           data     =>    QH,
                           O1    => auxO1h,
                           O2        =>    auxO2h,
                           O3 =>  auxO3h
                          );      
     Contv: contador PORT MAP( 
                            clk       =>  clk,
                            reset     =>  reset,
                           enable     =>    auxresets,
                           resets    => auxO3v,
                           Q        =>    QV
                          );       
        Compv: comparador_v PORT MAP( 
                            clk       =>  clk,
                            reset     =>  reset,
                           data     =>    QV,
                           O1    => auxO1v,
                           O2        =>    auxO2v,
                           O3 =>  auxO3v
                          );           
        Color: Gen_Color PORT MAP(
                            blank_h      => auxO1h,
                            blank_v      =>auxO1v,
                            RED_in      => REDdentro,
                            GRN_in    => GRNdentro,
                            BLU_in     => BLUdentro,
                            RED     =>  auxRED,
                           GRN     =>   auxGRN,
                           BLU    => auxBLU
                          );
Refresh2<=auxsat2;
VS <=auxO2v;
HS <=auxO2h;
RED <=auxRED;
GRN <=auxGRN;
BLU <=auxBLU;
Refresh <= auxO3v;
ejex <= QH;
ejey <= QV;
end Behavioral;
