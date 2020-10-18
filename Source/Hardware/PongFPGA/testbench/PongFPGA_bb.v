
module PongFPGA (
	clk_clk,
	reset_reset_n,
	hdmi_output_clk,
	hdmi_output_data);	

	input		clk_clk;
	input		reset_reset_n;
	output		hdmi_output_clk;
	output	[2:0]	hdmi_output_data;
endmodule
