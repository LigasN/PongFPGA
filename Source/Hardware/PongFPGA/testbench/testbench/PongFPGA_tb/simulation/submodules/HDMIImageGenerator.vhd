-- Project:			PongFPGA
-- File:			HDMIImageGenerator.vhd
-- Version:			1.0 (6.10.2020)
-- Author:			Norbert Ligas (github.com/LigasN)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity HDMIImageGenerator is
	generic (
			-- Display resolution
			X_RES : integer := 1080;
			Y_RES : integer := 1920;
			
			-- Rectangle side length
			REG_LEN : integer := 200;
			
			-- Velocity
			VEL : integer := 10
		);

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
			
architecture HDMIImageGenerator_arch of HDMIImageGenerator is
		
	type vec2 is 
	record 
		x : integer range 0 to X_RES;
		y : integer range 0 to Y_RES;
	end record;

	-- Rectangle velocity in pixels
	variable reg_vel : vec2 := (x => VEL, y => VEL);
	
	-- Rectangle left top vertex in pixels
	variable reg_LT : vec2 := (x => 0, y => 0);
	
	-- Rectangle right bottom vertex in pixels
	variable reg_RB : vec2 := (x => REG_LEN, y => REG_LEN);
	
	-- Information about color from x and y perspective
	signal color_x : std_logic := '0';
	signal color_y : std_logic := '0';
	
	
begin

	process(clk)
	begin
		if falling_edge(clk) then
			
			-- Colission with max/min value of position
			if reg_LT.x < 0 OR reg_RB.x > X_RES then
				reg_vel.x := -reg_vel.x;
			end if;
			
			if reg_LT.y > Y_RES OR reg_RB.y < 0 then
				reg_vel.y := -reg_vel.y;
			end if;
			
			-- Calculating next position
			reg_LT.x := reg_LT.x + reg_vel.x;
			reg_LT.y := reg_LT.y + reg_vel.y;	
			reg_RB.x := reg_RB.x + reg_vel.x;
			reg_RB.y := reg_RB.y + reg_vel.y;
			
			-- Shader place
			if px_x > std_logic_vector(to_unsigned(reg_LT.x, 13)) AND px_x < std_logic_vector(to_unsigned(reg_RB.x, 13)) then 
				color_x  <= '1';
			else
				color_x <= '0';
			end if;
			
			if px_y > std_logic_vector(to_unsigned(reg_RB.y, 13)) AND px_y < std_logic_vector(to_unsigned(reg_LT.y, 13)) then 
				color_y  <= '1';
			else
				color_y <= '0';
			end if;
			
		end if;
	end process;
	
	-- Shader place
	px_color <= '1' when color_x = '1' AND color_y = '1' else '0';
	
end HDMIImageGenerator_arch;	
	