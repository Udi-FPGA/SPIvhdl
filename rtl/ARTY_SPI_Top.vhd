----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2022 02:14:20 PM
-- Design Name: 
-- Module Name: ARTY_SPI_Top - Behavioral
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

entity ARTY_SPI_Top is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
           MSCLK : out STD_LOGIC;
           MMOSI : out STD_LOGIC;
           MMISO : in STD_LOGIC;
           MSS_n : out STD_LOGIC;
           SSCLK : in STD_LOGIC;
           SMOSI : in STD_LOGIC;
           SMISO : out STD_LOGIC;
           SSS_n : in STD_LOGIC
  );
end ARTY_SPI_Top;

architecture Behavioral of ARTY_SPI_Top is
component ARTY_SPI_BD is 
    port (
    APB_M_0_paddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    APB_M_0_penable : out STD_LOGIC;
    APB_M_0_prdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    APB_M_0_pready : in STD_LOGIC_VECTOR ( 0 to 0 );
    APB_M_0_psel : out STD_LOGIC_VECTOR ( 0 to 0 );
    APB_M_0_pslverr : in STD_LOGIC_VECTOR ( 0 to 0 );
    APB_M_0_pwdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    APB_M_0_pwrite : out STD_LOGIC;
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FCLK_CLK0 : out STD_LOGIC;
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC
  );
  end component ARTY_SPI_BD;

component Master is
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
end component Master;

component Slave is
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
           SCLK : in STD_LOGIC;
           MOSI : in STD_LOGIC;
           MISO : out STD_LOGIC;
           SS_n : in STD_LOGIC);
end component Slave;

COMPONENT ila_0

PORT (
	clk : IN STD_LOGIC;

	probe0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
	probe1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
	probe3 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe4 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe5 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe6 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
	probe7 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe8 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe9 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe10 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe11 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe12 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe13 : IN STD_LOGIC_VECTOR(0 DOWNTO 0); 
	probe14 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
	probe15 : IN STD_LOGIC_VECTOR(0 DOWNTO 0)
);
END COMPONENT  ;

signal clk : STD_LOGIC;
signal rstn : STD_LOGIC_VECTOR ( 0 to 0 );

signal APB_M_0_paddr   : STD_LOGIC_VECTOR ( 31 downto 0 );
signal APB_M_0_penable : STD_LOGIC_VECTOR ( 0 to 0 );
signal APB_M_0_prdata  : STD_LOGIC_VECTOR ( 31 downto 0 );
signal APB_M_0_pready  : STD_LOGIC_VECTOR ( 0 to 0 );
signal APB_M_0_psel    : STD_LOGIC_VECTOR ( 0 to 0 );
signal APB_M_0_pslverr : STD_LOGIC_VECTOR ( 0 to 0 );
signal APB_M_0_pwdata  : STD_LOGIC_VECTOR ( 31 downto 0 );
signal APB_M_0_pwrite  : STD_LOGIC_VECTOR ( 0 to 0 );

signal MasterPsel : STD_LOGIC_VECTOR ( 0 to 0 );
signal SlavePsel : STD_LOGIC_VECTOR ( 0 to 0 );

signal APB_M_0_Mprdata : STD_LOGIC_VECTOR ( 31 downto 0 );
signal APB_M_0_Mpready : STD_LOGIC_VECTOR ( 0 to 0 );
signal APB_M_0_Mpslverr : STD_LOGIC_VECTOR ( 0 to 0 );
signal APB_M_0_Sprdata : STD_LOGIC_VECTOR ( 31 downto 0 );
signal APB_M_0_Spready : STD_LOGIC_VECTOR ( 0 to 0 );
signal APB_M_0_Spslverr : STD_LOGIC_VECTOR ( 0 to 0 );

signal inMSCLK :  STD_LOGIC;
signal inMMOSI :  STD_LOGIC;
signal inMMISO : STD_LOGIC;
signal inMSS_n :  STD_LOGIC;
signal inSSCLK : STD_LOGIC;
signal inSMOSI : STD_LOGIC;
signal inSMISO :  STD_LOGIC;
signal inSSS_n : STD_LOGIC;

begin
ARTY_SPI_BD_0: component ARTY_SPI_BD
     port map (
	APB_M_0_paddr(31 downto 0)  => APB_M_0_paddr  (31 downto 0),
	APB_M_0_penable             => APB_M_0_penable(0),
	APB_M_0_prdata(31 downto 0) => APB_M_0_prdata (31 downto 0),
	APB_M_0_pready(0 to 0)      => APB_M_0_pready (0 to 0),
	APB_M_0_psel(0 to 0)        => APB_M_0_psel   (0 to 0),
	APB_M_0_pslverr(0 to 0)     => APB_M_0_pslverr(0 to 0),
	APB_M_0_pwdata(31 downto 0) => APB_M_0_pwdata (31 downto 0),
	APB_M_0_pwrite              => APB_M_0_pwrite (0),
	DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
	DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
	DDR_cas_n => DDR_cas_n,
	DDR_ck_n => DDR_ck_n,
	DDR_ck_p => DDR_ck_p,
	DDR_cke => DDR_cke,
	DDR_cs_n => DDR_cs_n,
	DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
	DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
	DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
	DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
	DDR_odt => DDR_odt,
	DDR_ras_n => DDR_ras_n,
	DDR_reset_n => DDR_reset_n,
	DDR_we_n => DDR_we_n,
	FCLK_CLK0 => clk,
	peripheral_aresetn => rstn,
	FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
	FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
	FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
	FIXED_IO_ps_clk => FIXED_IO_ps_clk,
	FIXED_IO_ps_porb => FIXED_IO_ps_porb,
	FIXED_IO_ps_srstb => FIXED_IO_ps_srstb
     );

MasterPsel(0) <= '1' when APB_M_0_psel(0) = '1' and APB_M_0_paddr(8) = '0' else '0';
SlavePsel(0)  <= '1' when APB_M_0_psel(0) = '1' and APB_M_0_paddr(8) = '1' else '0';
APB_M_0_prdata  <= APB_M_0_Sprdata  when APB_M_0_paddr(8) = '1' else APB_M_0_Mprdata ;
APB_M_0_pready  <= APB_M_0_Spready  when APB_M_0_paddr(8) = '1' else APB_M_0_Mpready ;
APB_M_0_pslverr <= APB_M_0_Spslverr when APB_M_0_paddr(8) = '1' else APB_M_0_Mpslverr;

Master_inst: component Master 
    Port map( 
           clk             => clk            ,
           rstn            => rstn(0)        ,
           APB_M_0_paddr   => APB_M_0_paddr  ,
           APB_M_0_penable => APB_M_0_penable,
           APB_M_0_prdata  => APB_M_0_Mprdata ,
           APB_M_0_pready  => APB_M_0_Mpready ,
           APB_M_0_psel    => MasterPsel     ,
           APB_M_0_pslverr => APB_M_0_Mpslverr,
           APB_M_0_pwdata  => APB_M_0_pwdata ,
           APB_M_0_pwrite  => APB_M_0_pwrite ,
           SCLK            => inMSCLK           ,
           MOSI            => inMMOSI           ,
           MISO            => inMMISO           ,
           SS_n            => inMSS_n           
           );

Slave_inst: component Slave 
    Port map( 
           clk             => clk            ,
           rstn            => rstn(0)        ,
           APB_M_0_paddr   => APB_M_0_paddr  ,
           APB_M_0_penable => APB_M_0_penable,
           APB_M_0_prdata  => APB_M_0_Sprdata ,
           APB_M_0_pready  => APB_M_0_Spready ,
           APB_M_0_psel    => SlavePsel      ,
           APB_M_0_pslverr => APB_M_0_Spslverr,
           APB_M_0_pwdata  => APB_M_0_pwdata ,
           APB_M_0_pwrite  => APB_M_0_pwrite ,
           SCLK            => inSSCLK           ,
           MOSI            => inSMOSI           ,
           MISO            => inSMISO           ,
           SS_n            => inSSS_n           
           );

MSCLK <=  inMSCLK ;
MMOSI <=  inMMOSI ;
inMMISO <=  MMISO ;
MSS_n <=  inMSS_n ;
inSSCLK <=  SSCLK ;
inSMOSI <=  SMOSI ;
SMISO <=  inSMISO ;
inSSS_n <=  SSS_n ;

ila_0_inst : ila_0
PORT MAP (
	clk => clk,

	probe0  => APB_M_0_paddr  , 
	probe1  => APB_M_0_penable, 
	probe2  => APB_M_0_prdata , 
	probe3  => APB_M_0_pready , 
	probe4  => APB_M_0_psel   , 
	probe5  => APB_M_0_pslverr, 
	probe6  => APB_M_0_pwdata , 
	probe7  => APB_M_0_pwrite , 
	probe8 (0) => inMSCLK,
	probe9 (0) => inMMOSI,
	probe10(0) => inMMISO, 
	probe11(0) => inMSS_n, 
	probe12(0) => inSSCLK, 
	probe13(0) => inSMOSI, 
	probe14(0) => inSMISO,
	probe15(0) => inSSS_n
);

end Behavioral;
