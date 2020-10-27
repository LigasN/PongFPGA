	PongFPGA u0 (
		.altpll_0_pll_slave_read      (<connected-to-altpll_0_pll_slave_read>),      // altpll_0_pll_slave.read
		.altpll_0_pll_slave_write     (<connected-to-altpll_0_pll_slave_write>),     //                   .write
		.altpll_0_pll_slave_address   (<connected-to-altpll_0_pll_slave_address>),   //                   .address
		.altpll_0_pll_slave_readdata  (<connected-to-altpll_0_pll_slave_readdata>),  //                   .readdata
		.altpll_0_pll_slave_writedata (<connected-to-altpll_0_pll_slave_writedata>), //                   .writedata
		.clk_clk                      (<connected-to-clk_clk>),                      //                clk.clk
		.hdmi_output_clk              (<connected-to-hdmi_output_clk>),              //               hdmi.output_clk
		.hdmi_output_data             (<connected-to-hdmi_output_data>),             //                   .output_data
		.reset_reset_n                (<connected-to-reset_reset_n>)                 //              reset.reset_n
	);

