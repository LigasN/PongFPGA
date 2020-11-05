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
			DISPLAY_RES_HEIGHT	: integer := 480;
			
			-- Size of pixel from RAM(1 bit can describe more pixels than one)
			PX_X_SPLIT			: integer := 20; -- max 6 bit (63)
			PX_Y_SPLIT			: integer := 20  -- max 6 bit (63)
		);
	port(
			-- Input Clocks
			px_clk			: in	std_logic;
			
			-- Control data- used to specify which pixel color is needed now
			px_x			: in	std_logic_vector(11 downto 0) := (others=>'0'); -- address of the pixel on the screen x coord
			px_y			: in	std_logic_vector(11 downto 0) := (others=>'0'); -- address of the pixel on the screen y coord
			
			-- output color of pixel (1b in this version)
			px_color		: out	std_logic := '0';-- 1- white, 0- black
			
			-- Avalon Memory Mapped Master- used to connect with AvalonVRAM
			reset			: in 	std_logic;
			address			: out 	std_logic_vector(20 downto 0); -- max address 2 097 151
			read			: out 	std_logic;
			readdata		: in 	std_logic_vector(7 downto 0);
			write			: out 	std_logic;
			writedata		: out 	std_logic_vector(7 downto 0)
		);
end AvalonRAMConnector;
			
architecture AvalonRAMConnector_arch of AvalonRAMConnector is

	component Divider is
		port
		(
			denom		: in 	std_logic_vector (5  downto 0);
			numer		: in 	std_logic_vector (11 downto 0);
			quotient	: out 	std_logic_vector (11 downto 0);
			remain		: out 	std_logic_vector (5  downto 0)
		);
	end component Divider;
	
	component Multiplier is
		port
		(
			dataa		: in 	std_logic_vector (11 downto 0);
			datab		: in 	std_logic_vector (11 downto 0);
			result		: out 	std_logic_vector (23 downto 0)
		);
	end component Multiplier;
	

-- signals needed for counting right RAM address
signal RAM_address_x	: std_logic_vector (23 downto 0):= (others=>'0');
signal RAM_address_y	: std_logic_vector (11 downto 0):= (others=>'0');
signal RAM_addr_y_mlt 	: std_logic_vector (23 downto 0):= (others=>'0');

signal split_part_px	: std_logic_vector (5  downto 0):= (others=>'0');

signal RAM_address_bit 	: std_logic_vector (23 downto 0):= (others=>'0');
signal bitenable 		: std_logic_vector (2  downto 0):= (others=>'0');

signal readdata_reg		: std_logic_vector (7  downto 0):= (others=>'0');

begin
	
	-- constant values (we needs only reading from memory at this place)
	write <= '0';
	writedata <= (others=>'0');
	
	process(px_clk) is
	begin
		if falling_edge(px_clk) then
			-- Assigning color value to output before new bitenable comes
			px_color <= readdata(to_integer(unsigned(bitenable)));
		end if;
	end process;
	
	
	-- Divide pixel addresses from screen for RAM pixel size	
	PX_X_DIV : Divider port map
	(
		denom 		=> std_logic_vector(to_unsigned(PX_X_SPLIT, 6)),
		numer 		=> px_x,
		quotient 	=> RAM_address_x(11 downto 0),
		remain 		=> split_part_px
	);
	
	PX_Y_DIV : Divider port map
	(
		denom 		=> std_logic_vector(to_unsigned(PX_Y_SPLIT, 6)),
		numer 		=> px_y,
		quotient 	=> RAM_address_y,
		remain 		=> open
	);
	
	
	-- Multiply RAM_address_y to be ready to add to RAM_address_x and send to RAM
	PX_X_MLT : Multiplier port map
	(
		dataa		=> RAM_address_y,
		datab		=> std_logic_vector(to_unsigned(DISPLAY_RES_WIDTH / PX_X_SPLIT, 12)),
		result		=> RAM_addr_y_mlt
	);
	
	-- RAM address in bits
	RAM_address_bit <= std_logic_vector(unsigned(RAM_addr_y_mlt) + unsigned(RAM_address_x));
	
	-- Assign RAM address with dividing by 8
	address <= RAM_address_bit(23 downto 3);
	
	-- Read only when end of byte is clode for biteenable
	read <= '1' when bitenable = "111" and to_integer(unsigned(split_part_px)) = PX_X_SPLIT - 1 else '0';
	
	-- Get proper bitenable for getting px_color from data
	bitenable <= RAM_address_bit(2 downto 0);
	
	
end AvalonRAMConnector_arch;	
	