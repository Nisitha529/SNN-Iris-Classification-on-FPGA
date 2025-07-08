`timescale 1ns / 1ps
// Auto-generated layer module for layer2_8to6
// Input size: 8, Output size: 6

module layer2_8to6 (
    input clk,
    input reset,
    input layer_enable,
    input neuron_reset,
    input [7:0] spikes_in,
    output [5:0] spikes_out
);

    snn_neuron_8in #(
        .w0(16'b0000000000001010),
        .w1(16'b0000000000011111),
        .w2(16'b1111111110111011),
        .w3(16'b0000000001000100),
        .w4(16'b0000000000010101),
        .w5(16'b0000000001010011),
        .w6(16'b1111111111100100),
        .w7(16'b0000000001110110),
        .bias(16'b1111111111010100),
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
        .sp_6(spikes_in[6]),
        .sp_7(spikes_in[7]),
    );

    snn_neuron_8in #(
        .w0(16'b0000000001100100),
        .w1(16'b0000000001100111),
        .w2(16'b0000000001100101),
        .w3(16'b1111111111001110),
        .w4(16'b0000000000001010),
        .w5(16'b1111111110010001),
        .w6(16'b1111111111001011),
        .w7(16'b0000000000010011),
        .bias(16'b1111111111111001),
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
        .sp_6(spikes_in[6]),
        .sp_7(spikes_in[7]),
    );

    snn_neuron_8in #(
        .w0(16'b1111111111011100),
        .w1(16'b1111111110011110),
        .w2(16'b1111111111011011),
        .w3(16'b0000000000000100),
        .w4(16'b1111111110111101),
        .w5(16'b0000000001001101),
        .w6(16'b1111111111000101),
        .w7(16'b0000000000101010),
        .bias(16'b0000000000100010),
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
        .sp_6(spikes_in[6]),
        .sp_7(spikes_in[7]),
    );

    snn_neuron_8in #(
        .w0(16'b1111111111110010),
        .w1(16'b1111111110011100),
        .w2(16'b0000000000001100),
        .w3(16'b0000000010010001),
        .w4(16'b0000000000010011),
        .w5(16'b0000000000111111),
        .w6(16'b1111111111011001),
        .w7(16'b0000000001011111),
        .bias(16'b0000000000111100),
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
        .sp_6(spikes_in[6]),
        .sp_7(spikes_in[7]),
    );

    snn_neuron_8in #(
        .w0(16'b1111111110110110),
        .w1(16'b0000000000000000),
        .w2(16'b1111111110111010),
        .w3(16'b1111111111111001),
        .w4(16'b1111111110011010),
        .w5(16'b0000000001000001),
        .w6(16'b0000000000100011),
        .w7(16'b0000000001110100),
        .bias(16'b0000000001011100),
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
        .sp_4(spikes_in[4]),
        .sp_5(spikes_in[5]),
        .sp_6(spikes_in[6]),
        .sp_7(spikes_in[7]),
    );

    snn_neuron_8in #(
        .w0(16'b1111111111101110),
        .w1(16'b0000000000110010),
        .w2(16'b0000000000000111),
        .w3(16'b0000000001010001),
        .w4(16'b0000000001001110),
        .w5(16'b0000000000001000),
        .w6(16'b1111111111001101),
        .w7(16'b1111111111101000),
        .bias(16'b0000000000101000),
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
        .sp_4(spikes_in[4]),
        .sp_5(spikes_in[5]),
        .sp_6(spikes_in[6]),
        .sp_7(spikes_in[7]),
    );

    // Combine individual neuron outputs
    assign spikes_out = {spike_out_5, spike_out_4, spike_out_3, spike_out_2, spike_out_1, spike_out_0};

endmodule
