
module PongFPGA (
	clk_clk,
	hdmidriver_hdmi_output_clk,
	hdmidriver_hdmi_output_data,
	reset_reset_n);	

	input		clk_clk;
	output		hdmidriver_hdmi_output_clk;
	output	[2:0]	hdmidriver_hdmi_output_data;
	input		reset_reset_n;
endmodule
