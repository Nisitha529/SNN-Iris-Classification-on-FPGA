`timescale 1ns / 1ps
// Auto-generated layer module for layer3_6to4
// Input size: 6, Output size: 4

module layer3_6to4 (
    input        clk,
    input        reset,
    input        layer_enable,
    input        neuron_reset,
    input  [5:0] spikes_in,
    output [3:0] spikes_out
);

    neuron_1 #(
        .NUM_INPUTS   (6),
        .WEIGHTS      ({ 230, 33, 34, 89, 46, -34, 0, 0 }),
        .BIAS         (-30),
        .V_TH         (256)
    ) neuron_0 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_0)
    );

    neuron_1 #(
        .NUM_INPUTS   (6),
        .WEIGHTS      ({ 54, -10, -16, -18, 73, -62, 0, 0 }),
        .BIAS         (-122),
        .V_TH         (256)
    ) neuron_1 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_1)
    );

    neuron_1 #(
        .NUM_INPUTS   (6),
        .WEIGHTS      ({ 120, 79, 166, 149, 102, -51, 0, 0 }),
        .BIAS         (57),
        .V_TH         (256)
    ) neuron_2 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_2)
    );

    neuron_1 #(
        .NUM_INPUTS   (6),
        .WEIGHTS      ({ 62, 123, 75, 13, -10, -124, 0, 0 }),
        .BIAS         (43),
        .V_TH         (256)
    ) neuron_3 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_3)
    );


    // Combine individual neuron outputs
    assign spikes_out = {spike_out_3, spike_out_2, spike_out_1, spike_out_0};

endmodule
