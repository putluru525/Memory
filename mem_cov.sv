class mem_cov;
//steps to implement coverage class for memory
//1.instantiate the memory tx
//2.implementation of cover group
//3.allocate the memory for cover group
//4.create run task
//5.in run task:get the tx from mailbox
//6.in run task:trigger the covergroup sampling
mem_tx tx;
covergroup mem_cg;
	WR_RD_CP:coverpoint tx.wr_rd_en_i{
		bins WR_BIN={1};
		bins RD_BIN={0};
		}
	ADDR_CP:coverpoint tx.addr_i{
		option.auto_bin_max=16;
		}
	WR_RD_CP_X_ADDR_CP:cross WR_RD_CP,ADDR_CP;
endgroup
function new();
	mem_cg=new();
endfunction
	task run();
		//$display("mem_cov RUN TASK called");
		forever begin
			mem_common::mon2cov.get(tx);
			mem_cg.sample();
		end
	endtask
endclass

