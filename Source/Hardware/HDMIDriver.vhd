-- Project:			PongFPGA
-- File:			HDMIDriver.vhd
-- Version:			1.0 (20.09.2020)
-- Author:			Norbert Ligas (github.com/LigasN)
-- Description:		With help from Piotr Rzeszut and "Systemy embedded w FPGA".

library ieee;
use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;

entity HDMIDriver is
	generic(
			-- Display resolution
			display_res_width	: integer := 640;
			display_res_height	: integer := 480			
		);
	port(
			-- Input Clocks
			clk			: in	std_logic;
			HDMI_clk	: in	std_logic; -- 10 times slower than clk
			
			-- Output HDMI data
			output_clk	: out 	std_logic;
			output		: out 	std_logic_vector(2 downto 0);
			
			-- Output control data
			px_xy		: out	std_logic_vector(1 downto 0); -- address of the next pixel (x,y)
			
			-- Input color of pixel (1b in this version)
			px_color	: in	std_logic -- 1- white, 0- black
		);
end HDMIDriver;
			
architecture HDMIDriver of HDMIDriver is

	-- 10 bit output coder for HDMI
	component TMDS is 
		port(
			clk		: in std_logic; 					-- clock with frequency of pixels
			display	: in std_logic; 					-- enable (1= display, 0= control data)
			ctrl	: in std_logic_vector(1 downto 0); 	-- control data for synchronization
			data_in	: in std_logic_vector(7 downto 0); 	-- as far as external TDMS is used 8 bit data in
			data_out: in std_logic_vector(9 downto 0) 	-- output TDMS(10 bits) data
		);
	end component;
	
	-- converter to differential transmission
	component LVDS is
		port(
			lvds_in : in 	std_logic := '0';
			lvds_out : out 	std_logic
		);
	end component;
	
	type coord is 
		record 
			x : integer range 0 to display_res_width;
			y : integer range 0 to display_res_height;
		end record;
		
	signal px_address : coord;

begin

	HDMI_PX_ADDRESSES: process(clk)
	begin
	
		if falling_edge(clk) then
			-- pixels addresses
			px_address.x <= px_address.x + 1;
		end if;
		
	end process;
		
end HDMIDriver;	
	