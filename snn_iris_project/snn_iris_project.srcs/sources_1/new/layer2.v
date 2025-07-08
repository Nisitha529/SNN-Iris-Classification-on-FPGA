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
        .WEIGHTS      ({ 10, 31, -69, 68, 21, 83, -28, 118 }),
        .BIAS         (-44),
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
        .WEIGHTS      ({ 100, 103, 101, -50, 10, -111, -53, 19 }),
        .BIAS         (-7),
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
        .WEIGHTS      ({ -36, -98, -37, 4, -67, 77, -59, 42 }),
        .BIAS         (34),
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
        .WEIGHTS      ({ -14, -100, 12, 145, 19, 63, -39, 95 }),
        .BIAS         (60),
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
        .WEIGHTS      ({ -74, 0, -70, -7, -102, 65, 35, 116 }),
        .BIAS         (92),
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
        .WEIGHTS      ({ -18, 50, 7, 81, 78, 8, -51, -24 }),
        .BIAS         (40),
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
