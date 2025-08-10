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
        .WEIGHTS      ({ 109, 14, -27, 48, 0, 0, 0, 0 }),
        .BIAS         (-25),
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
        .WEIGHTS      ({ 31, 90, 106, -92, 0, 0, 0, 0 }),
        .BIAS         (-12),
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
        .WEIGHTS      ({ -156, -96, -30, -46, 0, 0, 0, 0 }),
        .BIAS         (63),
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
