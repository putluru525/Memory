`define DEPTH 16
`define ADDR_WIDTH $clog2(`DEPTH)
`define WIDTH 32
class mem_tx;
rand bit wr_rd_en_i;
//handshaking signals cannot be declared in mem_tx
rand bit [`WIDTH-1:0]wdata_i;
rand bit [`ADDR_WIDTH-1:0]addr_i;
bit [`WIDTH-1:0]rdata_o;
rand bit [`ADDR_WIDTH-1:0]addr_arr[`DEPTH-1:0];
constraint addr_c { unique {addr_arr };}
function void print(string name="mem_tx");
	$display("printing %s",name);
	$display("%t wr_rd_en_i=%b",$time,wr_rd_en_i);
	$display("%t wdata_i=%h",$time,wdata_i);
	$display("%t addr_i=%h",$time,addr_i);
	$display("%t rdata_o=%h",$time,rdata_o);
endfunction
endclass

