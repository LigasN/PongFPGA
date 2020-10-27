LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY HDMIImageGenerator_tb  IS 
  GENERIC (
    REG_LEN  : INTEGER   := 1 ;  
    X_RES  : INTEGER   := 6 ;  
    Y_RES  : INTEGER   := 5 ;  
    VEL  : INTEGER   := 1;
	FRAMES : INTEGER := 10); 
END ; 
 
ARCHITECTURE HDMIImageGenerator_tb_arch  OF HDMIImageGenerator_tb  IS
  SIGNAL clk	: std_logic;
  SIGNAL px_x   :  std_logic_vector (12 downto 0)  ; 
  SIGNAL px_y   :  std_logic_vector (12 downto 0)  ; 
  SIGNAL px_color   :  STD_LOGIC  ; 
  COMPONENT HDMIImageGenerator  
    GENERIC ( 
      REG_LEN  : INTEGER ; 
      X_RES  : INTEGER ; 
      Y_RES  : INTEGER ; 
      VEL  : INTEGER  );  
    PORT ( 
	  clk		: in	std_logic;
      px_x  : in std_logic_vector (12 downto 0) ; 
      px_y  : in std_logic_vector (12 downto 0) ; 
      px_color  : out STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : HDMIImageGenerator  
    GENERIC MAP ( 
      REG_LEN  => REG_LEN  ,
      X_RES  => X_RES  ,
      Y_RES  => Y_RES  ,
      VEL  => VEL   )
    PORT MAP ( 
	  clk => clk ,
	  px_x   => px_x ,
      px_y   => px_y  ,
      px_color   => px_color ) ; 

	
-- Start Time = 0 ns, Time of one frame 960ns; Frames= 10;
  Process
	variable VARpx_x  : std_logic_vector(12 downto 0);
	Begin
	VARpx_x  := "0000000000000" ;
	for repeatLength in 1 to X_RES*Y_RES*FRAMES
	loop
	    px_x  <= VARpx_x  ;
		wait for 40 ns ;
		VARpx_x  := VARpx_x  + 1 ;
		if VARpx_x = X_RES then
			VARpx_x := (others=>'0');
		end if;
	end loop;
	wait;
 End Process;

 
-- Start Time = 0 ns, Time of one frame 960ns; Frames= 10;
  Process
	variable VARpx_y  : std_logic_vector(12 downto 0);
	Begin
	VARpx_y  := "0000000000000" ;
	for repeatLength in 1 to Y_RES*FRAMES
	loop
	    px_y  <= VARpx_y  ;
	    wait for 240 ns ;
	    VARpx_y  := VARpx_y  + 1 ;
	    if VARpx_y  = Y_RES then
			VARpx_y := (others=>'0');
		end if;
	end loop;
	wait;
 End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, Time of one frame 960ns; Frames= 10
	Process
	Begin
	 clk  <= '0'  ;
	wait for 2 ns ;
	for Z in 1 to 10*X_RES*Y_RES*FRAMES
	loop
	    clk  <= '1'  ;
	   wait for 2 ns ;
	    clk  <= '0'  ;
	   wait for 2 ns ;
	end  loop;
	wait;
 End Process;

END;
