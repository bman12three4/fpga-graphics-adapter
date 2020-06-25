module commands (
		input clock,
		input [7:0] command,
		input request,
		
		input [15:0] user_addr,
		output reg [15:0] cmd_mem_addr,
		output reg [7:0] cmd_mem_data,
		output reg cmd_mem_wren,
		output reg active
	);
	
	reg started = 0;
	reg [15:0] tmp_addr = 0;
	
	always @(posedge clock) begin
		case (command)
			8'h00 :;
			8'h01 : begin
					if (request) begin
						if (!started) begin
							cmd_mem_wren = 1;				// write enable
							cmd_mem_addr = 0;						// start at $0000
							cmd_mem_data = 0;				// write zeros
							started = 1;
							active = 1;
						end
					end
					if (started) begin
						cmd_mem_addr = cmd_mem_addr + 1;
							
						if (cmd_mem_addr == 0) begin
							cmd_mem_data = 0;
							cmd_mem_wren = 0;
							started = 0;
							active = 0;
						end
					end
				end
			8'h02 : begin
					if (request) begin
						if (!started) begin
							cmd_mem_wren = 1;				// write enable
							cmd_mem_addr = 0;						// start at $0000
							cmd_mem_data = 0;				// write zeros
							tmp_addr = user_addr;
							started = 1;
							active = 1;
						end
					end
					if (started) begin
						cmd_mem_addr = cmd_mem_addr + 1;
							
						if (cmd_mem_addr >= tmp_addr) begin
							cmd_mem_data = 0;
							cmd_mem_wren = 0;
							started = 0;
							active = 0;
						end
					end
				end
			default :;
		endcase
	end

endmodule
