-- Project:			PongFPGA
-- File:			AvalonRAMConnector.vhd
-- Version:			1.0 (1.11.2020)
-- Author:			Norbert Ligas (github.com/LigasN)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity AvalonRAMConnector is
	generic(
			-- Display resolution- meybe unneeded
			DISPLAY_RES_WIDTH	: integer := 640;
			DISPLAY_RES_HEIGHT	: integer := 480
		);
	port(
			-- Input Clocks
			px_clk			: in	std_logic;
			
			-- Control data- used to specify which pixel color is needed now
			px_x			: in	std_logic_vector(12 downto 0) := (others=>'0'); -- address of the pixel on the screen x coord
			px_y			: in	std_logic_vector(12 downto 0) := (others=>'0'); -- address of the pixel on the screen y coord
			
			-- output color of pixel (1b in this version)
			px_color		: out	std_logic := '0';-- 1- white, 0- black
			
			-- Avalon Memory Mapped Master- used to connect with AvalonVRAM
			reset_n			: out 	std_logic;
			address			: out 	std_logic_vector(6 downto 0); -- max address 101 1111 = 95
			read			: out 	std_logic;
			readdata		: in 	std_logic_vector(7 downto 0);
			write			: out 	std_logic;
			writedata		: out 	std_logic_vector(7 downto 0)
		);
end AvalonRAMConnector;
			
architecture AvalonRAMConnector_arch of AvalonRAMConnector is

signal reg_counter 	: integer 						:= 0;
signal data_reg		: std_logic_vector(7 downto 0) 	:= (others=>'0');

begin
	
	-- constant values (we needs only reading from memory at this place)
	write <= '0';
	writedata <= (others=>'0');
	
	-- Data with frequency of HDMI clock passed by shift register
	process(px_clk)
	begin
		
		-- Handling 1 byte data
		if falling_edge(px_clk) then
			
			if reg_counter = 8 then
				read <= '0';
				data_reg <= readdata;
				reg_counter <= 0;
				
			else
				read <= '0';
				data_reg <= 0 & data_reg(7 downto 1);
				reg_counter <= reg_counter + 1;	
				
				-- That is known that reg_counter incrementation will affect after process will end
				if reg_counter = 7 then 
					read <= '1'; --  and the last assignation will affect
				end if;
			end if;
		end if;
		
		-- Handling adresses
		-- needed px_addresses to divide for RAM address
		-- and remainder for bit byteenable on byte from RAM
		
		
		end if;
	end process;

	
end AvalonRAMConnector_arch;	
	