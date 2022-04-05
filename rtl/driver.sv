/*
 * @Author: WilliamTse
 * @University: Hangzhou Dianzi University(HDU)
 * @Github: https://github.com/Tse3792
 * @Date: 2022-04-05 12:52:30
 * @LastEditors: WilliamTse
 * @LastEditTime: 2022-04-05 13:26:45
 * @Reversion: v1.0
 * @Description: 
 */
 //`include "generator.sv"
 class driver;
    int                 no_transaction;
    virtual mem_intf    mem_vif;
    mailbox             gen2driv;

    function new(virtual mem_intf mem_vif , mailbox gen2driv);
        this.mem_vif  = mem_vif;
        this.gen2driv = gen2driv;
    endfunction

    task reset();
        wait(!mem_vif.rstn);
        $display("---------[DRIVER] reset start! -----------");
        mem_vif.DRIVER.driver_cb.wr_en  <= 1'b0;
        mem_vif.DRIVER.driver_cb.w_data <= 'd0;
        mem_vif.DRIVER.driver_cb.addr   <= 'd0;
        mem_vif.DRIVER.driver_cb.rd_en  <= 1'b0;
        wait(mem_vif.rstn);
        $display("---------[DRIVER] reset complete! --------");
    endtask

    task drive();
        forever begin
            transaction trans;
            mem_vif.DRIVER.driver_cb.wr_en  <= 1'b0;
            mem_vif.DRIVER.driver_cb.rd_en  <= 1'b0;
            gen2driv.get(trans);
            $display("--------- [DRIVER-TRANSFER: %0d] ---------",no_transaction);
            @(posedge mem_vif.DRIVER.clk);
            mem_vif.DRIVER.driver_cb.addr   <= trans.addr;

            if(trans.wr_en) begin
                mem_vif.DRIVER.driver_cb.wr_en  <= trans.wr_en;
                mem_vif.DRIVER.driver_cb.w_data <= trans.w_data;
                $display("\tADDR = %0h \tWDATA = %0h",trans.addr,trans.w_data);
                @(posedge mem_vif.DRIVER.clk);
            end

            if(trans.rd_en) begin
                mem_vif.DRIVER.driver_cb.rd_en  <= trans.rd_en;
                @(posedge mem_vif.DRIVER.clk)
                mem_vif.DRIVER.driver_cb.rd_en  <= 1'b0;
                @(posedge mem_vif.DRIVER.clk)
                trans.r_data = mem_vif.DRIVER.driver_cb.r_data;
                $display("\tADDR = %0h \tRDATA = %0h",trans.addr,mem_vif.DRIVER.driver_cb.r_data);
            end

            $display("--------------- one trans end -----------------");
            no_transaction++;
        end
    endtask

 endclass
