//fulladder子模块
module fulladder (a,b,cin,sum,cout);    //module最后需要加; 
   input a,b,cin;
   output sum,cout;
    assign sum=a^b^cin;
    assign cout=(a&b)|(a&cin)|(b&cin);
endmodule


//first solution   (rapple carry adder)
module 100bits_adder( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    integer i;
    assign cout[0]=(a[0]&b[0])|(a[0]&cin)|(b[0]&cin);
    assign sum[0] =a[0]^b[0]^cin;
    always @(*)
        begin
            for(i=1;i<100;i++)
                begin
                cout[i] = (a[i]&b[i])|(a[i]&cout[i-1])|(b[i]&cout[i-1]);
                sum[i]=a[i]^b[i]^cout[i-1];
                end
        end

endmodule



//second solution
module 100bits_adder( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    fulladder adder0 (a[0],b[0],cin,sum[0],cout[0]);
    genvar i;
    generate
        for(i=1;i<100;i++)
            begin: adder  //for begin之后需要写名字
                fulladder adder1(a[i],b[i],cout[i-1],sum[i],cout[i]);
            end
    endgenerate    //利用generate-for语句来循环例化子模块，compile的时候会把所有例化的子模块展开。
                   //gengrate使用时需要先定义genvar，使用for循环时需要为for循环取名，写在begin后面！！！
 
endmodule




//third solution
module 100bits-adder (a,b,cin,sum,cout);
    input [99:0] a, b;
    input cin;
    output [99:0] cout;
    output [99:0] sum;
    integer i;
always @(*)
begin
    for (i=0;i<100;i++)
    {cout[i],sum[i]} = i==0?a[i]+b[i]+cin:a[i]+b[i]+cout[i-1] ;
end
endmodule



//这是cout没有多位输出的例子，也是真实的adder的表示，之前的cout有100位输入是题目希望我们熟悉例化模块的手法
module 100_bits_binary_adder (a,b,cin,cout,sum);
    input [99:0] a;
    input [99:0] b;
    input cin;
    output [99:0]sum;
    output cout;
    assign {cout,sum} = a+b+cin;//这里一共有101位，Verilog会自动产生进位，故而我只需要写出最后进位拼接上100位的sum
endmodule
//个人认为Verilog的计算方式是：a[0]+b[0]+cin会产生cout[0]和sum[0],cout[0]被计算出来后直接作为carry_in与后面的a[1]+b[1]相加
//也就是变成了a[1]+b[1]+cout[0],产生cout[1]以及sum[1],这些cout都不会被输出，而是直接与后面的a，b相加，所以{cout,sum}的低位全表示的是sum
//直到100位最后的cout[99]，它没有办法再作为carry_in再相加了，故而最后将其输出，最后展现的形式就是aasign= {cout,sum} = a+b+cin;
// 2022.11.2
