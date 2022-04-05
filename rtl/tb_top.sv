/*
 * @Author: WilliamTse
 * @University: Hangzhou Dianzi University(HDU)
 * @Github: https://github.com/Tse3792
 * @Date: 2022-04-05 13:37:05
 * @LastEditors: WilliamTse
 * @LastEditTime: 2022-04-05 13:42:09
 * @Reversion: v1.0
 * @Description: 
 */

 //`include "mem_intf.sv"
 //`include "test.sv"

 module tb_top();
    bit                 clk;
    bit                 rstn;

    initial begin
        clk = 0;
        rstn = 1;
        #1
            rstn = 0;
        #1
            rstn = 1;
    end

    always #10
        clk = !clk;

    mem_intf intf(
        .clk            (clk),
        .rstn           (rstn)
    );

    test test_inst0(
        .intf           (intf)
    );

    mem DUT(
        .clk            (intf.clk),
        .rstn           (intf.rstn),

        .wr_en          (intf.wr_en),
        .w_data         (intf.w_data),
        .addr           (intf.addr),
        .rd_en          (intf.rd_en),
        .r_data         (intf.r_data)
    );

    initial begin
        $fsdbDumpfile("tb.fsdb"); 
        $fsdbDumpvars;
    end

 endmodule
