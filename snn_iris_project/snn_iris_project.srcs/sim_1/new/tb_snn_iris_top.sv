`timescale 1ns / 1ps

module tb_snn_iris_top;

    // Parameters
    parameter CLK_PERIOD      = 10;       // 100 MHz clock
    parameter NUM_TEST_SAMPLES = 15;      // Iris test samples
    parameter SAMPLE_FILE     = "/media/nisitha/My_Passport/MOODLE/Vivado_projects/SNN_project/snn_iris_project/snn_iris_project/python_src/iris_test_vectors.txt";
    
    // System Signals
    reg         clk;
    reg         reset_n;
    
    // Input Features
    reg  [7:0]  f0;
    reg  [7:0]  f1;
    reg  [7:0]  f2;
    reg  [7:0]  f3;
    
    // Outputs
    wire [2:0]  class_out;
    wire        result_valid;
    
    // Testbench Variables
    reg  [7:0]  test_data [0:3];  // Feature storage
    reg  [1:0]  expected_class;   // Expected class
    integer     file_handle;
    integer     sample_count = 0;
    integer     correct = 0;
    integer     total = 0;
    integer     scan_result;
    
    // DUT Instantiation
    snn_iris_top dut (
        .clk         (clk),
        .reset_n     (reset_n),
        .f0          (f0),
        .f1          (f1),
        .f2          (f2),
        .f3          (f3),
        .class_out   (class_out),
        .result_valid(result_valid)
    );

    // Clock Generation
    initial clk = 1'b0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Main Test Sequence
    initial begin
        initialize();
        load_and_process_samples();
        report_results();
        $finish;
    end

    // Initialize system
    task initialize();
        begin
            reset_n = 1'b0;
            f0 = 0;
            f1 = 0;
            f2 = 0;
            f3 = 0;
            #100 reset_n = 1'b1;
            #100;
        end
    endtask

    // Load and process samples
    task load_and_process_samples();
        begin
            file_handle = $fopen(SAMPLE_FILE, "r");
            if (file_handle == 0) begin
                $display("Error opening %s", SAMPLE_FILE);
                $finish;
            end
            
            while (sample_count < NUM_TEST_SAMPLES) begin
                // Read features as binary strings
                scan_result = $fscanf(file_handle, "%b", test_data[0]);
                scan_result = $fscanf(file_handle, "%b", test_data[1]);
                scan_result = $fscanf(file_handle, "%b", test_data[2]);
                scan_result = $fscanf(file_handle, "%b", test_data[3]);
                scan_result = $fscanf(file_handle, "%b", expected_class);
                
                // Apply features to DUT
                f0 = test_data[0];
                f1 = test_data[1];
                f2 = test_data[2];
                f3 = test_data[3];
                
                // Wait for classification result
                @(posedge result_valid);
                
                // Check accuracy
                total++;
                if (class_out == (1 << expected_class)) 
                    correct++;
                
                $display("Sample %0d: Output %d | Expected %d | %s", sample_count, class_out, (1 << expected_class), (class_out == (3'b1 << expected_class)) ? "PASS" : "FAIL");
                
                sample_count++;
                #100;  
            end
        end
    endtask

    task report_results();
        begin
            $display("\nClassification Complete");
            $display("Accuracy: %.2f%% (%0d/%0d)", 
                     (correct * 100.0) / total, 
                     correct, total);
            $fclose(file_handle);
        end
    endtask

endmodule