----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2022 11:36:01 AM
-- Design Name: 
-- Module Name: ARTY_SPI_tb - Behavioral
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

entity ARTY_SPI_tb is
end ARTY_SPI_tb;

architecture Behavioral of ARTY_SPI_tb is
component ARTY_SPI_Top is
  port (
      MSCLK : out STD_LOGIC;
      MMOSI : out STD_LOGIC;
      MMISO : in STD_LOGIC;
      MSS_n : out STD_LOGIC;
      SSCLK : in STD_LOGIC;
      SMOSI : in STD_LOGIC;
      SMISO : out STD_LOGIC;
      SSS_n : in STD_LOGIC
);
end component ARTY_SPI_Top;  

signal SCLK :  STD_LOGIC;
signal MOSI :  STD_LOGIC;
signal MISO : STD_LOGIC;
signal SS_n :  STD_LOGIC;

begin

ARTY_SPI_Top_inst: component ARTY_SPI_Top 
  port map(
      MSCLK => SCLK,
      MMOSI => MOSI,
      MMISO => MISO,
      MSS_n => SS_n,
      SSCLK => SCLK,
      SMOSI => MOSI,
      SMISO => MISO,
      SSS_n => SS_n
);

end Behavioral;
