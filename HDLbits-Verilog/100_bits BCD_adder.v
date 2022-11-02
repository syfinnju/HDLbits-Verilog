//first solution
module 100_bits_BCD_adder(a,b,cin,cout,sum);
input [99:0]a;
input [99:0]b;
input cin;
output cout;
output [99:0]sum;
wire [99:0] carry;
bcd_fadd fadd1 (a[3:0],b[3:0],cin,carry[0],sum[3:0]);
 
 genvar i;
 generate
    for (i=1;i<100;i++)
    begin:bcd_fadd
    bcd_fadd fadd2 (a[4*i+3:4*i],b[4*i+3:4*i],carry[i-1],carry[i],sum[4*i+3:4*i]);
    end
    endgenerate
    assign cout = carry[99];
endmodule


//4位BCD_adder工作原理：输入的4位二进制数相加设为i，如果i<9则sum不需要修改，如果i>9则sum需要在原来的基础上再加上6，并且有进位cout产生
//循环例化使用 generate-for语句，多个子模块的连接要注意设置中间变量，连接即可，by name or by position，generate语句注意begin后需要给出名字



