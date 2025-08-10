`timescale 1ns / 1ps
// Auto-generated layer module for layer2_8to6
// Input size: 8, Output size: 6

module layer2_8to6 (
    input        clk,
    input        reset,
    input        layer_enable,
    input        neuron_reset,
    input  [7:0] spikes_in,
    output [5:0] spikes_out
);

    neuron_1 #(
        .NUM_INPUTS   (8),
        .WEIGHTS      ({ 1, 79, 121, -22, -17, 115, 100, -181 }),
        .BIAS         (19),
        .V_TH         (256)
    ) neuron_0 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_0)
    );

    neuron_1 #(
        .NUM_INPUTS   (8),
        .WEIGHTS      ({ -46, -48, 71, -51, -118, 43, 14, 2 }),
        .BIAS         (97),
        .V_TH         (256)
    ) neuron_1 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_1)
    );

    neuron_1 #(
        .NUM_INPUTS   (8),
        .WEIGHTS      ({ 5, 18, 113, -30, 13, 112, 127, -164 }),
        .BIAS         (-1),
        .V_TH         (256)
    ) neuron_2 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_2)
    );

    neuron_1 #(
        .NUM_INPUTS   (8),
        .WEIGHTS      ({ -78, 9, 89, -67, 53, 151, 109, -55 }),
        .BIAS         (-15),
        .V_TH         (256)
    ) neuron_3 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_3)
    );

    neuron_1 #(
        .NUM_INPUTS   (8),
        .WEIGHTS      ({ 28, 24, -98, -30, -87, 48, 92, -159 }),
        .BIAS         (100),
        .V_TH         (256)
    ) neuron_4 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_4)
    );

    neuron_1 #(
        .NUM_INPUTS   (8),
        .WEIGHTS      ({ -65, 85, -130, 112, 75, 23, 50, 95 }),
        .BIAS         (68),
        .V_TH         (256)
    ) neuron_5 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_5)
    );


    // Combine individual neuron outputs
    assign spikes_out = {spike_out_5, spike_out_4, spike_out_3, spike_out_2, spike_out_1, spike_out_0};

endmodule
