----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 03:57:54 PM
-- Design Name: 
-- Module Name: SPImaster - Behavioral
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

entity SPImaster is
    Port ( clk : in STD_LOGIC;
           rstn : in STD_LOGIC;
           ClockCiv : in STD_LOGIC_VECTOR (7 downto 0);
           Start : in STD_LOGIC;
           DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           Busy : out STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           SCLK : out STD_LOGIC;
           MOSI : out STD_LOGIC;
           MISO : in STD_LOGIC;
           SS_n : out STD_LOGIC);
end SPImaster;

architecture Behavioral of SPImaster is
signal ClockDivCount : STD_LOGIC_VECTOR (7 downto 0);
signal SPIclock      : STD_LOGIC;
signal posBit        : STD_LOGIC;
signal negBit        : STD_LOGIC;
signal SPIbitCount   : STD_LOGIC_VECTOR (4 downto 0);
signal RegMOSI       : STD_LOGIC_VECTOR (31 downto 0);
signal RegMISO       : STD_LOGIC_VECTOR (31 downto 0);
signal RegSS_n       : STD_LOGIC;

begin
process (clk, rstn)
begin
    if (rstn = '0') then
       ClockDivCount <= (others => '0');
       SPIclock <= '0';
    elsif rising_edge(clk) then
        if Start = '1' then 
            ClockDivCount <= (others => '0');
            SPIclock <= '0';
        elsif ClockDivCount = ClockCiv then 
            ClockDivCount <= (others => '0');
            SPIclock <= not SPIclock;
        else ClockDivCount <= ClockDivCount + 1;
        end if;
    end if;
end process;
posBit <= '1' when ((ClockDivCount = ClockCiv) and (SPIclock = '0')) else '0';
negBit <= '1' when ((ClockDivCount = ClockCiv) and (SPIclock = '1')) else '0';

process (clk,rstn)
begin 
    if (rstn = '0') then
       SPIbitCount <= (others => '0');
       RegSS_n     <= '1';
       RegMOSI     <= (others => '0');
       RegMISO     <= (others => '0');
    elsif rising_edge(clk) then
        if Start = '1' then 
            SPIbitCount <= (others => '0');
            RegSS_n     <= '0';
            RegMOSI     <= DataIn;
         elsif negBit = '1' then 
            SPIbitCount <= SPIbitCount + 1;
            if SPIbitCount = "11111" then 
                RegSS_n     <= '1';
             else RegMOSI <= RegMOSI(30 downto 0) & '0';
             end if;
        elsif posBit = '1' and RegSS_n = '0' then
             RegMISO <= RegMISO(30 downto 0) & MISO;
        end if;
    end if;
end process;

Busy    <= not RegSS_n;
DataOut <= RegMISO;

SCLK <= SPIclock when RegSS_n = '0' else '0';
MOSI <= RegMOSI(31);
SS_n <= RegSS_n;



end Behavioral;
