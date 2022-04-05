/*
 * @Author: WilliamTse
 * @University: Hangzhou Dianzi University(HDU)
 * @Github: https://github.com/Tse3792
 * @Date: 2022-04-05 13:34:47
 * @LastEditors: WilliamTse
 * @LastEditTime: 2022-04-05 13:36:33
 * @Reversion: v1.0
 * @Description: 
 */

//`include "env.sv"

 program test(mem_intf intf);
    env env;

    initial begin
        env = new(intf);
        env.gen.repeat_cnt = 10;
        env.run();
    end
 endprogram
