/*
Implementiert eine FSM, die eine Binärzahl beliebiger Länge in das entsprechende Zweierkomplement übersetzt. 
Der Übersetzungsvorgang startet, wenn areset == 0 und endet, wenn areset == 1. 
*/

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter a=0, b=1;
    reg state, next_state;
    
    always @(*)
        case(state)
            a: next_state = (x)? b:a;
            b: next_state = (x)? b:b;
        endcase
	
    always @(posedge clk or posedge areset)
        if(areset)
            state <= a;
    	else
            state <= next_state;
    
    assign z = ( (state == a) & x | (state == b) & ~x);
endmodule
