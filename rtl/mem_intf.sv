/*
 * @Author: WilliamTse
 * @University: Hangzhou Dianzi University(HDU)
 * @Github: https://github.com/Tse3792
 * @Date: 2022-04-05 12:44:54
 * @LastEditors: WilliamTse
 * @LastEditTime: 2022-04-05 12:50:27
 * @Reversion: v1.0
 * @Description: 
 */

 interface mem_intf(
    input       logic       clk,
    input       logic       rstn
 );
    logic                   wr_en;
    logic       [31:0]      w_data;
    logic       [7:0]       addr;
    logic                   rd_en;
    logic       [7:0]       r_data;
     
    clocking driver_cb @ (posedge clk);
        default input #1  output  #1;

        output              wr_en;
        output              w_data;
        output              addr;
        output              rd_en;
        input               r_data;
    endclocking

    clocking monitor_cb @ (posedge clk);
        default input #1 output #1;

        input               wr_en;
        input               w_data;
        input               addr;
        input               rd_en;
        input               r_data;
    endclocking

    modport DRIVER (
        clocking            driver_cb,
        input               clk,
        input               rstn
    );

    modport MONITOR (
        clocking            monitor_cb,
        input               clk,
        input               rstn
    );

 endinterface //interfacename
