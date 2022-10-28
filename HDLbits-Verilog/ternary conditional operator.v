//first solution：通过使用3个串行mux进行连续比较
module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0]e;
    wire [7:0]f;
    assign e = a<b?a:b;
    assign f = e<c?e:c;
    assign min =f<d?f:d;

endmodule


module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    assign min =(a<b)&(a<c)&(a<d)?a:(b<a)&(b<c)&(b<d)?b:(c<b)&(c<a)&(c<d)?c:d;

   
endmodule

//second solution：通过two-way的电路结构进行比较操作，主要比较上下两个way的值来确定输出min
module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    wire [7:0] intermediate_result1;
    wire [7:0] intermediate_result2;

    assign intermediate_result1 = a<b? a: b;
    assign intermediate_result2 = c<d? c: d;
    assign min = intermediate_result1<intermediate_result2? intermediate_result1: intermediate_result2;

endmodule
