//first solution   (rapple carry adder)
module 100bits-adder( 
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
module 100bits-adder( 
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


module fulladder (a,b,cin,sum,cout);    //module最后需要加;
   input a,b,cin;
   output sum,cout;
    assign sum=a^b^cin;
    assign cout=(a&b)|(a&cin)|(b&cin);
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
