----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 01:42:56 PM
-- Design Name: 
-- Module Name: SPIslave - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SPIslave is
    Port ( clk : in STD_LOGIC;
           rstn : in STD_LOGIC;
           DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           Busy : out STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           SCLK : in STD_LOGIC;
           MOSI : in STD_LOGIC;
           MISO : out STD_LOGIC;
           SS_n : in STD_LOGIC);
end SPIslave;

architecture Behavioral of SPIslave is
signal ClockDiv     : STD_LOGIC_VECTOR (1 downto 0);
signal posBit        : STD_LOGIC;
signal negBit        : STD_LOGIC;
signal RegMOSI       : STD_LOGIC_VECTOR (31 downto 0);
signal RegMISO       : STD_LOGIC_VECTOR (31 downto 0);

begin
process (clk, rstn)
begin
    if (rstn = '0') then
       ClockDiv <= (others => '0');
    elsif rising_edge(clk) then
       ClockDiv <= ClockDiv(0) & SCLK;
    end if;
end process;
posBit <= '1' when (ClockDiv = "01") else '0';
negBit <= '1' when (ClockDiv = "10") else '0';

process (clk,rstn)
begin 
    if (rstn = '0') then
       RegMOSI     <= (others => '0');
       RegMISO     <= (others => '0');
    elsif rising_edge(clk) then
       if SS_n = '1' then RegMISO <= DataIn;
        elsif negBit = '1' then RegMISO <= RegMISO(30 downto 0) & '0'; 
        elsif posBit = '1' then RegMOSI <= RegMOSI(30 downto 0) & MOSI; 
       end if;
    end if;
end process;

Busy    <= not SS_n;
DataOut <= RegMOSI;

MISO <= RegMISO(31);


end Behavioral;
