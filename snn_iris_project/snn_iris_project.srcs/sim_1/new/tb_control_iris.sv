`timescale 1ns/1ps

module tb_control_iris;
    reg  clk;
    reg  reset_n;
    wire sample_reset;
    wire reset_ly1;
    wire reset_ly2;
    wire reset_ly3;
    wire reset_ly4;
    wire count_enable;
    wire result_valid;
    
    control_iris #(
        .TIME_STEPS    (8),  // Reduced for simulation
        .PIPELINE_DEPTH(2)   // Reduced for simulation
    ) uut (
        .clk         (clk),
        .reset_n     (reset_n),
        .sample_reset(sample_reset),
        .reset_ly1   (reset_ly1),
        .reset_ly2   (reset_ly2),
        .reset_ly3   (reset_ly3),
        .reset_ly4   (reset_ly4),
        .count_enable(count_enable),
        .result_valid(result_valid)
    );

    always #5 clk = ~clk;
    
    initial begin
        clk     = 0;
        reset_n = 0;
        #20 reset_n = 1;
        
        // Wait for 2 complete processing cycles
        repeat(2) @(posedge result_valid);
        #50 $finish;
    end
    
    always @(posedge result_valid) begin
        $display($time, " Result valid pulse detected");
    end
    
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_control_iris);
    end

endmodule