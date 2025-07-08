import os
import numpy as np
import glob

# Configuration
fixed_point_bits = 16  # 16-bit fixed-point representation
fixed_point_scale = 2**8  # Scale factor for Q8.8 fixed-point (8 integer, 8 fractional)
layer_config = [
    {"name": "layer1", "input_size": 4, "output_size": 8, "neuron_type": "snn_neuron_4in"},
    {"name": "layer2", "input_size": 8, "output_size": 6, "neuron_type": "snn_neuron_8in"},
    {"name": "layer3", "input_size": 6, "output_size": 4, "neuron_type": "snn_neuron_6in"},
    {"name": "layer4", "input_size": 4, "output_size": 3, "neuron_type": "snn_neuron_4in"}
]

# Get the script's directory
script_dir = os.path.dirname(os.path.abspath(__file__))

# Directory configuration - relative to script location
weights_dir = os.path.join(script_dir, "weights")
biases_dir = os.path.join(script_dir, "bias")  # Note: matches your directory name
thresholds_dir = os.path.join(script_dir, "thresholds")
verilog_output_dir = os.path.join(script_dir, "verilog_layers")

def float_to_fixed_binary(value, total_bits=16, fractional_bits=8):
    """Convert float to binary fixed-point representation"""
    # Scale value to fixed-point integer
    scaled = int(round(value * fixed_point_scale))
    
    # Handle negative values using two's complement
    if scaled < 0:
        scaled = (1 << total_bits) + scaled
    
    # Convert to binary string with specified bit width
    return format(scaled, f'0{total_bits}b')

def find_parameter_file(dir_path, pattern):
    """Find parameter file with the given pattern in the directory"""
    files = glob.glob(os.path.join(dir_path, pattern))
    if files:
        return files[0]
    return None

def load_layer_params(layer_name):
    """Load weights, biases, and thresholds for a layer from separate directories"""
    # Find weight file
    weight_pattern = f"{layer_name}_weights*.txt"
    weight_file = find_parameter_file(weights_dir, weight_pattern)
    if not weight_file:
        raise FileNotFoundError(f"Weight file for {layer_name} not found in {weights_dir}")
    
    # Find bias file
    bias_pattern = f"{layer_name}_biases*.txt"
    bias_file = find_parameter_file(biases_dir, bias_pattern)
    if not bias_file:
        raise FileNotFoundError(f"Bias file for {layer_name} not found in {biases_dir}")
    
    # Find threshold file
    threshold_pattern = f"{layer_name}_thresholds*.txt"
    threshold_file = find_parameter_file(thresholds_dir, threshold_pattern)
    if not threshold_file:
        raise FileNotFoundError(f"Threshold file for {layer_name} not found in {thresholds_dir}")
    
    # Load parameters
    weights = np.loadtxt(weight_file)
    biases = np.loadtxt(bias_file)
    thresholds = np.loadtxt(threshold_file)
    
    # Ensure proper shape for single-neuron layers
    if weights.ndim == 1:
        weights = weights.reshape(1, -1)
    
    print(f"Loaded parameters for {layer_name}:")
    print(f"  Weights: {os.path.basename(weight_file)} - Shape: {weights.shape}")
    print(f"  Biases: {os.path.basename(bias_file)} - Shape: {biases.shape}")
    print(f"  Thresholds: {os.path.basename(threshold_file)} - Shape: {thresholds.shape}")
    
    return weights, biases, thresholds

def generate_neuron_instantiation(layer_cfg, neuron_idx, weights, bias, threshold):
    """Generate Verilog instantiation for a single neuron"""
    neuron_type = layer_cfg["neuron_type"]
    param_str = f"#(\n        "
    
    # Add weight parameters
    weight_params = []
    for i, w in enumerate(weights):
        w_bin = float_to_fixed_binary(w)
        weight_params.append(f".w{i}(16'b{w_bin})")
    
    # Add bias and threshold
    bias_bin = float_to_fixed_binary(bias)
    threshold_bin = float_to_fixed_binary(threshold, total_bits=32, fractional_bits=16)
    
    # Combine all parameters
    param_str += ",\n        ".join(weight_params)
    param_str += f",\n        .bias(16'b{bias_bin}),\n"
    param_str += f"        .v_th(32'b{threshold_bin})\n"
    
    # Generate instantiation
    return f"    {neuron_type} {param_str}    ) neuron_{neuron_idx} (\n" \
           f"        .clk(clk),\n        .reset(reset),\n" \
           f"        .neuron_enable(layer_enable),\n" \
           f"        .neuron_reset(neuron_reset),\n" \
           f"        .spike_out(spike_out_{neuron_idx})"

def generate_layer_module(layer_cfg, output_dir):
    """Generate Verilog module for a complete layer in the specified directory"""
    weights, biases, thresholds = load_layer_params(layer_cfg["name"])
    module_name = f"{layer_cfg['name']}_{layer_cfg['input_size']}to{layer_cfg['output_size']}"
    filename = os.path.join(output_dir, f"{module_name}.v")
    
    with open(filename, 'w') as f:
        # Write module header
        f.write(f"`timescale 1ns / 1ps\n")
        f.write(f"// Auto-generated layer module for {module_name}\n")
        f.write(f"// Input size: {layer_cfg['input_size']}, Output size: {layer_cfg['output_size']}\n\n")
        
        f.write(f"module {module_name} (\n")
        f.write("    input clk,\n")
        f.write("    input reset,\n")
        f.write("    input layer_enable,\n")
        f.write("    input neuron_reset,\n")
        
        # Spike inputs
        if layer_cfg["input_size"] > 1:
            f.write(f"    input [{layer_cfg['input_size']-1}:0] spikes_in,\n")
        else:
            f.write("    input spikes_in,\n")
        
        # Spike outputs
        if layer_cfg["output_size"] > 1:
            f.write(f"    output [{layer_cfg['output_size']-1}:0] spikes_out\n")
        else:
            f.write("    output spikes_out\n")
        
        f.write(");\n\n")
        
        # Generate neuron instantiations
        for neuron_idx in range(layer_cfg["output_size"]):
            neuron_weights = weights[neuron_idx] if weights.shape[0] > 1 else weights[0]
            neuron_bias = biases[neuron_idx] if isinstance(biases, np.ndarray) else biases
            neuron_threshold = thresholds[neuron_idx] if isinstance(thresholds, np.ndarray) else thresholds
            
            # Generate neuron instantiation
            neuron_inst = generate_neuron_instantiation(
                layer_cfg, neuron_idx, neuron_weights, neuron_bias, neuron_threshold
            )
            
            # Handle input connections
            input_conn = ""
            if layer_cfg["input_size"] > 1:
                # For multi-input neurons, connect specific input bits
                for i in range(layer_cfg["input_size"]):
                    input_conn += f"        .sp_{i}(spikes_in[{i}]),\n"
            else:
                # For single-input neurons
                input_conn = f"        .sp_0(spikes_in),\n"
            
            # Write the complete instantiation
            f.write(neuron_inst)
            f.write(",\n")
            f.write(input_conn)
            f.write("    );\n\n")
        
        # Connect individual neuron outputs to output bus
        if layer_cfg["output_size"] > 1:
            f.write("    // Combine individual neuron outputs\n")
            f.write("    assign spikes_out = {")
            f.write(", ".join([f"spike_out_{i}" for i in range(layer_cfg["output_size"]-1, -1, -1)]))
            f.write("};\n")
        else:
            f.write("    assign spikes_out = spike_out_0;\n")
        
        f.write("\nendmodule\n")
    
    print(f"Generated {os.path.basename(filename)} for {layer_cfg['name']}")
    return filename

def main():
    print("Starting layer module generation...")
    print(f"Using {fixed_point_bits}-bit fixed-point representation (Q8.8 format)")
    
    # Create output directory for Verilog modules
    os.makedirs(verilog_output_dir, exist_ok=True)
    print(f"Verilog modules will be saved to: {verilog_output_dir}")
    
    # Generate all layer modules
    for layer in layer_config:
        try:
            generate_layer_module(layer, verilog_output_dir)
        except FileNotFoundError as e:
            print(f"Error: {e}")
            print("Skipping this layer...")
    
    print("\nLayer module generation completed!")

if __name__ == "__main__":
    main()