
`timescale 1ns/1ps

module rtc_tb;

    // file handle
    int fout;

    // testbench signals
    logic clk;
    logic rst;
    logic [7:0] secs;
    logic [7:0] mins;
    logic [15:0] hours;

    // dut
    rtc uut (
        .clk(clk),
        .rst(rst),
        .secs(secs),
        .mins(mins),
        .hours(hours)
    );

    // 50 MHz clock: toggle every 10 ns
    always #10 clk = ~clk;

    // last recorded seconds value
    logic [7:0] last_secs;

    initial begin
        // file
        fout = $fopen("./out", "w");
        if (!fout) begin
            $display("ERROR: Could not open output file.");
            $finish;
        end

        clk = 0;
        rst = 1;
        last_secs = 8'hFF;

        // rst to start
        #100;
        rst = 0;

        repeat (100_000_000) begin @(posedge clk);
            // write when seconds change
            if (secs != last_secs) begin
                $fdisplay(fout, "%0d : %0d : %0d", hours, mins, secs);
                last_secs = secs;
            end

		if(hours == 2) begin
			rst = 1;
			#100 rst = 0;
		end
        end

        $fclose(fout);
        $finish;
    end

endmodule

