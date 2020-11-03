LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY AvalonRAMConnector_tb  IS 
  GENERIC (
    PX_X_SPLIT  : INTEGER   := 20 ;  
    DISPLAY_RES_WIDTH  : INTEGER   := 640 ;  
    PX_Y_SPLIT  : INTEGER   := 20 ;  
    DISPLAY_RES_HEIGHT  : INTEGER   := 480 ); 
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



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 500 ns, Period = 2 ns
  Process
	Begin
	 px_clk  <= '0'  ;
	wait for 1 ns ;
-- 1 ns, single loop till start period.
	for Z in 1 to 249
	loop
	    px_clk  <= '1'  ;
	   wait for 1 ns ;
	    px_clk  <= '0'  ;
	   wait for 1 ns ;
-- 499 ns, repeat pattern in loop.
	end  loop;
	 px_clk  <= '1'  ;
	wait for 1 ns ;
-- dumped values till 500 ns
	wait;
 End Process;


-- "Counter Pattern"(Range-Up) : step = 1 Range(000000000000-000000001011)
-- Start Time = 0 ns, End Time = 500 ns, Period = 2 ns
  Process
	variable VARpx_x  : std_logic_vector(11 downto 0);
	Begin
	for Z in 1 to 20
	loop
	VARpx_x  := "000000000000" ;
	for repeatLength in 1 to 12
	loop
	    px_x  <= VARpx_x  ;
	   wait for 2 ns ;
	   VARpx_x  := VARpx_x  + 1 ;
	end loop;
-- 480 ns, repeat pattern in loop.
	end  loop;
	VARpx_x  := "000000000000" ;
	for repeatLength in 1 to 10
	loop
	    px_x  <= VARpx_x  ;
	   wait for 2 ns ;
	   VARpx_x  := VARpx_x  + 1 ;
	end loop;
-- 500 ns, periods remaining till edit start time.
	wait;
 End Process;


-- "Counter Pattern"(Range-Up) : step = 1 Range(000000000000-000000001001)
-- Start Time = 0 ns, End Time = 500 ns, Period = 24 ns
  Process
	variable VARpx_y  : std_logic_vector(11 downto 0);
	Begin
	for Z in 1 to 2
	loop
	VARpx_y  := "000000000000" ;
	for repeatLength in 1 to 10
	loop
	    px_y  <= VARpx_y  ;
	   wait for 24 ns ;
	   VARpx_y  := VARpx_y  + 1 ;
	end loop;
-- 480 ns, repeat pattern in loop.
	end  loop;
	 px_y  <= "000000000000"  ;
	wait for 20 ns ;
-- dumped values till 500 ns
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 500 ns, Period = 0 ns
  Process
	Begin
	 reset  <= '0'  ;
	wait for 500 ns ;
-- dumped values till 500 ns
	wait;
 End Process;


-- "Repeater Pattern" Repeat Forever
-- Start Time = 0 ns, End Time = 500 ns, Period = 16 ns
  Process
	Begin
	 readdata  <= "10101010"  ;
	wait for 64 ns ;
	 readdata  <= "01010101"  ;
	wait for 64 ns ;
	 readdata  <= "10101010"  ;
	wait for 64 ns ;
	 readdata  <= "01010101"  ;
	wait for 64 ns ;
	 readdata  <= "10101010"  ;
	wait for 64 ns ;
	 readdata  <= "01010101"  ;
	wait for 64 ns ;
	 readdata  <= "10101010"  ;
	wait for 64 ns ;
	 readdata  <= "01010101"  ;
	wait for 52 ns ;
	wait;
 End Process;
END;
