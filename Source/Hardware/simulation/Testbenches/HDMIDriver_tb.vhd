LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 


ENTITY HDMIDriver_tb  IS 
  GENERIC ( 
    DISPLAY_RES_WIDTH  : INTEGER   := 6 ;  
    DISPLAY_RES_HEIGHT : INTEGER   := 4;
	
    PX_FRONT_PORCH : INTEGER   := 1 ;
    PX_SYNC_PULSE  : INTEGER   := 1 ;  
    PX_BACK_PORCH  : INTEGER   := 1 ;  
	
    ROW_FRONT_PORCH : INTEGER   := 1 ; 
    ROW_SYNC_PULSE  : INTEGER   := 1 ; 
    ROW_BACK_PORCH  : INTEGER   := 1 ;   
	
	FRAMES			: INTEGER := 10;
	COLOR_LEN		: INTEGER := 2); 
END ; 
 
ARCHITECTURE HDMIDriver_tb_arch   OF HDMIDriver_tb  IS
  SIGNAL bit_clk   :  STD_LOGIC  ; 
  SIGNAL px_clk   :  STD_LOGIC  ; 
  SIGNAL px_color   :  STD_LOGIC  ; 
  SIGNAL px_x   :  std_logic_vector (12 downto 0)  ; 
  SIGNAL px_y   :  std_logic_vector (12 downto 0)  ; 
  SIGNAL output_data   :  std_logic_vector (2 downto 0)  ; 
  SIGNAL output_clk   :  STD_LOGIC  ; 
  COMPONENT HDMIDriver  
    GENERIC ( 
		DISPLAY_RES_WIDTH	: integer;
		DISPLAY_RES_HEIGHT	: integer;
		
		-- Durations
		PX_FRONT_PORCH		: integer;
		PX_SYNC_PULSE		: integer;
		PX_BACK_PORCH		: integer;
		ROW_FRONT_PORCH		: integer;
		ROW_SYNC_PULSE		: integer;
		ROW_BACK_PORCH		: integer  );  
    PORT ( 
      bit_clk  : in STD_LOGIC ;  
      px_clk  : in STD_LOGIC ;
      px_color  : in STD_LOGIC ; 
      px_x  : out std_logic_vector (12 downto 0) ;
      px_y  : out std_logic_vector (12 downto 0) ; 
      output_data  : out std_logic_vector (2 downto 0) ; 
      output_clk  : out STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : HDMIDriver  
    GENERIC MAP ( 
      DISPLAY_RES_WIDTH  => DISPLAY_RES_WIDTH  ,
      DISPLAY_RES_HEIGHT  => DISPLAY_RES_HEIGHT,
	  
      PX_FRONT_PORCH  => PX_FRONT_PORCH  , 
      PX_SYNC_PULSE  => PX_SYNC_PULSE  ,
      PX_BACK_PORCH  => PX_BACK_PORCH  ,
      ROW_FRONT_PORCH  => ROW_FRONT_PORCH  ,
      ROW_SYNC_PULSE  => ROW_SYNC_PULSE  ,
      ROW_BACK_PORCH  => ROW_BACK_PORCH   )
    PORT MAP ( 
      bit_clk   => bit_clk , 
      px_clk   => px_clk  , 
      px_color   => px_color  ,
      px_x   => px_x  ,
      px_y   => px_y  ,
      output_data   => output_data  ,
      output_clk   => output_clk ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, Period = 4 ns
  Process
	Begin
	px_clk  <= '0'  ;
	wait for 20 ns ;
-- 2 ns, single loop till start period.
	for Z in 1 to FRAMES*((DISPLAY_RES_WIDTH+PX_FRONT_PORCH+PX_SYNC_PULSE+PX_BACK_PORCH)
						*DISPLAY_RES_HEIGHT+ROW_FRONT_PORCH+ROW_SYNC_PULSE+ROW_BACK_PORCH)
	loop
	    px_clk  <= '1'  ;
	   wait for 20 ns ;
	    px_clk  <= '0'  ;
	   wait for 20 ns ;
	end  loop;
	wait;
 End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 13 ms, Period = 40 ns
  Process
	Begin
	bit_clk  <= '0'  ;
	wait for 2 ns ;
-- 2 ns, single loop till start period.
	for Z in 1 to FRAMES*((DISPLAY_RES_WIDTH+PX_FRONT_PORCH+PX_SYNC_PULSE+PX_BACK_PORCH)
						*DISPLAY_RES_HEIGHT+ROW_FRONT_PORCH+ROW_SYNC_PULSE+ROW_BACK_PORCH)*10
	loop
	    bit_clk  <= '1'  ;
	   wait for 2 ns ;
	    bit_clk  <= '0'  ;
	   wait for 2 ns ;
	end  loop;
	wait;
 End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 13 ms, Period = 800 ns
  Process
	Begin
	px_color  <= '0'  ;
	wait for COLOR_LEN*40 ns ; --40ns one pixel data duration
	for Z in 1 to FRAMES*((DISPLAY_RES_WIDTH+PX_FRONT_PORCH+PX_SYNC_PULSE+PX_BACK_PORCH)
						*DISPLAY_RES_HEIGHT+ROW_FRONT_PORCH+ROW_SYNC_PULSE+ROW_BACK_PORCH)/(2*COLOR_LEN)
	loop
	    px_color  <= '1'  ;
	   wait for COLOR_LEN*40 ns ; --40ns one pixel data duration
	    px_color  <= '0'  ;
	   wait for COLOR_LEN*40 ns ;
	end  loop;
	wait;
 End Process;
END;
