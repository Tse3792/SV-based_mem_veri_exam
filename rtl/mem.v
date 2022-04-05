/*
 * @Author: WilliamTse
 * @University: Hangzhou Dianzi University(HDU)
 * @Github: https://github.com/Tse3792
 * @Date: 2022-04-05 12:19:16
 * @LastEditors: WilliamTse
 * @LastEditTime: 2022-04-05 12:26:55
 * @Reversion: v1.0
 * @Description: 
 */

 module mem#(
    parameter                       WIDTH = 32,
    parameter                       DEPTH = 256
 )(
    input                           clk,
    input                           rstn,

    input                           wr_en,
    input       [WIDTH-1:0]         w_data,
    input       [$clog2(DEPTH)-1:0] addr,
    input                           rd_en,
    output  reg [$clog2(DEPTH)-1:0] r_data
 );
    reg         [WIDTH-1:0]         mem_cache [0:DEPTH-1];

    integer i;
    always@(posedge clk or negedge rstn) begin
        if(!rstn) begin
            for(i=0;i<DEPTH;i=i+1) begin : reset_mem
                mem_cache[i] = 'd0;
            end
        end
        else if(wr_en) begin
            mem_cache[addr] <= w_data;
        end
    end

    always@(posedge clk) begin
        if(rd_en) begin
            r_data <= mem_cache[addr];
        end
    end

 endmodule
