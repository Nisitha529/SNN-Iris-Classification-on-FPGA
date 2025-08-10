`timescale 1ns / 1ps
// Auto-generated layer module for layer1_4to8
// Input size: 4, Output size: 8

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
        .WEIGHTS      ({103, -4, -44, -63, 0, 0, 0, 0}),
        .BIAS         (-191),
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
        .WEIGHTS      ({ 126, 75, 117, -8, 0, 0, 0, 0 }),
        .BIAS         (78),
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
        .WEIGHTS      ({ -88, 21, -47, -155, 0, 0, 0, 0 }),
        .BIAS         (-37),
        .V_TH         (256)
    ) neuron_2 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_2)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ 97, -43, 31, 61, 0, 0, 0, 0 }),
        .BIAS         (58),
        .V_TH         (256)
    ) neuron_3 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_3)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ -57, -159, 155, 27, 0, 0, 0, 0 }),
        .BIAS         (11),
        .V_TH         (256)
    ) neuron_4 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_4)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ 38, -53, -56, -138, 0, 0, 0, 0 }),
        .BIAS         (146),
        .V_TH         (256)
    ) neuron_5 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_5)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ 27, 57, -138, 92, 0, 0, 0, 0 }),
        .BIAS         (166),
        .V_TH         (256)
    ) neuron_6 (
        .clk          (clk),
        .reset        (reset),
        .spikes_i     (spikes_in),
        .neuron_reset (neuron_reset),
        .spike_out    (spike_out_6)
    );

    neuron_1 #(
        .NUM_INPUTS   (4),
        .WEIGHTS      ({ 39, -1, 22, 148, 0, 0, 0, 0 }),
        .BIAS         (-96),
        .V_TH         (256)
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
