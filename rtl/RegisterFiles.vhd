----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2022 10:22:43 AM
-- Design Name: 
-- Module Name: RegisterFiles - Behavioral
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

entity RegisterFiles is
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
           ClockCiv : out STD_LOGIC_VECTOR (7 downto 0);
           Start    : out STD_LOGIC;
           DataIn   : out STD_LOGIC_VECTOR (31 downto 0);
           Busy     : in  STD_LOGIC;
           DataOut  : in  STD_LOGIC_VECTOR (31 downto 0)
           );
end RegisterFiles;

architecture Behavioral of RegisterFiles is

signal RegClockCiv : STD_LOGIC_VECTOR (7 downto 0);
signal RegStart    : STD_LOGIC;
signal RegDataIn   : STD_LOGIC_VECTOR (31 downto 0);

signal ReadData1 : STD_LOGIC_VECTOR (31 downto 0);
signal ReadData2 : STD_LOGIC_VECTOR (31 downto 0);
signal APBtran  : STD_LOGIC;
signal APBwirte : STD_LOGIC;
signal APBready : STD_LOGIC;
begin

APBtran  <= APB_M_0_penable(0) and APB_M_0_psel(0);
APBwirte <= APBtran and APB_M_0_pwrite(0);

process (clk,rstn)
begin
    if (rstn = '0') then
       RegClockCiv <= (others => '0');
       RegStart    <= '0';
       RegDataIn   <= (others => '0');
     elsif rising_edge(clk) then
        if RegStart = '1' then RegStart    <= '0';
         elsif APBwirte = '1' then 
            if APB_M_0_paddr(7 downto 0) = X"00" then RegStart  <= APB_M_0_pwdata(0);
             elsif APB_M_0_paddr(7 downto 0) = X"08" then RegDataIn <= APB_M_0_pwdata;              
             elsif APB_M_0_paddr(7 downto 0) = X"10" then RegClockCiv <= APB_M_0_pwdata(7 downto 0);
--          case APB_M_0_paddr(7 downto 0) is
--            when X"00" => RegStart  <= APB_M_0_pwdata(0);
--            when X"08" => RegDataIn <= APB_M_0_pwdata;
--            when X"10" => RegClockCiv <= APB_M_0_pwdata(7 downto 0);
--          end case;  
            end if; 
        end if; 
    end if; 
end process;

--process (APBtran)
--begin
--    case (APB_M_0_paddr(7 downto 0)) is
--        when X"00"  =>  ReadData1 <= X"0000000" & "000" & RegStart; 
--        when X"04"  =>  ReadData1 <= X"0000000" & "000" & Busy; 
--        when X"08"  =>  ReadData1 <= RegDataIn; 
--        when X"0c"  =>  ReadData1 <= DataOut; 
--        when X"10"  =>  ReadData1 <= X"000000" & RegClockCiv; 
--        when others =>  ReadData1 <= X"00000000";
--    end case;
--end process;
process (APBtran)
begin
    case (APB_M_0_paddr(7 downto 0)) is
        when X"00"  =>  APB_M_0_prdata <= X"0000000" & "000" & RegStart; 
        when X"04"  =>  APB_M_0_prdata <= X"0000000" & "000" & Busy; 
        when X"08"  =>  APB_M_0_prdata <= RegDataIn; 
        when X"0c"  =>  APB_M_0_prdata <= DataOut; 
        when X"10"  =>  APB_M_0_prdata <= X"000000" & RegClockCiv; 
        when others =>  APB_M_0_prdata <= X"00000000";
    end case;
end process;
ReadData2 <= X"0000000" & "000" & RegStart when APB_M_0_paddr(7 downto 0) = X"00" else 
--APB_M_0_prdata <= X"0000000" & "000" & RegStart when APB_M_0_paddr(7 downto 0) = X"00" else 
                  X"0000000" & "000" & Busy     when APB_M_0_paddr(7 downto 0) = X"04" else 
                  RegDataIn                     when APB_M_0_paddr(7 downto 0) = X"08" else 
                  DataOut                       when APB_M_0_paddr(7 downto 0) = X"0c" else 
                  X"000000" & RegClockCiv       when APB_M_0_paddr(7 downto 0) = X"10" else  X"00000000";
--APB_M_0_prdata <= ReadData1;

process (clk,rstn)
begin
    if (rstn = '0') then
        APBready <= '0';
     else APBready <= APBtran;
    end if; 
end process;

APB_M_0_pready(0) <= APBready;
APB_M_0_pslverr(0) <= '0';

ClockCiv <= RegClockCiv ;
Start    <= RegStart    ;
DataIn   <= RegDataIn   ;

end Behavioral;
