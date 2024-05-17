class mem_gen;
	mem_tx tx;
	int agent_num;
	//bit [`ADDR_WIDTH-1:0]addr_Q[$];
	bit [`ADDR_WIDTH-1:0]addr[`DEPTH-1:0];
	bit [`ADDR_WIDTH-1:0]temp;
	function new(int agent_num);
		this.agent_num = agent_num;
		/*mem_common::gen2bfm = new[agent_num];
		for(int i=0;i<agent_num;i++) begin
			automatic int j;
			j=i;
			mem_common::gen2bfm[j]=new(j);
		end*/
	endfunction
	task run();
		tx=new();
		tx.randomize();
		case(mem_common::testcase)
			"test_rand_wr_rd":begin
				addr = tx.addr_arr;
				for(int i=0;i<mem_common::count;i++) begin
					tx=new();
					temp = addr[i];
					assert(tx.randomize() with {tx.wr_rd_en_i==1;
					                            tx.addr_i == temp;});
					addr[i] = tx.addr_i; 
					//addr_Q.push_back(tx.addr_i);
					mem_common::gen2bfm[agent_num].put(tx);
					//tx.print("mem_write_gen");
				end
				for(int i=0;i<mem_common::count;i++) begin
					tx=new();
					tx.wdata_i.rand_mode(0);
					temp = addr[i];
				//	temp = addr_Q.pop_front();
					assert(tx.randomize() with {tx.wr_rd_en_i==0;
								    tx.addr_i==temp;});
					mem_common::gen2bfm[agent_num].put(tx);
					//tx.print("mem_read_gen");
				end

			end
		endcase
	endtask
endclass
