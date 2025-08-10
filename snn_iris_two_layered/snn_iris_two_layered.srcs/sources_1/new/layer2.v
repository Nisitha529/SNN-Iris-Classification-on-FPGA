`timescale 1ns / 1ps
// Updated layer module for layer2_8to3
// Input size: 8, Output size: 3
// Weights scaled by 128, Threshold set to 128

module layer2_8to3 (
    input        clk,
    input        reset,
    input        layer_enable,
    input        neuron_reset,
    input  [7:0] spikes_in,
    output [2:0] spikes_out  // Updated to 3-bit output
);

    // Neuron 0 (first row of weights)
    neuron_1 #(
        .NUM_INPUTS   (8),
        .WEIGHTS      ({  4, -22,  43,   8, -24,  25,   5, -26}), // Converted weights
        .BIAS         (17),                                        // Converted bias
        .V_TH         (128)                                        // Updated threshold
    ) neuron_0 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_0)
    );

    // Neuron 1 (second row of weights)
    neuron_1 #(
        .NUM_INPUTS   (8),
        .WEIGHTS      ({-29, -35, -11,  32, -15,   9,  33,  26}),
        .BIAS         (37),
        .V_TH         (128)
    ) neuron_1 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_1)
    );

    // Neuron 2 (third row of weights)
    neuron_1 #(
        .NUM_INPUTS   (8),
        .WEIGHTS      ({-23,  21, -13,  34,  -4, -37, -12, -41}),
        .BIAS         (30),
        .V_TH         (128)
    ) neuron_2 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_2)
    );

    // Combine outputs (neuron0 = LSB, neuron2 = MSB)
    assign spikes_out = {spike_out_2, spike_out_1, spike_out_0};

endmodule