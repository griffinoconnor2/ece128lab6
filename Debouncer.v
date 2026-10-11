module Debouncer( //assuming 8 cycles is enough 
    input raw, clk,
    output reg clean
);

//Internal Counter and TC Signal Declaration
reg [2:0] counter;
wire TC;

//Counter logic
always @(posedge clk) begin
    if (~raw)
        counter <= 3'b000;
    else
        counter <= counter + 3'b001; //increment when raw high
end

assign TC = (counter == 3'b111); // TC = 1 when counter = b111

//Output logic
//Note: the lack of an else statement implies clean will output high even when counter rolls over
//(resetting TC to 0), so long as raw remains high. This allows the desired debouncing behavior.
always @(posedge clk) begin
    if (~raw)
        clean <= 1'b0;
    else if (TC) 
        clean <= 1'b1; //Output = 1 when TC = 1 (counter = b111)
end

endmodule