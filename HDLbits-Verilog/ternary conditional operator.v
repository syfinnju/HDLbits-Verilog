module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0]e;
    wire [7:0]f;
    assign e = a<b?a:b;
    assign f = e<c?e:c;
    assign min =f<d?f:d;

    // assign intermediate_result1 = compare? true: false;

endmodule