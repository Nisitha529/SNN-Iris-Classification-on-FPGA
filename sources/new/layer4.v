`timescale 1ns / 1ps
// Auto-generated layer module for layer4_4to3
// Input size: 4, Output size: 3

module layer4_4to3 (
    input        clk,
    input        reset,
    input        layer_enable,
    input        neuron_reset,
    input  [3:0] spikes_in,
    output [2:0] spikes_out
);

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ -23, 167, -11, -53, 0, 0, 0, 0 }),
        .BIAS         (-22),
        .V_TH         (256)
    ) neuron_0 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_0)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ 97, 98, -97, 70, 0, 0, 0, 0 }),
        .BIAS         (-21),
        .V_TH         (256)
    ) neuron_1 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_1)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ 141, -26, -74, 162, 0, 0, 0, 0 }),
        .BIAS         (-95),
        .V_TH         (256)
    ) neuron_2 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_2)
    );


    // Combine individual neuron outputs
    assign spikes_out = {spike_out_2, spike_out_1, spike_out_0};

endmodule
