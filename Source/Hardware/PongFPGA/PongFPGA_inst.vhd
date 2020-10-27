	component PongFPGA is
		port (
			altpll_0_pll_slave_read      : in  std_logic                     := 'X';             -- read
			altpll_0_pll_slave_write     : in  std_logic                     := 'X';             -- write
			altpll_0_pll_slave_address   : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			altpll_0_pll_slave_readdata  : out std_logic_vector(31 downto 0);                    -- readdata
			altpll_0_pll_slave_writedata : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			clk_clk                      : in  std_logic                     := 'X';             -- clk
			hdmi_output_clk              : out std_logic;                                        -- output_clk
			hdmi_output_data             : out std_logic_vector(2 downto 0);                     -- output_data
			reset_reset_n                : in  std_logic                     := 'X'              -- reset_n
		);
	end component PongFPGA;

	u0 : component PongFPGA
		port map (
			altpll_0_pll_slave_read      => CONNECTED_TO_altpll_0_pll_slave_read,      -- altpll_0_pll_slave.read
			altpll_0_pll_slave_write     => CONNECTED_TO_altpll_0_pll_slave_write,     --                   .write
			altpll_0_pll_slave_address   => CONNECTED_TO_altpll_0_pll_slave_address,   --                   .address
			altpll_0_pll_slave_readdata  => CONNECTED_TO_altpll_0_pll_slave_readdata,  --                   .readdata
			altpll_0_pll_slave_writedata => CONNECTED_TO_altpll_0_pll_slave_writedata, --                   .writedata
			clk_clk                      => CONNECTED_TO_clk_clk,                      --                clk.clk
			hdmi_output_clk              => CONNECTED_TO_hdmi_output_clk,              --               hdmi.output_clk
			hdmi_output_data             => CONNECTED_TO_hdmi_output_data,             --                   .output_data
			reset_reset_n                => CONNECTED_TO_reset_reset_n                 --              reset.reset_n
		);

