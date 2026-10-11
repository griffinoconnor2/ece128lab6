module Mealy1101_tb;
    reg P1, P2, R, clk;
    wire Z;

Mealy1101 uut(P1, P2, clk, R, Z);

always #5 clk = ~clk;

initial begin
    clk = 0; R = 1; P1 = 0; P2 = 0;

    #12 R = 0; //Reset off

    #10 P1 = 1; P2 = 0; //Test correct sequence
    #10 P1 = 1; P2 = 0;
    #10 P1 = 0; P2 = 1;
    #10 P1 = 1; P2 = 0;

    #10 P1 = 1; P2 = 0; //Test overlapped sequence
    #10 P1 = 0; P2 = 1;
    #10 P1 = 1; P2 = 0;

    #10 P1 = 1; P2 = 0; //Test broken sequence 
    #10 P1 = 1; P2 = 0;
    #10 P1 = 1; P2 = 0;
    #10 P1 = 0; P2 = 1;
    #10 P1 = 0; P2 = 1;
    #10 P1 = 1; P2 = 0;

    #10 $finish;
end

endmodule