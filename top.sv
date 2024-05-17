typedef class mem_common;
typedef class mem_tx;
typedef class mem_env;
typedef class mem_agent;
typedef class mem_mon;
typedef class mem_sbd;
typedef class mem_gen;
typedef class mem_bfm;
typedef class mem_cov;
`include "mem_tx.sv";
`include "mem_intf.sv";
`include "mem_common.sv";
`include "mem_gen.sv";
`include "mem_bfm.sv";
`include "mem_mon.sv";
`include "mem_cov.sv";
`include "mem_sbd.sv";
`include "mem_agent.sv";
`include "mem_env.sv";
`include "memory.v";
`include "mem_prgm_blk.sv";
module top;
bit clk,rst;
//event e;
always #5 clk=~clk;
initial begin
	rst=1;
	repeat(2) @(posedge clk);
	rst=0;
	//->e;
end
mem_intf pif(clk,rst);
memory dut(.clk_i(pif.clk_i),
	   .rst_i(pif.rst_i),
	   .wdata_i(pif.wdata_i),
	   .addr_i(pif.addr_i),
	   .wr_rd_en_i(pif.wr_rd_en_i),
	   .valid_i(pif.valid_i),
	   .rdata_o(pif.rdata_o),
	   .ready_o(pif.ready_o));
mem_prog mem_prog_h();
//mem_env env;
initial begin
	mem_common common = new();
	/*env=new();
	wait(e.triggered);*/
	$value$plusargs("testcase=%s",mem_common::testcase);
	//env.run();
end
initial begin
	//#995;
	fork
		wait((mem_common::count*2*mem_common::agent_num) == (mem_common::total_driven_tx));
		#10000;
	join_any
	#50;
	/*if(mem_common::count_mismatches!=0 || mem_common::count_matches!=(mem_common::count*mem_common::agent_num)) begin
		$display("###### TEST FAILED ######");
		$display("## count of mismatches = %0d ##",mem_common::count_mismatches);
		$display("## count of matches = %0d ##",mem_common::count_matches);
	end
	else begin
		$display("###### TEST PASSED ######");
		$display("## count of mismatches = %0d ##",mem_common::count_mismatches);
		$display("## count of matches = %0d ##",mem_common::count_matches);
	end*/
	$finish();
end
endmodule
