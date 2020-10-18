
module PongFPGA (
	clk_clk,
	hdmi_output_clk,
	hdmi_output_data,
	reset_reset_n);	

	input		clk_clk;
	output		hdmi_output_clk;
	output	[2:0]	hdmi_output_data;
	input		reset_reset_n;
endmodule
