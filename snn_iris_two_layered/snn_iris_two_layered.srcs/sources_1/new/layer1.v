`timescale 1ns / 1ps
// Updated layer module for layer1_4to8
// Input size: 4, Output size: 8
// Weights scaled by 128, Threshold set to 128

module layer1_4to8 (
    input        clk,
    input        reset,
    input        layer_enable,
    input        neuron_reset,
    input  [3:0] spikes_in,
    output [7:0] spikes_out
);

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({  3,  34,  20, -54, 0, 0, 0, 0}), // Converted weights
        .BIAS         (-24),                               // Converted bias
        .V_TH         (128)                                // Updated threshold
    ) neuron_0 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_0)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({-10, -48,  59,  74, 0, 0, 0, 0}),
        .BIAS         (-37),
        .V_TH         (128)
    ) neuron_1 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_1)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({-52,  23, -65,  18, 0, 0, 0, 0}),
        .BIAS         (27),
        .V_TH         (128)
    ) neuron_2 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_2)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({-12, -53,   3,   2, 0, 0, 0, 0}),
        .BIAS         (-54),
        .V_TH         (128)
    ) neuron_3 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_3)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ 29,  -2,  30,  29, 0, 0, 0, 0}),
        .BIAS         (-11),
        .V_TH         (128)
    ) neuron_4 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_4)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ 25,  57, -62,  11, 0, 0, 0, 0}),
        .BIAS         (-62),
        .V_TH         (128)
    ) neuron_5 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_5)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({-21, -19,  44, -24, 0, 0, 0, 0}),
        .BIAS         (47),
        .V_TH         (128)
    ) neuron_6 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_6)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ 55, -49, -54,  21, 0, 0, 0, 0}),
        .BIAS         (-53),
        .V_TH         (128)
    ) neuron_7 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_7)
    );

    // Combine individual neuron outputs
    assign spikes_out = {spike_out_7, spike_out_6, spike_out_5, spike_out_4, spike_out_3, spike_out_2, spike_out_1, spike_out_0};

endmodule