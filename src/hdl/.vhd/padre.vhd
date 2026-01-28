----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.12.2023 20:26:01
-- Design Name: 
-- Module Name: padre - Behavioral
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

entity padre is
 Port (
 left : in STD_LOGIC;
right : in STD_LOGIC;
 clk  : in STD_LOGIC;
reset : in STD_LOGIC;
start: in STD_LOGIC;
TX: out STD_LOGIC;
RX: in STD_LOGIC;
VS : out STD_LOGIC;
HS : out STD_LOGIC;
RED : out STD_LOGIC_VECTOR(3 downto 0);
GRN : out STD_LOGIC_VECTOR(3 downto 0);
BLU : out STD_LOGIC_VECTOR(3 downto 0) );
end padre;

architecture Behavioral of padre is

COMPONENT vga_driver is
  Port (
clk : in STD_LOGIC;
reset : in STD_LOGIC;
REDdentro : in STD_LOGIC_VECTOR (3 downto 0);
GRNdentro : in STD_LOGIC_VECTOR (3 downto 0);
BLUdentro : in STD_LOGIC_VECTOR (3 downto 0);
VS : out STD_LOGIC;
HS : out STD_LOGIC;
Refresh : out STD_LOGIC;
Refresh2 : out STD_LOGIC;
ejex : out STD_LOGIC_VECTOR (9 downto 0); 
ejey : out STD_LOGIC_VECTOR (9 downto 0);
RED : out STD_LOGIC_VECTOR (3 downto 0);
GRN : out STD_LOGIC_VECTOR (3 downto 0);
BLU : out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

COMPONENT Dibuja is
  Port (eje_x : in STD_LOGIC_VECTOR (9 downto 0);
eje_y : in STD_LOGIC_VECTOR (9 downto 0);
ADIR: out STD_LOGIC_VECTOR(8 DOWNTO 0);
data: in STD_LOGIC_VECTOR(11 downto 0);
posxdef : out STD_LOGIC_VECTOR (9 downto 0);
refresh :in STD_LOGIC;
left : in STD_LOGIC;
right : in STD_LOGIC;
clk  : in STD_LOGIC;
muerte: in STD_LOGIC;
reset : in STD_LOGIC;
start : in STD_LOGIC;
RED : out STD_LOGIC_VECTOR(3 downto 0);
GRN : out STD_LOGIC_VECTOR(3 downto 0);
BLU : out STD_LOGIC_VECTOR(3 downto 0));
end COMPONENT;

COMPONENT dibuja_circuito is
Port (
   
  ADIR: out STD_LOGIC_VECTOR(9 DOWNTO 0);
  ejex:in STD_LOGIC_VECTOR(9 downto 0);
  ejey: in STD_LOGIC_VECTOR(9 downto 0);
  data: in STD_LOGIC_VECTOR(15 downto 0);
  data_cesped: in STD_LOGIC_VECTOR(11 downto 0);
  ADIR_cesped: out STD_LOGIC_VECTOR(7 DOWNTO 0);
  clk :in STD_LOGIC;
  Reset: in STD_LOGIC;
  start: in STD_LOGIC;
  muerte: in STD_LOGIC;
  RGB: out STD_LOGIC_VECTOR(11 downto 0);
  avanza:in STD_LOGIC;
  dir_basedef : out STD_LOGIC_VECTOR(9 downto 0)
   );
   end COMPONENT;
   
   Component dibuja_circuito2 is
  Port (
   ADIR: out STD_LOGIC_VECTOR(9 DOWNTO 0);
  data: in STD_LOGIC_VECTOR(15 downto 0);
  ejex:in STD_LOGIC_VECTOR(9 downto 0);
  ejey: in STD_LOGIC_VECTOR(9 downto 0);
  data_cesped: in STD_LOGIC_VECTOR(11 downto 0);
  ADIR_cesped: out STD_LOGIC_VECTOR(7 DOWNTO 0);
  clk :in STD_LOGIC;
  Reset : in STD_LOGIC;
  RGB: out STD_LOGIC_VECTOR(11 downto 0);
  dir_basedef : in STD_LOGIC_VECTOR(9 downto 0)
   );
   end Component;
   
   COMPONENT gestor is
    Port ( 
RGB_coche: in STD_LOGIC_VECTOR(11 downto 0);
RGB_coche2: in STD_LOGIC_VECTOR(11 downto 0);
RGB_circuito: in STD_LOGIC_VECTOR(11 downto 0);
RGB_driver: out STD_LOGIC_VECTOR(11 downto 0);
RGB_circuito2: in STD_LOGIC_VECTOR(11 downto 0);
Muerte: out STD_LOGIC
 );
 end COMPONENT;
 component coche2 IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END component;
COMPONENT blk_mem_gen_0 is
PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
  end component;
  COMPONENT circuitosserie is
PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
  END COMPONENT;
COMPONENT cesped IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
end COMPONENT;

COMPONENT cesped2 IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
end COMPONENT;

component coche1 IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END component;

component RXserie is
generic (
VAL_SAT_CONT : integer := 20000;
ANCHO_CONTADOR : integer :=20
);
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
data : out STD_LOGIC_VECTOR (19 downto 0);
valid: out STD_LOGIC;
RX : in std_logic
);      
end component;

component TXserie is
generic (
VAL_SAT_CONT : integer := 20000;
ANCHO_CONTADOR : integer :=20
);
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
data : in STD_LOGIC_VECTOR (19 downto 0);
valid: in STD_LOGIC;
TX : out STD_LOGIC;
ready : out STD_LOGIC
);
end component;

component FSM_TX is
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
ready : in STD_LOGIC;
valid : out STD_LOGIC;
posx : in STD_LOGIC_VECTOR(9 DOWNTO 0);
poscircuito : in STD_LOGIC_VECTOR(9 DOWNTO 0);
data :  out STD_LOGIC_VECTOR(19 DOWNTO 0));
end component;

component FSM_RX is
Port ( clk : in STD_LOGIC;
reset : in STD_LOGIC;
valid : in STD_LOGIC;
poscircuito : out STD_LOGIC_VECTOR(9 DOWNTO 0);
posx : out STD_LOGIC_VECTOR(9 DOWNTO 0);
data :  in STD_LOGIC_VECTOR(19 DOWNTO 0));
end Component;

component dibuja_coche2 is
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
end component;

signal auxrefresh,auxVS,auxHS,auxmuerte,auxavanza,auxTX,auxready,auxvalidin,auxvalidout:std_logic;
signal auxejex,auxposxdibFSM,auxposxout:std_logic_vector(9 downto 0);
signal auxposxRXFSM,auxposxFSMTXs:std_logic_vector(19 downto 0);
signal auxejey,auxADDR,auxADDR2 :std_logic_vector(9 downto 0);
signal auxlimitescircuito,auxposcircuito2:std_logic_vector(9 downto 0);
signal auxDIRcoche,auxDIRcocheserie:std_logic_vector(8 downto 0);
signal auxREDsal,auxGRNsal,auxBLUsal:std_logic_vector(3 downto 0);
signal auxREDinterior,auxBLUinterior,auxGRNinterior :std_logic_vector(3 downto 0);
signal auxdata,auxdataserie: std_logic_vector(15 downto 0);
signal auxRGBcircuito,auxRGBcircuito2,auxRGBcoche,auxRGBcoche2,auxDATAcoche,auxDATAcocheserie: std_logic_vector(11 downto 0);
signal auxDIRcesped,auxDIRcesped2 : std_logic_vector(7 downto 0);
signal auxDATAcesped,auxDATAcesped2 : std_logic_vector(11 downto 0);
begin

driver : vga_driver PORT MAP(
clk =>clk,
reset =>reset,
REDdentro=>auxREDinterior,
GRNdentro =>auxGRNinterior,
BLUdentro =>auxBLUinterior,
VS =>auxVS,
HS =>auxHS,
Refresh => auxrefresh,
Refresh2 => auxavanza,
ejex=> auxejex,
ejey=> auxejey,
RED =>auxREDsal,
GRN =>auxGRNsal,
BLU =>auxBLUsal
);
dibujasion : Dibuja PORT MAP(
eje_x =>auxejex,
eje_y =>auxejey,
refresh =>auxrefresh,
ADIR=>auxDIRcoche,
data=>auxDATAcoche,
posxdef=>auxposxdibFSM,
left =>left,
right =>right,
clk  =>clk,
reset =>reset,
RED =>auxRGBcoche(11 downto 8),
GRN =>auxRGBcoche(7 downto 4),
BLU =>auxRGBcoche(3 downto 0),
muerte=>auxmuerte,
start=>start
);
dibujasioncocheserie: dibuja_coche2 PORT MAP(
eje_x=>auxejex,
eje_y=>auxejey,
refresh=>auxrefresh,
posxRX=>auxposxout,
clk =>clk,
reset=>reset,
ADIR=>auxDIRcocheserie,
data=> auxDATAcocheserie,
RED =>auxRGBcoche2(11 downto 8),
GRN =>auxRGBcoche2(7 downto 4),
BLU =>auxRGBcoche2(3 downto 0)
);

dibujasion_circuito: dibuja_circuito PORT MAP(
  ADIR=> auxADDR,
  ejex=>auxejex,
  ejey=>auxejey,
  data=>auxdata,
  clk=>clk,
  Reset=>reset,
  data_cesped=>auxDATAcesped,
  ADIR_cesped=>auxDIRcesped,        
  RGB=> auxRGBcircuito,
  avanza=>auxavanza,
  start=>start,
  muerte=>auxmuerte,
  dir_basedef=>auxlimitescircuito
);
dibujasion_circuito2: dibuja_circuito2 PORT MAP(
ADIR=>auxADDR2,
data=>auxdataserie,
  ejex=>auxejex,
  ejey=>auxejey,
  clk=>clk,
  Reset=>reset,
  data_cesped=>auxDATAcesped2,
  ADIR_cesped=>auxDIRcesped2,        
  RGB=> auxRGBcircuito2,
  dir_basedef=>auxposcircuito2
);
gestoria: gestor PORT MAP(
RGB_coche=>auxRGBcoche,
RGB_coche2=>auxRGBcoche2,
RGB_circuito=> auxRGBcircuito,
RGB_circuito2=> auxRGBcircuito2,
RGB_driver(11 downto 8)=>auxREDinterior,
RGB_driver(7 downto 4)=>auxGRNinterior,
RGB_driver(3 downto 0)=>auxBLUinterior,
Muerte=>auxmuerte
);

TransmisorSerie: TXserie PORT MAP(
clk =>clk,
reset=>reset,
data=>auxposxFSMTXs,
valid=>auxvalidin,
TX=>auxTX,
ready=>auxready
);

Receptorserie: RXserie Port MAP  ( 
clk =>clk,
reset=>reset,
data =>auxposxRXFSM,
valid=>auxvalidout,
RX =>RX 
);
FSM_transmisorserie: FSM_TX PORT map(
 clk =>clk,
reset =>reset,
ready =>auxready,
valid =>auxvalidin,
posx =>auxposxdibFSM,
data =>auxposxFSMTXs,
poscircuito=>auxlimitescircuito
);

Receptor_serie: FSM_RX Port map ( 
clk =>clk,
reset =>reset,
valid =>auxvalidout,
posx => auxposxout,
poscircuito=>auxposcircuito2,
data =>auxposxRXFSM
);

coche: coche2 PORT MAP(
    clka=>clk , 
    addra=>auxDIRcoche,
    douta=>auxDATAcoche
  );
circuito: blk_mem_gen_0 PORT MAP(
    clka=>clk , 
    addra=>auxADDR ,
    douta=>auxdata 
  );
 circuito_serie:  circuitosserie PORT map (
    clka =>clk,
    addra =>auxADDR2,
    douta =>auxdataserie
  );
  
  sespesito:cesped PORT MAP(
      clka=>clk, 
    addra=>auxDIRcesped, 
    douta=>auxDATAcesped
    );
    
  sespesito2:cesped2 PORT MAP(
      clka=>clk, 
    addra=>auxDIRcesped2, 
    douta=>auxDATAcesped2
    );
    cocheserieskin: coche1 PORT map(
    clka =>clk,
    addra=>auxDIRcocheserie,
    douta=>auxDATAcocheserie
  );
RED<=auxREDsal;
GRN<=auxGRNsal;
BLU<=auxBLUsal;
VS<=auxVS;
HS<=auxHS;
TX<=auxTX;
end Behavioral;