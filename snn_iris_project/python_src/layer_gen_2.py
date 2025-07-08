import os
import numpy as np
import glob

# Configuration
fixed_point_bits = 16  # 16-bit fixed-point representation
fixed_point_scale = 2**8  # Scale factor for Q8.8 fixed-point
layer_config = [
    {"name": "layer1", "input_size": 4, "output_size": 8},
    {"name": "layer2", "input_size": 8, "output_size": 6},
    {"name": "layer3", "input_size": 6, "output_size": 4},
    {"name": "layer4", "input_size": 4, "output_size": 3}
]

# Get the script's directory
script_dir = os.path.dirname(os.path.abspath(__file__))

# Directory configuration
weights_dir = os.path.join(script_dir, "weights")
biases_dir = os.path.join(script_dir, "bias")
thresholds_dir = os.path.join(script_dir, "thresholds")
verilog_output_dir = os.path.join(script_dir, "verilog_layers_1")

def float_to_fixed_int32(value, fractional_bits=8):
    """Convert float to 32-bit fixed-point integer representation"""
    # Scale value and convert to integer
    scaled = round(value * (2 ** fractional_bits))
    # Ensure it fits in 32 bits
    if scaled < -2**31 or scaled >= 2**31:
        raise ValueError(f"Value {value} out of 32-bit range after scaling")
    return int(scaled)

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
    """Generate Verilog instantiation for a single neuron using the generic neuron_1 module"""
    input_size = layer_cfg["input_size"]
    
    # Convert parameters to fixed-point integers
    weight_ints = [float_to_fixed_int32(w) for w in weights]
    bias_int = float_to_fixed_int32(bias)
    threshold_int = float_to_fixed_int32(threshold)
    
    # Pad weights to 8 values (with zeros for unused inputs)
    padded_weights = weight_ints + [0] * (8 - len(weight_ints))
    
    # Format weights array for Verilog
    weights_str = ", ".join([str(w) for w in padded_weights])
    
    # Generate instantiation
    inst = f"    neuron_1 #(\n"
    inst += f"        .NUM_INPUTS   ({input_size}),\n"
    inst += f"        .WEIGHTS      ({{ {weights_str} }}),\n"
    inst += f"        .BIAS         ({bias_int}),\n"
    inst += f"        .V_TH         ({threshold_int})\n"
    inst += f"    ) neuron_{neuron_idx} (\n"
    inst += f"        .clk          (clk),\n"
    inst += f"        .reset        (reset),\n"
    inst += f"        .spikes_i     (spikes_in),\n"
    inst += f"        .neuron_reset (neuron_reset),\n"
    inst += f"        .spike_out    (spike_out_{neuron_idx})\n"
    inst += f"    );\n"
    
    return inst

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
            
            f.write(neuron_inst)
            f.write("\n")
        
        # Connect individual neuron outputs to output bus
        if layer_cfg["output_size"] > 1:
            f.write("\n    // Combine individual neuron outputs\n")
            f.write("    assign spikes_out = {")
            # Connect in reverse order for correct bit alignment
            f.write(", ".join([f"spike_out_{i}" for i in range(layer_cfg["output_size"]-1, -1, -1)]))
            f.write("};\n")
        else:
            f.write("\n    assign spikes_out = spike_out_0;\n")
        
        f.write("\nendmodule\n")
    
    print(f"Generated {os.path.basename(filename)} for {layer_cfg['name']}")
    return filename

def main():
    print("Starting layer module generation with generic neuron_1 module...")
    print(f"Using 32-bit fixed-point integer representation (Q8.24 format)")
    
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