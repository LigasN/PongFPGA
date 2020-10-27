LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 


ENTITY PongFPGA_tb  IS 
END ; 
 
ARCHITECTURE PongFPGA_tb_arch   OF PongFPGA_tb  IS
	SIGNAL clk_clk          :  std_logic; --   clk.clk
	SIGNAL hdmi_output_clk  :  std_logic;--  hdmi.output_clk
	SIGNAL hdmi_output_data :  std_logic_vector(2 downto 0);--output_data
	SIGNAL reset_reset_n    :  std_logic ;-- reset.reset_n
  
	COMPONENT PongFPGA   
    PORT ( 
      clk_clk          : in  std_logic;  
      hdmi_output_clk  : out std_logic;
      hdmi_output_data : out std_logic_vector(2 downto 0);
      reset_reset_n    : in  std_logic ); 
  END COMPONENT ; 
BEGIN
  DUT  : PongFPGA  
    PORT MAP ( 
      clk_clk   => clk_clk , 
      hdmi_output_clk   => hdmi_output_clk  , 
      hdmi_output_data   => hdmi_output_data  ,
      reset_reset_n   => reset_reset_n ) ; 

	  
  Process
	Begin
	for z in 1 to 200
	loop
	clk_clk  <= '1'  ;
	wait for 20 ns ;
	clk_clk  <= '0'  ;
	wait for 20 ns ;
	end loop;
	wait;
 End Process;

  Process
	Begin
	reset_reset_n <='0';
	wait;
 End Process;

END;