module Moore1100( //NON OVERLAPPING
    input clk,
    input R,
    input P1, P2, //P1 for input = 1, P2 for 0
    output reg Z
);

//State encoding (need 3 bits for 5 total states)
parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

//Present and Next State trackers
reg [2:0] PS, NS;

//Sequential Logic
always @(posedge clk or posedge R) begin
    if (R) PS <= S0;
    else PS <= NS;
end

//Combinational Next State Logic
always @(PS or P1 or P2) begin
    NS = PS; //Hold state if nothing pressed
    case (PS)
        S0: begin
            if (P1 == 1) NS = S1;
            else if (P2 == 1) NS = S0; 
        end
        S1: begin
            if (P1 == 1) NS = S2;
            else if (P2 == 1) NS = S0;
        end
        S2: begin
            if (P2 == 1) NS = S3;
            else if (P1 == 1) NS = S2;
        end
        S3: begin
            if (P2 == 1) NS = S4;
            else if (P1 == 1) NS = S1;
        end
        S4: begin
            if (P1 == 1) NS = S1;
            else if (P2 == 1) NS = S0;
        end
        default: NS = S0;
    endcase
end

//Combinational Output Logic
always @(PS) begin
    case (PS)
        S0: Z = 0;
        S1: Z = 0;
        S2: Z = 0;
        S3: Z = 0;
        S4: Z = 1;
        default: Z = 0;
    endcase
end

endmodule