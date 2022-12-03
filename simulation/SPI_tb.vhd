----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 04:04:44 PM
-- Design Name: 
-- Module Name: SPI_tb - Behavioral
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

entity SPI_tb is
--  Port ( );
end SPI_tb;

architecture Behavioral of SPI_tb is
 component SPImaster is
    Port ( 
           clk : in STD_LOGIC;
           rstn : in STD_LOGIC;
           ClockCiv : in STD_LOGIC_VECTOR (7 downto 0);
           Start : in STD_LOGIC;
           DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           Busy : out STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           SCLK : out STD_LOGIC;
           MOSI : out STD_LOGIC;
           MISO : in STD_LOGIC;
           SS_n : out STD_LOGIC
           );
  end component SPImaster;  
 component SPIslave is
    Port ( clk : in STD_LOGIC;
           rstn : in STD_LOGIC;
           DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           Busy : out STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           SCLK : in STD_LOGIC;
           MOSI : in STD_LOGIC;
           MISO : out STD_LOGIC;
           SS_n : in STD_LOGIC);
  end component SPIslave;  

signal clk,rstn : STD_LOGIC:= '0';
signal ClockCiv : STD_LOGIC_VECTOR (7 downto 0) := X"04";
signal Start    : STD_LOGIC := '0';
signal MDataIn   : STD_LOGIC_VECTOR (31 downto 0) := X"81234563";
signal MBusy     : STD_LOGIC;
signal MDataOut  : STD_LOGIC_VECTOR (31 downto 0);
signal SDataIn   : STD_LOGIC_VECTOR (31 downto 0) := X"86543213";
signal SBusy     : STD_LOGIC;
signal SDataOut  : STD_LOGIC_VECTOR (31 downto 0);
signal SCLK     : STD_LOGIC;
signal MOSI     : STD_LOGIC;
signal MISO     : STD_LOGIC;
signal SS_n     : STD_LOGIC;

begin
process 
begin 
clk <= '0';
wait for 5 ns;
clk <= '1';
wait for 5 ns;
end process;

process 
begin 
wait for 100 ns;
rstn <= '1';
wait for 100 ns;
wait until (rising_edge(clk));
Start <= '1';
wait until (rising_edge(clk));
Start <= '0';
wait;
end process;

 SPImaster_inst: component SPImaster 
    port map ( 
           clk      =>  clk     ,
           rstn     =>  rstn    ,
           ClockCiv =>  ClockCiv,
           Start    =>  Start   ,
           DataIn   =>  MDataIn  ,
           Busy     =>  MBusy    ,
           DataOut  =>  MDataOut ,
           SCLK     =>  SCLK    ,
           MOSI     =>  MOSI    ,
           MISO     =>  MISO    ,
           SS_n     =>  SS_n    
           );

 SPIslave_inst: component SPIslave 
    port map ( 
           clk      =>  clk     ,
           rstn     =>  rstn    ,
           DataIn   =>  SDataIn  ,
           Busy     =>  SBusy    ,
           DataOut  =>  SDataOut ,
           SCLK     =>  SCLK    ,
           MOSI     =>  MOSI    ,
           MISO     =>  MISO    ,
           SS_n     =>  SS_n    
           );


end Behavioral;
