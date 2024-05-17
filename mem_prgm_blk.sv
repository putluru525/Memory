program mem_prog();
mem_env env;
initial begin
env=new();
env.run();
end
final begin
	if(mem_common::count_mismatches!=0 || mem_common::count_matches!=(mem_common::count*mem_common::agent_num)) begin
		$display("###### TEST FAILED ######");
		$display("## count of mismatches = %0d ##",mem_common::count_mismatches);
		$display("## count of matches = %0d ##",mem_common::count_matches);
	end
	else begin
		$display("###### TEST PASSED ######");
		$display("## count of mismatches = %0d ##",mem_common::count_mismatches);
		$display("## count of matches = %0d ##",mem_common::count_matches);
	end
end
endprogram
