LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY HDMIDriver_tb  IS 
  GENERIC (
    ROW_SYNC_PULSE  : INTEGER   := 2 ;  
    PX_SYNC_PULSE  : INTEGER   := 96 ;  
    DISPLAY_RES_WIDTH  : INTEGER   := 640 ;  
    ROW_BACK_PORCH  : INTEGER   := 33 ;  
    ROW_FRONT_PORCH  : INTEGER   := 10 ;  
    PX_BACK_PORCH  : INTEGER   := 48 ;  
    PX_FRONT_PORCH  : INTEGER   := 16 ;  
    DISPLAY_RES_HEIGHT  : INTEGER   := 480 ); 
END ; 
 
ARCHITECTURE HDMIDriver_tb_arch   OF HDMIDriver_tb  IS
  SIGNAL px_y   :  std_logic_vector (12 downto 0)  ; 
  SIGNAL px_color   :  STD_LOGIC  ; 
  SIGNAL output_data   :  std_logic_vector (2 downto 0)  ; 
  SIGNAL output_clk   :  STD_LOGIC  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL px_x   :  std_logic_vector (12 downto 0)  ; 
  SIGNAL HDMI_clk   :  STD_LOGIC  ; 
  COMPONENT HDMIDriver  
    GENERIC ( 
      ROW_SYNC_PULSE  : INTEGER ; 
      PX_SYNC_PULSE  : INTEGER ; 
      DISPLAY_RES_WIDTH  : INTEGER ; 
      ROW_BACK_PORCH  : INTEGER ; 
      ROW_FRONT_PORCH  : INTEGER ; 
      PX_BACK_PORCH  : INTEGER ; 
      PX_FRONT_PORCH  : INTEGER ; 
      DISPLAY_RES_HEIGHT  : INTEGER  );  
    PORT ( 
      px_y  : out std_logic_vector (12 downto 0) ; 
      px_color  : in STD_LOGIC ; 
      output_data  : out std_logic_vector (2 downto 0) ; 
      output_clk  : out STD_LOGIC ; 
      clk  : in STD_LOGIC ; 
      px_x  : out std_logic_vector (12 downto 0) ; 
      HDMI_clk  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : HDMIDriver  
    GENERIC MAP ( 
      ROW_SYNC_PULSE  => ROW_SYNC_PULSE  ,
      PX_SYNC_PULSE  => PX_SYNC_PULSE  ,
      DISPLAY_RES_WIDTH  => DISPLAY_RES_WIDTH  ,
      ROW_BACK_PORCH  => ROW_BACK_PORCH  ,
      ROW_FRONT_PORCH  => ROW_FRONT_PORCH  ,
      PX_BACK_PORCH  => PX_BACK_PORCH  ,
      PX_FRONT_PORCH  => PX_FRONT_PORCH  ,
      DISPLAY_RES_HEIGHT  => DISPLAY_RES_HEIGHT   )
    PORT MAP ( 
      px_y   => px_y  ,
      px_color   => px_color  ,
      output_data   => output_data  ,
      output_clk   => output_clk  ,
      clk   => clk  ,
      px_x   => px_x  ,
      HDMI_clk   => HDMI_clk   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, Period = 4 ns
  Process
	Begin
	 clk  <= '0'  ;
	wait for 20 ns ;
-- 2 ns, single loop till start period.
	for Z in 1 to 325000
	loop
	    clk  <= '1'  ;
	   wait for 20 ns ;
	    clk  <= '0'  ;
	   wait for 20 ns ;
-- 10 ns, repeat pattern in loop.
	end  loop;
	 clk  <= '1'  ;
	wait for 20 ns ;
	 clk  <= '0'  ;
	wait for 10 ns ;
-- dumped values till 13 ns
	wait;
 End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 13 ms, Period = 40 ns
  Process
	Begin
	 HDMI_clk  <= '0'  ;
	wait for 2 ns ;
-- 2 ns, single loop till start period.
	for Z in 1 to 3250000
	loop
	    HDMI_clk  <= '1'  ;
	   wait for 2 ns ;
	    HDMI_clk  <= '0'  ;
	   wait for 2 ns ;
-- 10 ns, repeat pattern in loop.
	end  loop;
	wait;
 End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 13 ms, Period = 800 ns
  Process
	Begin
	 px_color  <= '0'  ;
	wait for 400 ns ;
	for Z in 1 to 16250
	loop
	    px_color  <= '1'  ;
	   wait for 400 ns ;
	    px_color  <= '0'  ;
	   wait for 400 ns ;
-- 10 ns, repeat pattern in loop.
	end  loop;
	wait;
 End Process;
END;
