interface mem_intf(input logic clk_i,rst_i);
	//all signals are logic
logic [`WIDTH-1:0]wdata_i;
logic [`ADDR_WIDTH-1:0]addr_i;
logic [`WIDTH-1:0]rdata_o;
logic ready_o;
logic wr_rd_en_i;
logic valid_i;
clocking bfm_cb@(posedge clk_i);
	default input #0 output #0;
	output wdata_i;
	output addr_i;
	output wr_rd_en_i;
	output valid_i;
	input rdata_o;
	input ready_o;
endclocking
clocking mon_cb@(posedge clk_i);
	default input #0 ;
	input wdata_i;
	input addr_i;
	input rdata_o;
	input ready_o;
	input wr_rd_en_i;
	input valid_i;
endclocking
endinterface

