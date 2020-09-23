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
			DISPLAY_RES_WIDTH	: integer := 640;
			DISPLAY_RES_HEIGHT	: integer := 480;
			
			-- Durations
			PX_FRONT_PORCH		: integer := 16;
			PX_SYNC_PULSE		: integer := 96;
			PX_BACK_PORCH		: integer := 48;
			ROW_FRONT_PORCH		: integer := 10;
			ROW_SYNC_PULSE		: integer := 2;
			ROW_BACK_PORCH		: integer := 33
		);
	port(
			-- Input Clocks
			clk			: in	std_logic;
			HDMI_clk	: in	std_logic; -- 10 times slower than clk
			
			-- Output HDMI data
			output_clk	: out 	std_logic;
			output		: out 	std_logic_vector(2 downto 0);
			
			-- Output control data
			px_x		: out	std_logic_vector(to_unsigned(0, DISPLAY_RES_WIDTH'length)); -- address of the next pixel x coord
			px_y		: out	std_logic_vector(to_unsigned(0, DISPLAY_RES_HEIGHT'length)); -- address of the next pixel x coord
			
			-- Input color of pixel (1b in this version)
			px_color	: in	std_logic -- 1- white, 0- black
		);
end HDMIDriver;
			
architecture HDMIDriver of HDMIDriver is

	-- 10 bit output coder for HD
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
	
	type coords is 
		record 
			x : integer range 0 to DISPLAY_RES_WIDTH;
			y : integer range 0 to DISPLAY_RES_HEIGHT;
		end record;
		
	type counters is 
		record 
			x : integer range 0 to PX_FRONT_PORCH + PX_SYNC_PULSE + PX_BACK_PORCH + DISPLAY_RES_WIDTH;
			y : integer range 0 to ROW_FRONT_PORCH + ROW_SYNC_PULSE + ROW_BACK_PORCH + DISPLAY_RES_HEIGHT;
		end record;
	
	-- to tell on output which pixel will be next
	signal px_current_address 	: coords;
	signal px_data_counter		: counters;
	
	-- other signals needed for hdmi
	signal is_displaying	: STD_LOGIC;
	signal h_synch			: STD_LOGIC;
	signal s_synch			: STD_LOGIC;

begin

	HDMI_PX_ADDRESSES: process(clk)
	begin
		
		if falling_edge(clk) then
			
			-- Transfer preparation
			-- Time graph starts from data, then front porch, synchronization, back porch
			
			-- pixels addresses
			-- incrementation only within DISPLAY_RES_WIDTH period, with making overflow at the end
			if px_data_counter.x = DISPLAY_RES_WIDTH - 1 then
				--px_current_address.x will overflow now, so increment the y one
				if px_data_counter.y < DISPLAY_RES_HEIGHT then
					px_current_address.y <= px_current_address.y + 1;
				end if;
			end if;
			
			if px_data_counter.x < DISPLAY_RES_WIDTH then
				px_current_address.x <= px_current_address.x + 1;
			end if;
			
			-- Update counters for next clk
			if px_data_counter.x = PX_FRONT_PORCH + PX_SYNC_PULSE + PX_BACK_PORCH + DISPLAY_RES_WIDTH - 1 then
				-- counter.x will overflow in next clock, so increment the y one
				px_data_counter.y <= px_data_counter.y + 1;
			end if;
				
			-- always increment the counter.x value, when y is prepared
			px_data_counter.x <= px_data_counter.x + 1;
			
		end if;
	end process;
			
	-- Is displaying info 
	is_displaying <= '1' when px_data_counter.x < DISPLAY_RES_WIDTH and 
							px_data_counter.y < DISPLAY_RES_WIDTH else '0';
		
	-- Synchronization info
	h_synch <= '1' when px_data_counter.x >= DISPLAY_RES_WIDTH + PX_FRONT_PORCH and
						px_data_counter.x < DISPLAY_RES_WIDTH + PX_FRONT_PORCH + PX_SYNC_PULSE else '0';
	
	s_synch <= '1' when px_data_counter.y >= DISPLAY_RES_HEIGHT + ROW_FRONT_PORCH and
						px_data_counter.y < DISPLAY_RES_HEIGHT + ROW_FRONT_PORCH + ROW_SYNC_PULSE else '0';
		
end HDMIDriver;	
	