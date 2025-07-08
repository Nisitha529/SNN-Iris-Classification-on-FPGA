module control_iris #(
    parameter TIME_STEPS     = 64,
    parameter PIPELINE_DEPTH = 8
)(
    input  clk,
    input  reset_n,
    output reg sample_reset,
    output reg reset_ly1,
    output reg reset_ly2,
    output reg reset_ly3,
    output reg reset_ly4,
    output reg count_enable,
    output reg result_valid
);

    localparam LY1_RST_DELAY = 0;
    localparam LY2_RST_DELAY = 2;
    localparam LY3_RST_DELAY = 4;
    localparam LY4_RST_DELAY = 6;
    
    reg [15:0] cycle_count;
    wire       processing_done = (cycle_count == TIME_STEPS + PIPELINE_DEPTH);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            cycle_count  <= 0;
            sample_reset <= 1'b1;
            reset_ly1    <= 1'b1;
            reset_ly2    <= 1'b1;
            reset_ly3    <= 1'b1;
            reset_ly4    <= 1'b1;
            count_enable <= 1'b0;
            result_valid <= 1'b0;
        end else begin
            sample_reset <= 1'b0;
            reset_ly1    <= 1'b0;
            reset_ly2    <= 1'b0;
            reset_ly3    <= 1'b0;
            reset_ly4    <= 1'b0;
            result_valid <= 1'b0;
            
            if (processing_done) begin
                cycle_count  <= 0;
                result_valid <= 1'b1;
            end else begin
                cycle_count <= cycle_count + 1;
            end
            
            if (cycle_count == LY1_RST_DELAY) reset_ly1 <= 1'b1;
            if (cycle_count == LY2_RST_DELAY) reset_ly2 <= 1'b1;
            if (cycle_count == LY3_RST_DELAY) reset_ly3 <= 1'b1;
            if (cycle_count == LY4_RST_DELAY) reset_ly4 <= 1'b1;
            if (cycle_count == 0)            sample_reset <= 1'b1;
            
            count_enable <= (cycle_count >= PIPELINE_DEPTH) && 
                            (cycle_count < PIPELINE_DEPTH + TIME_STEPS);
        end
    end

endmodule