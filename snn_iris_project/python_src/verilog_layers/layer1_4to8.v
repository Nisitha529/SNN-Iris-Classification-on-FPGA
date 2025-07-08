`timescale 1ns / 1ps
// Auto-generated layer module for layer1_4to8
// Input size: 4, Output size: 8

module layer1_4to8 (
    input clk,
    input reset,
    input layer_enable,
    input neuron_reset,
    input [3:0] spikes_in,
    output [7:0] spikes_out
);

    snn_neuron_4in #(
        .w0(16'b1111111111010010),
        .w1(16'b0000000000111010),
        .w2(16'b0000000001010010),
        .w3(16'b1111111110000010),
        .bias(16'b0000000010000110),
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
    );

    snn_neuron_4in #(
        .w0(16'b1111111111000001),
        .w1(16'b0000000000111010),
        .w2(16'b1111111110111101),
        .w3(16'b1111111101101111),
        .bias(16'b1111111111100110),
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
    );

    snn_neuron_4in #(
        .w0(16'b1111111110100110),
        .w1(16'b1111111111100110),
        .w2(16'b1111111110001101),
        .w3(16'b1111111111001001),
        .bias(16'b1111111111111100),
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
    );

    snn_neuron_4in #(
        .w0(16'b1111111111011110),
        .w1(16'b1111111110100110),
        .w2(16'b0000000001101100),
        .w3(16'b0000000000111011),
        .bias(16'b0000000000111110),
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
    );

    snn_neuron_4in #(
        .w0(16'b0000000000111001),
        .w1(16'b0000000001001000),
        .w2(16'b1111111101101101),
        .w3(16'b1111111110011111),
        .bias(16'b1111111111011000),
        .v_th(32'b00000000000000000000000100000000)
    ) neuron_4 (
        .clk(clk),
        .reset(reset),
        .neuron_enable(layer_enable),
        .neuron_reset(neuron_reset),
        .spike_out(spike_out_4),
        .sp_0(spikes_in[0]),
        .sp_1(spikes_in[1]),
        .sp_2(spikes_in[2]),
        .sp_3(spikes_in[3]),
    );

    snn_neuron_4in #(
        .w0(16'b1111111111000100),
        .w1(16'b1111111111001110),
        .w2(16'b0000000001100101),
        .w3(16'b0000000010000101),
        .bias(16'b1111111111011000),
        .v_th(32'b00000000000000000000000100000000)
    ) neuron_5 (
        .clk(clk),
        .reset(reset),
        .neuron_enable(layer_enable),
        .neuron_reset(neuron_reset),
        .spike_out(spike_out_5),
        .sp_0(spikes_in[0]),
        .sp_1(spikes_in[1]),
        .sp_2(spikes_in[2]),
        .sp_3(spikes_in[3]),
    );

    snn_neuron_4in #(
        .w0(16'b1111111111100011),
        .w1(16'b1111111110111001),
        .w2(16'b1111111110111001),
        .w3(16'b0000000000110011),
        .bias(16'b1111111101100011),
        .v_th(32'b00000000000000000000000100000000)
    ) neuron_6 (
        .clk(clk),
        .reset(reset),
        .neuron_enable(layer_enable),
        .neuron_reset(neuron_reset),
        .spike_out(spike_out_6),
        .sp_0(spikes_in[0]),
        .sp_1(spikes_in[1]),
        .sp_2(spikes_in[2]),
        .sp_3(spikes_in[3]),
    );

    snn_neuron_4in #(
        .w0(16'b0000000000010011),
        .w1(16'b0000000000110101),
        .w2(16'b0000000001111101),
        .w3(16'b0000000001100110),
        .bias(16'b1111111111010101),
        .v_th(32'b00000000000000000000000100000000)
    ) neuron_7 (
        .clk(clk),
        .reset(reset),
        .neuron_enable(layer_enable),
        .neuron_reset(neuron_reset),
        .spike_out(spike_out_7),
        .sp_0(spikes_in[0]),
        .sp_1(spikes_in[1]),
        .sp_2(spikes_in[2]),
        .sp_3(spikes_in[3]),
    );

    // Combine individual neuron outputs
    assign spikes_out = {spike_out_7, spike_out_6, spike_out_5, spike_out_4, spike_out_3, spike_out_2, spike_out_1, spike_out_0};

endmodule
