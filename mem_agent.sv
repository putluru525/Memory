class mem_agent;
	mem_bfm bfm;
	mem_gen gen;
	function new(int agent_num);
		bfm=new(agent_num);
		gen=new(agent_num);
	endfunction
	task run();
		fork
			bfm.run();
			gen.run();
		join
	endtask
endclass
