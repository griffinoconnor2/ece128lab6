module Mealy1101(
    input P1, P2, clk, R, //P1 is 1 and P2 is 0
    output reg Z
);

//State Encoding (S0 is reset, S1 is 1, S2 is 11, and S3 is 110)
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

//State Tracking 
reg [1:0] PS, NS;

//Always block for updating PS
always @(posedge clk or posedge R)
begin 
    if (R)
        PS <= S0;
    else 
        PS <= NS;
end

always @(*)
begin 
//Hold State if neither button is pressed
Z = 0;
NS = PS;

 case(PS)
    S0: begin 
        if (P1)
            NS = S1;
        else if (P2) //Only if P2 is explicitly pressed
            NS = S0;
    end

    S1: begin 
        if (P1) 
            NS = S2;
        else if (P2)
            NS = S0;
    end

    S2: begin 
        if (P2)
            NS = S3;
        else if (P1)
            NS = S2;
    end 

    S3: begin
        if (P1) begin
            Z = 1;
            NS = S1;
        end
        else if (P2) begin
            NS = S0;
        end
    end
    default: begin
        Z = 1'bx;
        NS = 2'bxx;
    end

 endcase
end
endmodule 
