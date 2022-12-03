----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 04:18:03 PM
-- Design Name: 
-- Module Name: Master - Behavioral
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

entity Master is
   Port ( clk : in STD_LOGIC;
           rstn : in STD_LOGIC;
           APB_M_0_paddr   : in  STD_LOGIC_VECTOR ( 31 downto 0 );
           APB_M_0_penable : in  STD_LOGIC_VECTOR ( 0 to 0 );
           APB_M_0_prdata  : out STD_LOGIC_VECTOR ( 31 downto 0 );
           APB_M_0_pready  : out STD_LOGIC_VECTOR ( 0 to 0 );
           APB_M_0_psel    : in  STD_LOGIC_VECTOR ( 0 to 0 );
           APB_M_0_pslverr : out STD_LOGIC_VECTOR ( 0 to 0 );
           APB_M_0_pwdata  : in  STD_LOGIC_VECTOR ( 31 downto 0 );
           APB_M_0_pwrite  : in  STD_LOGIC_VECTOR ( 0 to 0 );
           SCLK : out STD_LOGIC;
           MOSI : out STD_LOGIC;
           MISO : in STD_LOGIC;
           SS_n : out STD_LOGIC);
end Master;

architecture Behavioral of Master is
component RegisterFiles is
    Port ( clk : in STD_LOGIC;
           rstn : in STD_LOGIC;
           APB_M_0_paddr   : in  STD_LOGIC_VECTOR ( 31 downto 0 );
           APB_M_0_penable : in  STD_LOGIC_VECTOR ( 0 to 0 );
           APB_M_0_prdata  : out STD_LOGIC_VECTOR ( 31 downto 0 );
           APB_M_0_pready  : out STD_LOGIC_VECTOR ( 0 to 0 );
           APB_M_0_psel    : in  STD_LOGIC_VECTOR ( 0 to 0 );
           APB_M_0_pslverr : out STD_LOGIC_VECTOR ( 0 to 0 );
           APB_M_0_pwdata  : in  STD_LOGIC_VECTOR ( 31 downto 0 );
           APB_M_0_pwrite  : in  STD_LOGIC_VECTOR ( 0 to 0 );
           Start           : out STD_LOGIC;
           Busy            : in  STD_LOGIC;
           DataIn          : out STD_LOGIC_VECTOR (31 downto 0);
           DataOut         : in  STD_LOGIC_VECTOR (31 downto 0);
           ClockCiv        : out STD_LOGIC_VECTOR (7 downto 0)
           );
end component RegisterFiles;

component SPImaster is
    Port ( clk      : in STD_LOGIC;
           rstn     : in STD_LOGIC;
           Start    : in STD_LOGIC;
           Busy     : out STD_LOGIC;
           DataIn   : in STD_LOGIC_VECTOR (31 downto 0);
           DataOut  : out STD_LOGIC_VECTOR (31 downto 0);
           ClockCiv : in STD_LOGIC_VECTOR (7 downto 0);
           SCLK     : out STD_LOGIC;
           MOSI     : out STD_LOGIC;
           MISO     : in STD_LOGIC;
           SS_n     : out STD_LOGIC);
end component SPImaster;

signal Start    : STD_LOGIC;
signal DataIn   : STD_LOGIC_VECTOR (31 downto 0);
signal Busy     :  STD_LOGIC;
signal DataOut  :  STD_LOGIC_VECTOR (31 downto 0);
signal ClockCiv : STD_LOGIC_VECTOR (7 downto 0);

begin
RegisterFiles_inst: component RegisterFiles 
    Port map( 
           clk             => clk             ,
           rstn            => rstn            ,
           APB_M_0_paddr   => APB_M_0_paddr   ,
           APB_M_0_penable => APB_M_0_penable ,
           APB_M_0_prdata  => APB_M_0_prdata  ,
           APB_M_0_pready  => APB_M_0_pready  ,
           APB_M_0_psel    => APB_M_0_psel    ,
           APB_M_0_pslverr => APB_M_0_pslverr ,
           APB_M_0_pwdata  => APB_M_0_pwdata  ,
           APB_M_0_pwrite  => APB_M_0_pwrite  ,
           Start           => Start           ,
           Busy            => Busy            ,
           DataIn          => DataIn          ,
           DataOut         => DataOut         ,
           ClockCiv        => ClockCiv        
           );

SPImaster_inst : component SPImaster 
    Port map( 
           clk      => clk      ,
           rstn     => rstn     ,
           Start    => Start    ,
           Busy     => Busy     ,
           DataIn   => DataIn   ,
           DataOut  => DataOut  ,
           ClockCiv => ClockCiv ,
           SCLK     => SCLK     ,
           MOSI     => MOSI     ,
           MISO     => MISO     ,
           SS_n     => SS_n     
           );



end Behavioral;
