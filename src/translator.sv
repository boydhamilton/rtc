

module translator(

	input logic clk,
	input wire rst,

	output logic [15:0] hours, // 16 bit, hours are largest unit so dont fold over
	output logic [7:0] mins,
	output logic [7:0] secs
);

always_ff @(posedge clk or posedge rst) begin
	
	if(rst)begin
		secs <= 0;
		mins <= 0;
		hours <= 0;
	end else begin

		if(secs == 59) begin
		secs <= 0;

		if(mins == 59) begin
		mins <= 0;
		hours <= hours + 1;
		end else begin
		mins <= mins + 1;
		end

		end else begin
		secs <= secs + 1;
		end
	end

end

endmodule
