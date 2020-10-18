-- Project:			PongFPGA
-- File:			HDMIDriver.vhd
-- Version:			1.0 (20.09.2020)
-- Author:			Norbert Ligas (github.com/LigasN)
-- Description:		With help from Piotr Rzeszut and "Systemy embedded w FPGA".

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


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
			output_clk	: out 	std_logic := '0';
			output_data	: out 	std_logic_vector(2 downto 0) := (others=>'0');
			
			-- Output control data
			px_x		: out	std_logic_vector(12 downto 0) := (others=>'0'); -- address of the next pixel x coord
			px_y		: out	std_logic_vector(12 downto 0) := (others=>'0'); -- address of the next pixel y coord
			
			-- Input color of pixel (1b in this version)
			px_color	: in	std_logic := '0'-- 1- white, 0- black
		);
end HDMIDriver;
			
architecture HDMIDriver_arch of HDMIDriver is

	-- 10 bit output coder for HD
	component TMDS is 
		port(
			clk		: in 	std_logic := '0'; 					-- clock with frequency of pixels
			vd_en	: in 	std_logic := '0'; 					-- enable (1= display, 0= control data)
			ctrl	: in 	std_logic_vector(1 downto 0) := (others=>'0'); 	-- control data for synchronization
			data_in	: in 	std_logic_vector(7 downto 0) := (others=>'0'); 	-- as far as external TDMS is used 8 bit data in
			data_out: out 	std_logic_vector(9 downto 0) := (others=>'0')	-- output TDMS(10 bits) data
		);
	end component;
	
	-- converter to differential transmission
	component LVDS is
		port(
			tx_in  : in 	std_logic := '0';
			tx_out : out 	std_logic := '0'
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
	signal px_current_address 	: coords   := (x =>0, y=>0);
	signal px_data_counter		: counters := (x =>0, y=>0);
	
	-- other signals needed for hdmi
	signal is_displaying	: std_logic := '0';
	signal h_synch			: std_logic := '0';
	signal s_synch			: std_logic := '0';
	
	-- output for TDMS encryption
	signal TMDS_RG : std_logic_vector(9 downto 0) := (others=>'0');
	signal TMDS_BS : std_logic_vector(9 downto 0) := (others=>'0');
	
	-- output for TDMS encryption
	signal TMDS_RG_Reg : std_logic_vector(9 downto 0) := (others=>'0');
	signal TMDS_BS_Reg : std_logic_vector(9 downto 0) := (others=>'0');
	
	-- counter with information about which register will be passed now to HDMI. Needed in TDMS shift register 
	signal reg_counter 	: integer range 0 to 9 := 0;
	
	-- TDMS needs always 8 bits color data
	signal TDMS_color	: std_logic_vector(7 downto 0) := (others=>'0');

begin

	HDMI_DATA: process(clk)
	begin
		
		if falling_edge(clk) then
			
			-- Transfer preparation
			-- Time graph starts from data, then front porch, synchronization, back porch
			
			-- Pixels addresses update for next clk
			if px_data_counter.x = PX_FRONT_PORCH + PX_SYNC_PULSE + PX_BACK_PORCH + DISPLAY_RES_WIDTH then
				
				px_data_counter.x <= 0;
				
				if px_data_counter.y = ROW_FRONT_PORCH + ROW_SYNC_PULSE + ROW_BACK_PORCH + DISPLAY_RES_HEIGHT then
					
					px_data_counter.y <= 0;
					
				else
					
					px_data_counter.y <= px_data_counter.y + 1;
					
				end if;
			else
				
				px_data_counter.x <= px_data_counter.x + 1;
				
			end if;
			
		end if;
	end process;
	
	-- Passing pixel address to output
	px_x <= std_logic_vector(to_unsigned(px_data_counter.x, px_x'length)) when 
								px_data_counter.x < DISPLAY_RES_WIDTH else (others=>'0');

	px_y <= std_logic_vector(to_unsigned(px_data_counter.y, px_y'length)) when 
								px_data_counter.y < DISPLAY_RES_HEIGHT else (others=>'0');

	-- Is displaying info 
	is_displaying <= '1' when px_data_counter.x < DISPLAY_RES_WIDTH and 
							px_data_counter.y < DISPLAY_RES_HEIGHT else '0';
	
	-- Synchronization info
	h_synch <= '1' when px_data_counter.x >= DISPLAY_RES_WIDTH + PX_FRONT_PORCH and
						px_data_counter.x < DISPLAY_RES_WIDTH + PX_FRONT_PORCH + PX_SYNC_PULSE else '0';
	
	s_synch <= '1' when px_data_counter.y >= DISPLAY_RES_HEIGHT + ROW_FRONT_PORCH and
						px_data_counter.y < DISPLAY_RES_HEIGHT + ROW_FRONT_PORCH + ROW_SYNC_PULSE else '0';
	
	-- Encryption with TDMS
	TDMS_color <= (others=>'1') when px_color = '1' else (others=>'0');
	
	RG_TMDS: TMDS port map(
		clk			=> clk,
		vd_en		=> is_displaying,
		ctrl		=> "00",
		data_in		=> TDMS_color,
		data_out	=> TMDS_RG
	);
	
	BC_TMDS: TMDS port map(
		clk			=> clk,
		vd_en		=> is_displaying,
		ctrl		=> s_synch & h_synch, -- encryption clk in blue TDMS
		data_in		=> TDMS_color,
		data_out	=> TMDS_BS
	);
	
	-- Data with frequency of HDMI clock passed by shift register
	TMDS_Shift: process(HDMI_clk)
	begin
		
		if falling_edge(HDMI_clk) then
			
			if reg_counter = 9 then
				reg_counter <= 0;
				TMDS_RG_Reg <= TMDS_RG;
				TMDS_BS_Reg <= TMDS_BS;
			else
				reg_counter <= reg_counter + 1;	
				TMDS_RG_Reg <= '0' & TMDS_RG_Reg(9 downto 1);
				TMDS_BS_Reg <= '0' & TMDS_BS_Reg(9 downto 1);
			end if;
			
		end if;
	end process;
	
	-- TMDS to differential sygnals
	CLK_LVDS: LVDS port map(
		tx_in		=> clk,
		tx_out		=> output_clk
	);
	
	R_LVDS: LVDS port map(
		tx_in		=> TMDS_RG_Reg(0),
		tx_out		=> output_data(1)
	);
	
	G_LVDS: LVDS port map(
		tx_in		=> TMDS_RG_Reg(0),
		tx_out		=> output_data(2)
	);
	
	BS_LVDS: LVDS port map(
		tx_in		=> TMDS_BS_Reg(0),
		tx_out		=> output_data(0)
	);
	
end HDMIDriver_arch;	
	