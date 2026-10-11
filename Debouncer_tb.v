`timescale 1ns/1ps

module Debouncer_tb;
//Declare I/O
reg raw, clk;
wire clean;

Debouncer uut(.raw(raw), .clk(clk), .clean(clean));

//Generate Clock
always #5 clk = ~clk;

//Test Cases
initial begin
    //Initial values
    clk = 0; raw = 0;

    #12 raw = 1;
    #10; //Cycle 1
    #10; //2
    #10; //3
    #10; //4
    #10; //5
    #10; //6
    #10; //7
    #10; //8, expect clean high in this cycle
    #10; //9, expect clean to remain high until raw is lowered
    #10; //10

    #10 raw = 0;
    #40 $finish; //expect clean to drop to low

end

endmodule