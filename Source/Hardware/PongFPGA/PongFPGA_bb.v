
module PongFPGA (
	altpll_0_pll_slave_read,
	altpll_0_pll_slave_write,
	altpll_0_pll_slave_address,
	altpll_0_pll_slave_readdata,
	altpll_0_pll_slave_writedata,
	clk_clk,
	hdmi_output_clk,
	hdmi_output_data,
	reset_reset_n);	

	input		altpll_0_pll_slave_read;
	input		altpll_0_pll_slave_write;
	input	[1:0]	altpll_0_pll_slave_address;
	output	[31:0]	altpll_0_pll_slave_readdata;
	input	[31:0]	altpll_0_pll_slave_writedata;
	input		clk_clk;
	output		hdmi_output_clk;
	output	[2:0]	hdmi_output_data;
	input		reset_reset_n;
endmodule
