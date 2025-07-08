`timescale 1ns / 1ps
// Auto-generated layer module for layer3_6to4
// Input size: 6, Output size: 4

module layer3_6to4 (
    input clk,
    input reset,
    input layer_enable,
    input neuron_reset,
    input [5:0] spikes_in,
    output [3:0] spikes_out
);

    snn_neuron_6in #(
        .w0(16'b0000000001101011),
        .w1(16'b1111111110101110),
        .w2(16'b1111111111011001),
        .w3(16'b0000000001111001),
        .w4(16'b0000000001111101),
        .w5(16'b0000000001110101),
        .bias(16'b0000000000010100),
        .v_th(32'b00000000000000000000000100000000)
    ) neuron_0 (
        .clk(clk),
        .reset(reset),
        .neuron_enable(layer_enable),
        .neuron_reset(neuron_reset),
        .spike_out(spike_out_0),
        .sp_0(spikes_in[0]),
        .sp_1(spikes_in[1]),
        .sp_2(spikes_in[2]),
        .sp_3(spikes_in[3]),
        .sp_4(spikes_in[4]),
        .sp_5(spikes_in[5]),
    );

    snn_neuron_6in #(
        .w0(16'b1111111111011101),
        .w1(16'b0000000001010010),
        .w2(16'b1111111110000101),
        .w3(16'b1111111110111100),
        .w4(16'b1111111111011000),
        .w5(16'b0000000010000010),
        .bias(16'b0000000001111001),
        .v_th(32'b00000000000000000000000100000000)
    ) neuron_1 (
        .clk(clk),
        .reset(reset),
        .neuron_enable(layer_enable),
        .neuron_reset(neuron_reset),
        .spike_out(spike_out_1),
        .sp_0(spikes_in[0]),
        .sp_1(spikes_in[1]),
        .sp_2(spikes_in[2]),
        .sp_3(spikes_in[3]),
        .sp_4(spikes_in[4]),
        .sp_5(spikes_in[5]),
    );

    snn_neuron_6in #(
        .w0(16'b1111111111111001),
        .w1(16'b0000000000010101),
        .w2(16'b1111111110101000),
        .w3(16'b1111111111000010),
        .w4(16'b1111111111101010),
        .w5(16'b1111111101101101),
        .bias(16'b1111111111000001),
        .v_th(32'b00000000000000000000000100000000)
    ) neuron_2 (
        .clk(clk),
        .reset(reset),
        .neuron_enable(layer_enable),
        .neuron_reset(neuron_reset),
        .spike_out(spike_out_2),
        .sp_0(spikes_in[0]),
        .sp_1(spikes_in[1]),
        .sp_2(spikes_in[2]),
        .sp_3(spikes_in[3]),
        .sp_4(spikes_in[4]),
        .sp_5(spikes_in[5]),
    );

    snn_neuron_6in #(
        .w0(16'b0000000010001101),
        .w1(16'b1111111110001011),
        .w2(16'b0000000001101100),
        .w3(16'b0000000000011000),
        .w4(16'b0000000001111010),
        .w5(16'b0000000001110111),
        .bias(16'b0000000000101010),
        .v_th(32'b00000000000000000000000100000000)
    ) neuron_3 (
        .clk(clk),
        .reset(reset),
        .neuron_enable(layer_enable),
        .neuron_reset(neuron_reset),
        .spike_out(spike_out_3),
        .sp_0(spikes_in[0]),
        .sp_1(spikes_in[1]),
        .sp_2(spikes_in[2]),
        .sp_3(spikes_in[3]),
        .sp_4(spikes_in[4]),
        .sp_5(spikes_in[5]),
    );

    // Combine individual neuron outputs
    assign spikes_out = {spike_out_3, spike_out_2, spike_out_1, spike_out_0};

endmodule
