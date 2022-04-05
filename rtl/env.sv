/*
 * @Author: WilliamTse
 * @University: Hangzhou Dianzi University(HDU)
 * @Github: https://github.com/Tse3792
 * @Date: 2022-04-05 13:27:04
 * @LastEditors: WilliamTse
 * @LastEditTime: 2022-04-05 13:33:25
 * @Reversion: v1.0
 * @Description: 
 */

//`include "../transaction.sv"
//`include "../generator.sv"
//`include "driver.sv"

 class env;
    generator           gen;
    driver              driv;
    
    mailbox             gen2driv;
    event               gen_ended;

    virtual mem_intf    mem_vif;

    function new(virtual mem_intf mem_vif);
        this.mem_vif    = mem_vif;
        gen2driv        = new();
        gen             = new(gen2driv , gen_ended);
        driv            = new(mem_vif , gen2driv);
    endfunction

    task pre_test();
        driv.reset();
    endtask

    task test();
        fork
            gen.main();
            driv.drive();
        join
    endtask

    task post_test();
        wait(gen_ended.triggered);
        wait(gen.repeat_cnt == driv.no_transaction);
    endtask

    task run();
        pre_test();
        test();
        post_test();
        $finish;
    endtask

 endclass
