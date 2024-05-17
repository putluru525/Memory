class mem_bfm;
	int agent_num;
	mem_tx tx;
	virtual mem_intf vif;
	function new(int agent_num);
		vif=top.pif;
		this.agent_num = agent_num;
		//this.agent_num = agent_num;
		/*mem_common::gen2bfm = new[agent_num];
		for(int i=0;i<agent_num;i++) begin
			automatic int j;
			j=i;
			mem_common::gen2bfm[j]=new(j);
		end*/

	endfunction
task run();
	forever begin
		mem_common::gen2bfm[agent_num].get(tx);
		mem_common::smp.get(1);
		drive_tx(tx);
		mem_common::total_driven_tx++;
		mem_common::smp.put(1);
	end
endtask
task drive_tx(mem_tx tx);
	//convert tx level to interface level
	//@(posedge vif.clk_i);
	@(vif.bfm_cb)
	vif.bfm_cb.valid_i <= 1;
	vif.bfm_cb.addr_i<=tx.addr_i;
	vif.bfm_cb.wr_rd_en_i <= tx.wr_rd_en_i;
	if(tx.wr_rd_en_i==1)
		vif.bfm_cb.wdata_i <= tx.wdata_i;
	wait(vif.bfm_cb.ready_o==1);
	if(tx.wr_rd_en_i==0)
		tx.rdata_o = vif.bfm_cb.rdata_o;
	$display("BFM Number %0d is running with tx.addr_i=%h,tx.data=%h,tx.wr_rd_en_i=%0d",agent_num,tx.addr_i,tx.wr_rd_en_i?tx.wdata_i:tx.rdata_o,tx.wr_rd_en_i);
		//tx.print("mem_bfm");
	vif.bfm_cb.valid_i <= 0;

endtask
endclass
