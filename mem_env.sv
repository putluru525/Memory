class mem_env;
	mem_agent agent[];
	mem_mon mon;
	mem_cov cov;
	mem_sbd sbd;
	function new();
		agent  = new[mem_common::agent_num];
		for(int i=0;i<mem_common::agent_num;i++) begin
			agent[i]=new(i);
		end
		mon=new();
		cov=new();
		sbd=new();
	endfunction
	task run();
		for(int i=0;i<mem_common::agent_num;i++) begin
			automatic int j;
			j=i;
			fork
				agent[j].run();
			join_none
		end
		fork
			mon.run();
			cov.run();
			sbd.run();
		join
	endtask
endclass
