-- Project:			PongFPGA
-- File:			HDMIDriver.vhd
-- Version:			1.0 (20.09.2020)
-- Author:			Norbert Ligas (github.com/LigasN)

library ieee;
use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;

entity HDMIDriver is
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
			
architecture 