class mem_common;
	static string testcase;
	static int agent_num=3;
	static mailbox gen2bfm[];
	static mailbox#(mem_tx) mon2cov=new();
	static mailbox#(mem_tx) mon2sbd=new();
	static int count_matches;
	static int count_mismatches;
	static int total_driven_tx;
	static int count = `DEPTH;
	//static int count = 1;
	static semaphore smp = new(1);
	function new();
		gen2bfm = new[agent_num];
		foreach(gen2bfm[i]) begin
			gen2bfm[i]=new();
		end
	endfunction
endclass
