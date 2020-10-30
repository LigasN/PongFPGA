	component PongFPGA is
		port (
			clk_clk          : in  std_logic                    := 'X'; -- clk
			hdmi_output_clk  : out std_logic;                           -- output_clk
			hdmi_output_data : out std_logic_vector(2 downto 0);        -- output_data
			reset_reset_n    : in  std_logic                    := 'X'  -- reset_n
		);
	end component PongFPGA;

	u0 : component PongFPGA
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --   clk.clk
			hdmi_output_clk  => CONNECTED_TO_hdmi_output_clk,  --  hdmi.output_clk
			hdmi_output_data => CONNECTED_TO_hdmi_output_data, --      .output_data
			reset_reset_n    => CONNECTED_TO_reset_reset_n     -- reset.reset_n
		);

