`timescale 1ns / 1ps
// Auto-generated layer module for layer4_4to3
// Input size: 4, Output size: 3

module layer4_4to3 (
    input clk,
    input reset,
    input layer_enable,
    input neuron_reset,
    input [3:0] spikes_in,
    output [2:0] spikes_out
);

    snn_neuron_4in #(
        .w0(16'b1111111111101001),
        .w1(16'b0000000010100111),
        .w2(16'b1111111111110101),
        .w3(16'b1111111111001011),
        .bias(16'b1111111111101010),
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
        .w0(16'b0000000001100001),
        .w1(16'b0000000001100010),
        .w2(16'b1111111110011111),
        .w3(16'b0000000001000110),
        .bias(16'b1111111111101011),
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
        .w0(16'b0000000010001101),
        .w1(16'b1111111111100110),
        .w2(16'b1111111110110110),
        .w3(16'b0000000010100010),
        .bias(16'b1111111110100001),
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

    // Combine individual neuron outputs
    assign spikes_out = {spike_out_2, spike_out_1, spike_out_0};

endmodule
