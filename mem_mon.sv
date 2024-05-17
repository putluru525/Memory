class mem_mon;
	mem_tx tx;
	virtual mem_intf vif;
	function new();
		vif = top.pif;

	endfunction
task run();
	$display("mem_mon RUN TASK called");
        forever begin
				tx=new();
		//convert interface level to tx level
		//@(posedge vif.clk_i);
		@(vif.mon_cb);
		if(vif.mon_cb.valid_i==1 && vif.mon_cb.ready_o==1) begin
			tx.addr_i = vif.mon_cb.addr_i;
			tx.wr_rd_en_i = vif.mon_cb.wr_rd_en_i;
			if(tx.wr_rd_en_i==1)
				tx.wdata_i = vif.mon_cb.wdata_i;
			else
				tx.rdata_o = vif.mon_cb.rdata_o;

			mem_common::mon2cov.put(tx);
			mem_common::mon2sbd.put(tx);
			tx.print("mem_mon");
		end
	end
endtask
endclass
