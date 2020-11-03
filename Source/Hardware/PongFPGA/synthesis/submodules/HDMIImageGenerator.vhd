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
			X_RES : integer := 640;
			Y_RES : integer := 480;
			
			-- Rectangle side length
			REG_LEN : integer := 200;
			
			-- Velocity
			VEL : integer := 10
		);

	port(
			-- Input Clocks
			clk			: in	std_logic;
			
			-- Pixels adresses
			px_x		: in	std_logic_vector(11 downto 0); -- address of the pixel, x coord
			px_y		: in	std_logic_vector(11 downto 0); -- address of the pixel, y coord
			
			-- Color of pixel for (1b in this version)
			px_color	: out	std_logic -- 1- white, 0- black
		);
end HDMIImageGenerator;
			
architecture HDMIImageGenerator_arch of HDMIImageGenerator is
	
	-- Rectangle velocity in pixels
	--signal reg_vel 	: vec2 := (x => VEL, y => VEL);
	signal reg_vel_x 	: integer range -VEL to VEL := VEL;
	signal reg_vel_y 	: integer range -VEL to VEL := VEL;
	
	-- Rectangle left bottom vertex in pixels
	--signal reg_LB 	: vec2 := (x => 0, y => 0);
	signal reg_l 		: integer range 0 to X_RES := (X_RES - REG_LEN)/2;
	signal reg_b 		: integer range 0 to Y_RES := (Y_RES - REG_LEN)/2;
	
	-- Rectangle right top vertex in pixels
	--signal reg_RT 	: vec2 := (x => REG_LEN, y => REG_LEN);
	signal reg_r 		: integer range 0 to X_RES := (X_RES + REG_LEN)/2;
	signal reg_t 		: integer range 0 to Y_RES := (Y_RES + REG_LEN)/2;
	
	-- Information about color from x and y perspective
	signal color_x : std_logic := '0';
	signal color_y : std_logic := '0';
	
begin

	process(clk)
	variable last_px_x : std_logic_vector(11 downto 0) := (others=>'0');
	begin
		if falling_edge(clk) then
			-- Shader place
			if to_integer(unsigned(px_x)) >= reg_l AND to_integer(unsigned(px_x)) < reg_r then 
				color_x  <= '1';
			else
				color_x <= '0';
			end if;
			
			if to_integer(unsigned(px_y)) >= reg_b AND to_integer(unsigned(px_y)) < reg_t then 
				color_y  <= '1';
			else
				color_y <= '0';
			end if;
			
			-- Frame finished
			if to_integer(unsigned(px_x)) >= (X_RES - 1) AND to_integer(unsigned(px_y)) >= (Y_RES - 1) AND last_px_x /= px_x then
				
				-- Colission with max/min value of position
				if reg_l + reg_vel_x <= 0 OR reg_r + reg_vel_x >= X_RES then
					reg_vel_x <= -reg_vel_x;
				end if;
				
				if reg_t + reg_vel_y >= Y_RES OR reg_b + reg_vel_y <= 0 then
					reg_vel_y <= -reg_vel_y;
				end if;
				
				
				-- Calculating next position
				reg_l <= reg_l + reg_vel_x;
				reg_t <= reg_t + reg_vel_y;	
				reg_r <= reg_r + reg_vel_x;
				reg_b <= reg_b + reg_vel_y;
				
			end if;
			
			last_px_x := px_x;
		end if;
	end process;
	
	
	-- Shader place
	px_color <= '1' when color_x = '1' AND color_y = '1' else '0';
	
end HDMIImageGenerator_arch;	
	