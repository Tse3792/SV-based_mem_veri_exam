/*
 * @Author: WilliamTse
 * @University: Hangzhou Dianzi University(HDU)
 * @Github: https://github.com/Tse3792
 * @Date: 2022-04-05 12:28:33
 * @LastEditors: WilliamTse
 * @LastEditTime: 2022-04-05 12:30:49
 * @Reversion: v1.0
 * @Description: 
 */

 class transaction;
    rand    bit         wr_en;
    rand    bit [31:0]  w_data;
    rand    bit [7:0]   addr;
    rand    bit         rd_en;
            bit [31:0]  r_data;

    constraint wr_rd_c {
        wr_en != rd_en;
    };            
 endclass
