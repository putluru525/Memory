class mem_sbd;
	mem_tx tx;
	bit [`WIDTH-1:0]assoc_arr[int];
task run();
	//$display("mem_sbd RUN TASK called");
	forever begin
		mem_common::mon2sbd.get(tx);
			if(tx.wr_rd_en_i == 1) 
				assoc_arr[tx.addr_i] = tx.wdata_i;
			else begin
				if(assoc_arr[tx.addr_i] == tx.rdata_o) begin
					mem_common::count_matches++;
					//$display("matches=%0d",mem_common::count_matches);
					//$display("assoc_arr[%h]=%h is matching with tx.rdata_o=%h",tx.addr_i,assoc_arr[tx.addr_i],tx.rdata_o);
				end
				else begin
					mem_common::count_mismatches++;
				        //$display("assoc_arr[%h]=%h is not matching with tx.rdata_o=%h",tx.addr_i,assoc_arr[tx.addr_i],tx.rdata_o);
					//$display("mismatches=%0d",mem_common::count_mismatches);
				end
			end
			
	end
endtask
endclass
