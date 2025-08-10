

module rtc(

	input clk,
	input rst,

	output logic [7:0] secs,
	output logic [7:0] mins,
	output logic [15:0] hours
);


logic sec_tick;
ticker t(
	.clk(clk),
	.rst(rst),
	.sec_clk(sec_tick)
);	

translator trans(
	.clk(sec_tick),
	.rst(rst),
	.secs(secs),
	.mins(mins),
	.hours(hours)
);

endmodule

