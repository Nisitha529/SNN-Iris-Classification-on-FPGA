module gen_input_single (
    input        clk,
    input        reset,
    input  [7:0] feature,   
    output reg   spike_out
);

    reg [7:0] random = 8'b00000001;

    always @(posedge clk) begin
        if (reset) begin
            random <= 8'b00000001;
        end else begin
            random[0] <= random[7] ^ random[5] ^ random[4] ^ random[3];
            random[7:1] <= random[6:0];
        end
        spike_out <= (random < feature) ? 1'b1 : 1'b0;
    end

endmodule