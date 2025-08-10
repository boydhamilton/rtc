
`define CLK_SPEED 50

module ticker(

	input wire clk,

	input wire rst,

	output logic sec_clk
);


logic [31:0] counter = 0;


always_ff @(posedge clk or posedge rst) begin

	if(rst) begin 
		counter <= 0;
		sec_clk <= 0;
	end else begin
		counter <= counter + 1;
		if(counter == `CLK_SPEED/2 - 1) begin
			sec_clk <= ~sec_clk;
			counter <= 0;
		end
	end
end

endmodule
