/*Problem:
Create a 4-bit wide, 256-to-1 multiplexer. The 256 4-bit inputs are all packed into a single 1024-bit input vector. 
sel=0 should select bits in[3:0], sel=1 selects bits in[7:4], sel=2 selects bits in[11:8], etc.*/


//first solution
module 4bits_256mux (sel,in,out);
input [255:0] in;
input [7:0] sel;
output [4:0] out;

assign out = in[4*sel+3 -:4];//这种写法表示in从4*sel+3 位开始，低位是4*sel+3再减去4位
                             //注意这里的片选信号写法不可以写成assign out = in[4*sel+3:4*sel],原因在于语法Verilog不支持
                             //正确的写法有两种，另一种是 out = in[4*sel+:4],这种写法表示in从4*sel位开始，一直取到4*sel+4比特位



//second solution
module 4bits_256mux (sel,in,out);
input [255:0] in;
input [7:0] sel;
output [4:0] out;
 

 assign out ={in[4*sel+3],in[4*sel+2],in[4*sel+1],in[4*sel]};