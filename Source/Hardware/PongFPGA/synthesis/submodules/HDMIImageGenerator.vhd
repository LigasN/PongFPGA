-- Project:			PongFPGA
-- File:			HDMIImageGenerator.vhd
-- Version:			1.0 (6.10.2020)
-- Author:			Norbert Ligas (github.com/LigasN)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity HDMIImageGenerator is

	port(
			-- Input Clocks
			clk			: in	std_logic;
			
			-- Pixels adresses
			px_x		: in	std_logic_vector(12 downto 0); -- address of the pixel, x coord
			px_y		: in	std_logic_vector(12 downto 0); -- address of the pixel, y coord
			
			-- Color of pixel for (1b in this version)
			px_color	: out	std_logic -- 1- white, 0- black
		);
end HDMIImageGenerator;
			
architecture HDMIImageGenerator of HDMIImageGenerator is
	
	-- color storred for next loop too
	signal color : std_logic := '0';
	
begin

	process(clk)
	begin
		if falling_edge(clk) then
			
			-- Set new color
			color <= not color;
			
		end if;
	end process;
	
	-- Pass color to output
	px_color <= color;
	
end HDMIImageGenerator;	
	