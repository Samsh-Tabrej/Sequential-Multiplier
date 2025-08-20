module tb_Seq_Bin_Mult;

    parameter dp_width = 5;//Set to width of datapath
    wire [2*dp_width -1 : 0] product; //Output from multiplier
    reg  [dp_width -1 : 0] Multiplicand, Multiplier; //Inputs
    reg  Start, clock, reset_b;
    wire Ready;
    
    // Instantiate multiplier
    Seq_Bin_Mult M0 (product, Ready, Multiplicand, Multiplier, Start, clock,reset_b);
    
    // Generate stimulus waveforms
    initial #200 $finish;
    
    initial begin
        Start = 0;
        reset_b = 0; 
        #2 Start = 1; 
        reset_b = 1;
        Multiplicand= 5'b10111; 
        Multiplier =5'b10011; //23*19=437
        #10 Start = 0;
    end
    
    initial begin 
        clock = 0; 
        repeat (26) #5 clock = ~clock;
    end
    
    always @ (posedge clock) // Display results
        $strobe ("C=%b A=%b Q=%b P=%b time=%0d", M0.C, M0.A, M0.Q, M0.P, $time);
        
endmodule
