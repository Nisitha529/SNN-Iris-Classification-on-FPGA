module snn_iris_top (
    input         clk,         // System clock
    input         reset_n,     // Active-low reset
    input  [7:0]  f0,          // Feature 0
    input  [7:0]  f1,          // Feature 1
    input  [7:0]  f2,          // Feature 2
    input  [7:0]  f3,          // Feature 3
    output [2:0]  class_out,   // Output class (one-hot)
    output        result_valid // Result valid
);

    // Parameters
    localparam TIME_STEPS      = 64;
    localparam PIPELINE_DELAY  = 8;
    localparam TOTAL_CYCLES    = PIPELINE_DELAY + TIME_STEPS;

    // Control signals
    wire        reset        = ~reset_n;
    wire        sample_reset;
    wire        reset_ly1;
    wire        reset_ly2;
    wire        reset_ly3;
    wire        reset_ly4;
    wire        count_enable;
    
    // Input spikes
    wire        sp0;
    wire        sp1;
    wire        sp2;
    wire        sp3;
    
    // Layer outputs
    wire [7:0]  spikes_layer1;
    wire [5:0]  spikes_layer2;
    wire [3:0]  spikes_layer3;
    wire [2:0]  spikes_layer4;
    
    // Counters
    reg  [7:0]  count0;
    reg  [7:0]  count1;
    reg  [7:0]  count2;
    reg  [7:0]  final_count0, final_count1, final_count2;
    reg  [2:0]  class_reg;
    reg  [15:0] global_cycle; 

    // Control module
    control_iris #(
        .TIME_STEPS    (TIME_STEPS),
        .PIPELINE_DEPTH(PIPELINE_DELAY)
    ) ctrl (
        .clk          (clk),
        .reset_n      (reset_n),
        .sample_reset (sample_reset),
        .reset_ly1    (reset_ly1),
        .reset_ly2    (reset_ly2),
        .reset_ly3    (reset_ly3),
        .reset_ly4    (reset_ly4),
        .count_enable (count_enable),
        .result_valid (result_valid)
    );
    
    always @(posedge clk or posedge reset) begin
      if (reset) begin
        global_cycle <= 0;
      end else if (sample_reset) begin
        global_cycle <= 0;  // Reset at start of new sample
      end else if (global_cycle < TOTAL_CYCLES) begin
        global_cycle <= global_cycle + 1;  // Increment until end
      end
    end

    // Input spike generators
    gen_input_single gen_f0 ( .clk(clk), .reset(sample_reset), .feature(f0), .spike_out(sp0) );
    gen_input_single gen_f1 ( .clk(clk), .reset(sample_reset), .feature(f1), .spike_out(sp1) );
    gen_input_single gen_f2 ( .clk(clk), .reset(sample_reset), .feature(f2), .spike_out(sp2) );
    gen_input_single gen_f3 ( .clk(clk), .reset(sample_reset), .feature(f3), .spike_out(sp3) );

    // Network layers
    layer1_4to8 layer1 (
        .clk          (clk),
        .reset        (reset),
        .layer_enable (1'b1),
        .neuron_reset (reset_ly1),
        .spikes_in    ({sp3, sp2, sp1, sp0}),
        .spikes_out   (spikes_layer1)
    );

    layer2_8to6 layer2 (
        .clk          (clk),
        .reset        (reset),
        .layer_enable (1'b1),
        .neuron_reset (reset_ly2),
        .spikes_in    (spikes_layer1),
        .spikes_out   (spikes_layer2)
    );

    layer3_6to4 layer3 (
        .clk          (clk),
        .reset        (reset),
        .layer_enable (1'b1),
        .neuron_reset (reset_ly3),
        .spikes_in    (spikes_layer2),
        .spikes_out   (spikes_layer3)
    );

    layer4_4to3 layer4 (
        .clk          (clk),
        .reset        (reset),
        .layer_enable (1'b1),
        .neuron_reset (reset_ly4),
        .spikes_in    (spikes_layer3),
        .spikes_out   (spikes_layer4)
    );

    // Spike counters
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count0 <= 0;
            count1 <= 0;
            count2 <= 0;
        end
        else if (count_enable) begin
            count0 <= count0 + spikes_layer4[0];
            count1 <= count1 + spikes_layer4[1];
            count2 <= count2 + spikes_layer4[2];
        end
        else if (result_valid) begin
            count0 <= 0;
            count1 <= 0;
            count2 <= 0;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            final_count0 <= 0;
            final_count1 <= 0;
            final_count2 <= 0;
        end else if (count_enable && (global_cycle == (TOTAL_CYCLES - 1))) begin
            // Capture at last cycle of simulation
            final_count0 <= count0;
            final_count1 <= count1;
            final_count2 <= count2;
        end
    end

    // Classification decision
    always @(posedge clk) begin
        if (result_valid) begin
            if (final_count0 >= final_count1 && final_count0 >= final_count2) begin
                class_reg <= 3'b001;  // Class 0
            end
            else if (final_count1 >= final_count0 && final_count1 >= final_count2) begin
                class_reg <= 3'b010;  // Class 1
            end
            else begin
                class_reg <= 3'b100;  // Class 2
            end
        end
    end

    assign class_out = class_reg;

endmodule