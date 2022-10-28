//目标是实现对255bits的输入进行统计其中bit位是“1”的数量

module population count( 
    input [254:0] in,
    output [7:0] out );
        integer i;
    
    always@(*)
        begin
            out =8'b00000000;
            for( i=0;i<255;i++)
                begin
                    if (in[i]==1'b1)  out=out+1'b1;//这里的==不可以改成=，=代表赋值而不是逻辑判断，===可以理解为弱化判断，可以识别z和x
            else out=out;
                end
        end

endmodule