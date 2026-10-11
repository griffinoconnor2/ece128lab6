`timescale 1ns/1ps

module Moore1100_tb;
//Declare I/O
reg clk;
reg R;
reg P1, P2;
wire Z;

//Instantaite Sequence Detector
Moore1100 uut(.clk(clk), .R(R), .P1(P1), .P2(P2), .Z(Z));

//Generate Clock
always #5 clk = ~clk;

//Test Cases
initial begin
    //Initial Values
    clk = 0; R = 1; P1 = 0; P2 = 0;
    #12 R = 1'b0; //release reset

    //Test 1: Full Sequence Correct (1100)
    #10 P1 = 1; P2 = 0; //(S1)
    #10; //hold inputs (S2)
    #10 P1 = 0; P2 = 1; //Input '0' (S3)
    #10; //hold inputs, Z should evalutate to 1 (S4)

    #10 P1 = 0; P2 = 0; //release, default to S0

    //Test 2: Failed Sequence
    #10 P1 = 1; P2 = 0; //(S1)
    #10; //Hold inputs (S2)
    #10; //Hold inputs again to break sequence (S0)

    //Test 3: Full Sequence Correct w/ Hold Test (1100)
    #10 P1 = 1; P2 = 0; //(S1)
    #10 P1 = 0; P2 = 0; //Test state hold (S1)
    #10 P1 = 1; P2 = 0; //(S2)
    #10 P1 = 0; P2 = 0; //Test state hold (S2)
    #10 P1 = 0; P2 = 1; //(S3)
    #10 P1 = 0; P2 = 0; //Test state hold (S3)
    #10 P1 = 0; P2 = 1; //Z should evaluate to 1 (S4)
    #10 P1 = 0; P2 = 0; // Test state hold (S4, Z remains 1 until next button press)

    //End
    #10 R = 1;
    #10 $finish;
end

endmodule