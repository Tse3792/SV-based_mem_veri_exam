/*
 * @Author: WilliamTse
 * @University: Hangzhou Dianzi University(HDU)
 * @Github: https://github.com/Tse3792
 * @Date: 2022-04-05 12:33:01
 * @LastEditors: WilliamTse
 * @LastEditTime: 2022-04-05 13:26:51
 * @Reversion: v1.0
 * @Description: 
 */
//`include "transaction.sv"

 class generator;
    rand    transaction     trans;
    mailbox                 gen2driv;
    int                     repeat_cnt;
    event                   ended;

    function new(mailbox gen2driv , event ended);
        this.gen2driv = gen2driv;
        this.ended    = ended;
    endfunction

    task main();
        repeat(repeat_cnt) begin
            trans = new();
            if(!trans.randomize()) begin
                $fatal("GEN::trans randomization failed");
            end
            gen2driv.put(trans);
        end 
        -> ended;
    endtask

 endclass
