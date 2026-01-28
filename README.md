
<div align="center">

<h1>🏎️ FPGA Racing Game</h1>

 ![Language](https://img.shields.io/badge/Language-VHDL-blue) ![Hardware](https://img.shields.io/badge/Hardware-Basys3-orange)![Status](https://img.shields.io/badge/Status-Completed-success)

 </div>

A **VHDL-based racing game** implementation for the **Basys 3 FPGA** board. This project uses a custom VGA driver to display the game interface and implements real-time logic for car movement, collision detection, and UART communication to play the game with another player.


## 🛠️ Hardware Setup
<div align="center">

<img src="media/hardware.jpeg" width="600" alt="Hardware Setup">

*FPGA Board Setup*

</div>


## 🏗️ System Architecture

The following block diagram represents the internal hardware structure of the design:
<div align="center">

```mermaid
graph LR
    subgraph Top_Level [Top Level: padre.vhd]
        direction LR
        
        %% Driver Logic
        VGA[VGA Driver] --> |X, Y Coordinates| Render
        VGA --> |HS, VS, Blank| VGA_OUT((VGA Connector))
        
        %% Input Processing
        RX_Mod[UART RX] --> |Remote Position| Logic
        Logic[Game Logic / FSM] --> |Player Position| TX_Mod[UART TX]
        Logic --> |Game State| Render
        
        %% Visualization
        subgraph Render [Visualization Pipeline]
            direction TB
            Track[Track Gen]
            P1[Player Car]
            P2[Remote Car]
            Mux[Priority Selector]
        end
        
        %% Internal Wiring
        Logic --> P1
        RX_Mod --> P2
        
        Track --> |RGB| Mux
        P1 --> |RGB| Mux
        P2 --> |RGB| Mux
        
        Mux --> |Final Pixel Color| VGA_OUT
    end

    %% External Inputs
    Controls((Buttons)) --> Logic
    RX_Line((RX Line)) --> RX_Mod
    
    %% External Outputs
    TX_Mod --> TX_Line((TX Line))
    
    CLK((100MHz CLK)) --> VGA
    CLK --> Logic
```
*Block Diagram of VHDL instances*

</div>

## 🎮 Gameplay

Click the image below to watch the gameplay video.

<div align="center">

<img src="media/race2.jpeg" width="600" alt="Gameplay Video">

*Gameplay Video with the TX and RX lines connected*

</div>

## 📂 Project Structure

The repository is organized as follows:

- **`src/`**: Source files.
  - **`hdl/`**: 🧠 VHDL source code (Logic, FSM, VGA Driver).
  - **`constraints/`**: 📐 XDC constraints file for Basys 3.
  - **`ip/`**: 🧱 IP Cores and Coefficient files (`.coe`).
- **`media/`**: 📷 Images and videos of the project.
- **`docs/`**: 📄 Documentation (`Proyecto_FPGA.pdf`).

## 🚀 How to Run

1.  **Open Vivado**.
2.  **Create a New Project** and select the **Basys 3** board (Artix-7).
3.  **Program Device**: Connect the Basys 3 board via USB and program it with the generated `.bit` file.

## ✨ Features

- 🖥️ **VGA Video Output** (640x480 @ 60Hz)
- 🚗 **Real-time car movement**
- 📡 **Communication** with a remote car via UART
- 💥 **Collision detection**
- 🔄 **Finite State Machines (FSM)** for game control

---

*Developed by Fernando Román, Marta Barroso and José Chaqués | Electronics Systems Course, University of Seville*
