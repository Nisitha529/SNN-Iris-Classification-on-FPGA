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
        .WEIGHTS      ({ -46, 58, 82, -126, 0, 0, 0, 0 }),
        .BIAS         (134),
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
        .WEIGHTS      ({ -63, 58, -67, -145, 0, 0, 0, 0 }),
        .BIAS         (-26),
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
        .WEIGHTS      ({ -90, -26, -115, -55, 0, 0, 0, 0 }),
        .BIAS         (-4),
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
        .WEIGHTS      ({ -34, -90, 108, 59, 0, 0, 0, 0 }),
        .BIAS         (62),
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
        .WEIGHTS      ({ 57, 72, -147, -97, 0, 0, 0, 0 }),
        .BIAS         (-40),
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
        .WEIGHTS      ({ -60, -50, 101, 133, 0, 0, 0, 0 }),
        .BIAS         (-40),
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
        .WEIGHTS      ({ -29, -71, -71, 51, 0, 0, 0, 0 }),
        .BIAS         (-157),
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
        .WEIGHTS      ({ 19, 53, 125, 102, 0, 0, 0, 0 }),
        .BIAS         (-43),
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
