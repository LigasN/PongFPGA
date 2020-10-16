LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY HDMIImageGenerator_tb  IS 
  GENERIC (
    REG_LEN  : INTEGER   := 200 ;  
    X_RES  : INTEGER   := 640 ;  
    Y_RES  : INTEGER   := 480 ;  
    VEL  : INTEGER   := 10 ); 
END ; 
 
ARCHITECTURE HDMIImageGenerator_tb_arch  OF HDMIImageGenerator_tb  IS
  SIGNAL px_y   :  std_logic_vector (12 downto 0)  ; 
  SIGNAL px_color   :  STD_LOGIC  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL px_x   :  std_logic_vector (12 downto 0)  ; 
  COMPONENT HDMIImageGenerator  
    GENERIC ( 
      REG_LEN  : INTEGER ; 
      X_RES  : INTEGER ; 
      Y_RES  : INTEGER ; 
      VEL  : INTEGER  );  
    PORT ( 
      px_y  : in std_logic_vector (12 downto 0) ; 
      px_color  : out STD_LOGIC ; 
      clk  : in STD_LOGIC ; 
      px_x  : in std_logic_vector (12 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : HDMIImageGenerator  
    GENERIC MAP ( 
      REG_LEN  => REG_LEN  ,
      X_RES  => X_RES  ,
      Y_RES  => Y_RES  ,
      VEL  => VEL   )
    PORT MAP ( 
      px_y   => px_y  ,
      px_color   => px_color  ,
      clk   => clk  ,
      px_x   => px_x   ) ; 



-- "Counter Pattern"(Range-Up) : step = 1 Range(0000000000000-0001010000000)
-- Start Time = 0 ns, End Time = 13 ms, Period = 40 ns
  Process
	variable VARpx_x  : std_logic_vector(12 downto 0);
	Begin
	VARpx_x  := "0000000000000" ;
	for repeatLength in 1 to 325000
	loop
	    px_x  <= VARpx_x  ;
	   wait for 40 ns ;
	   VARpx_x  := VARpx_x  + 1 ;
	   if VARpx_x  = X_RES then
			VARpx_x := (others=>'0');
		end if;
	end loop;
-- 13 us, periods remaining till edit start time.
	wait;
 End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 13 ms, Period = 4 ns
  Process
	Begin
	 clk  <= '0'  ;
	wait for 2 ns ;
-- 2 ns, single loop till start period.
	for Z in 1 to 3249000
	loop
	    clk  <= '1'  ;
	   wait for 2 ns ;
	    clk  <= '0'  ;
	   wait for 2 ns ;
-- 12998 ns, repeat pattern in loop.
	end  loop;
	 clk  <= '1'  ;
	wait for 2 ns ;
-- dumped values till 13 us
	wait;
 End Process;


-- "Counter Pattern"(Range-Up) : step = 1 Range(0000000000000-0000111100000)
-- Start Time = 0 ns, End Time = 13 ms, Period = 25600 ns
  Process
	variable VARpx_y  : std_logic_vector(12 downto 0);
	Begin
	VARpx_y  := "0000000000000" ;
	for repeatLength in 1 to 507
	loop
	    px_y  <= VARpx_y  ;
	   wait for 25600 ns ;
	   VARpx_y  := VARpx_y  + 1 ;
	   if VARpx_y  = Y_RES then
			VARpx_y := (others=>'0');
		end if;
	end loop;
	wait;
 End Process;
END;
