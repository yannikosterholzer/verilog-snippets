/*
Extrahiert 3-Byte-Pakete aus einem kontinuierlichen PS/2-Datenstrom und gibt das 24-Bit-Paket aus, sobald es vollständig empfangen wurde
*/

module top_module(
    input clk,
    input [7:0] in,
    input reset,    
    output [23:0] out_bytes,
    output done); 
	
    reg [23:0] out_data;
    reg [1:0] state, next_state;

  
    always @(*)
        case(state)
            2'b00: next_state = (in[3])? 2'b01 : 2'b00;
            2'b01: next_state = 2'b10;
            2'b10: next_state = 2'b11;
            2'b11: next_state = (in[3])? 2'b01 : 2'b00;
        endcase
    
    always @(posedge clk)
        if(reset)
            state <= 2'b00;
        else
            state <= next_state;
  
    always @(posedge clk)
        out_data <= {out_data[15:0], in};
  
    assign done = (state == 2'b11);
    assign out_bytes = (done)? out_data: 'bz;

endmodule
