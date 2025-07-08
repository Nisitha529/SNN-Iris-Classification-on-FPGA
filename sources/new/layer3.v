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
        .WEIGHTS      ({ 107, -82, -39, 121, 125, 117, 0, 0 }),
        .BIAS         (20),
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
        .WEIGHTS      ({ -35, 82, -123, -68, -40, 130, 0, 0 }),
        .BIAS         (121),
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
        .WEIGHTS      ({ -7, 21, -88, -62, -22, -147, 0, 0 }),
        .BIAS         (-63),
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
        .WEIGHTS      ({ 141, -117, 108, 24, 122, 119, 0, 0 }),
        .BIAS         (42),
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
