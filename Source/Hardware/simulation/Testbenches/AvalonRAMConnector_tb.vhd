LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY AvalonRAMConnector_tb  IS 
  GENERIC (
    PX_X_SPLIT  : INTEGER   := 2 ;  
    DISPLAY_RES_WIDTH  : INTEGER   := 32 ;  
    PX_Y_SPLIT  : INTEGER   := 2 ;  
    DISPLAY_RES_HEIGHT  : INTEGER   := 16 ;
	FRAMES		: INTEGER	:= 2 ); 
END ; 
 
ARCHITECTURE AvalonRAMConnector_tb_arch OF AvalonRAMConnector_tb IS
  SIGNAL read   :  STD_LOGIC  ; 
  SIGNAL px_y   :  STD_LOGIC_VECTOR (11 downto 0) := (others =>  '0')  ; 
  SIGNAL writedata   :  STD_LOGIC_VECTOR (7 downto 0)  ; 
  SIGNAL px_clk   :  STD_LOGIC  ; 
  SIGNAL readdata   :  STD_LOGIC_VECTOR (7 downto 0)  ; 
  SIGNAL address   :  STD_LOGIC_VECTOR (20 downto 0)  ; 
  SIGNAL px_color   :  STD_LOGIC := '0'  ; 
  SIGNAL write   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  SIGNAL px_x   :  STD_LOGIC_VECTOR (11 downto 0) := (others =>  '0')  ; 
  COMPONENT AvalonRAMConnector  
    GENERIC ( 
      PX_X_SPLIT  : INTEGER ; 
      DISPLAY_RES_WIDTH  : INTEGER ; 
      PX_Y_SPLIT  : INTEGER ; 
      DISPLAY_RES_HEIGHT  : INTEGER  );  
    PORT ( 
      read  : out STD_LOGIC ; 
      px_y  : in STD_LOGIC_VECTOR (11 downto 0) ; 
      writedata  : out STD_LOGIC_VECTOR (7 downto 0) ; 
      px_clk  : in STD_LOGIC ; 
      readdata  : in STD_LOGIC_VECTOR (7 downto 0) ; 
      address  : out STD_LOGIC_VECTOR (20 downto 0) ; 
      px_color  : out STD_LOGIC ; 
      write  : out STD_LOGIC ; 
      reset  : in STD_LOGIC ; 
      px_x  : in STD_LOGIC_VECTOR (11 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : AvalonRAMConnector  
    GENERIC MAP ( 
      PX_X_SPLIT  => PX_X_SPLIT  ,
      DISPLAY_RES_WIDTH  => DISPLAY_RES_WIDTH  ,
      PX_Y_SPLIT  => PX_Y_SPLIT  ,
      DISPLAY_RES_HEIGHT  => DISPLAY_RES_HEIGHT   )
    PORT MAP ( 
      read   => read  ,
      px_y   => px_y  ,
      writedata   => writedata  ,
      px_clk   => px_clk  ,
      readdata   => readdata  ,
      address   => address  ,
      px_color   => px_color  ,
      write   => write  ,
      reset   => reset  ,
      px_x   => px_x   ) ; 



	Process
	Begin
		px_clk  <= '0'  ;
		wait for 1 ns ;
		for Z in 1 to FRAMES*DISPLAY_RES_WIDTH*DISPLAY_RES_HEIGHT
		loop
			px_clk  <= '1'  ;
			wait for 1 ns ;
			px_clk  <= '0'  ;
			wait for 1 ns ;
		end  loop;
		wait;
	End Process;


	Process
		variable VARpx_x  		: std_logic_vector(11 downto 0):= (others=>'0');
		variable VARpx_y  		: std_logic_vector(11 downto 0):= (others=>'0');
		constant pattern0 		: std_logic_vector(7  downto 0):= "10101010";
		constant pattern1 		: std_logic_vector(7  downto 0):= "01010101";
		variable patternCounter : std_logic := '0';
		variable readDataInNext : std_logic := '0';
		variable lastaddress    : std_logic_vector(20 downto 0):= (others=>'0');
	Begin
		readdata 	   <= pattern0;
		for repeatLength in 1 to FRAMES*DISPLAY_RES_WIDTH*DISPLAY_RES_HEIGHT
		loop			
			VARpx_x  := VARpx_x  + 1;
			
			if VARpx_x  = DISPLAY_RES_WIDTH then
				VARpx_y  := VARpx_y  + 1;
				VARpx_x := (others=>'0');
				
				if VARpx_y  = DISPLAY_RES_HEIGHT then
					VARpx_y := (others=>'0');
				end if;
			end if;
			
			px_x  		<= VARpx_x;
			px_y  		<= VARpx_y;
			
			wait for 2 ns;
			
			if lastaddress /= address then
				if patternCounter = '0' then
					readdata 	   <= pattern1;
					patternCounter := '1';
				else
					readdata 	   <= pattern0;
					patternCounter := '0';
				end if;
			end if;
			
			--if lastaddress /= address then
			--	readDataInNext := '1';
			--else
			--	readDataInNext := '0';
			--end if;
			
			--lastaddress := address;
			
		end loop;
		wait;
	End Process;

-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 500 ns, Period = 0 ns
	Process
	Begin
		reset  <= '0'  ;
		wait;
	End Process;
END;
