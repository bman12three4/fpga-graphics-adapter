module fpga_graphics_adapter (
		input clk,
		input clk_ext1,	// External 1 MHz clock

		input cs,			// Chip Select (Active Low)
		input [3:0] rs,	// Register select
		input wren,			// Write enable (Active low)
		inout [7:0] data_bi,	// Data bus

		
		output [3:0] r_vga_o,
		output [3:0] g_vga_o ,
		output [3:0] b_vga_o,
		
		output reg v_sync_o,
		output reg h_sync_o
		
	);
	
	wire fclock;
	wire mclock;
	
	wire vga_clk;
	reg [9:0] posx;
	reg [8:0] posy;
	reg [9:0] h_pixel;
	reg [9:0] line;
	
	
	(*keep*) wire [15:0] screen_r_address;
	(*keep*) wire [15:0] screen_w_address;
	
	(*keep*)wire [15:0] command_address;
	wire command_wren;
	wire command_data;
	
	wire wren_a;
	
	(*keep*) wire [7:0] chr_sub;
	(*keep*) wire [11:0] chr_sub_addr;
	
	wire wren_screen;
	assign wren_screen = (curr_addr == 4'b1) ? ~wren & ~cs & clk_ext1: 1'b0;
	
	wire command_request;
	assign command_request =(curr_addr == 4'd5) ? ~wren & ~cs & clk_ext1 & ~command_active : 1'd0;	// Don't overlap commands
	
	(*keep*)wire command_active;
	
	(*keep*)wire [7:0] screen_data;

	
	wire chipclk;
	assign chipclk = clk_ext1 & ~cs;
	
	wire [7:0] data_in;
	(*keep*)wire [7:0] data_out;
	
	assign data_bi = (wren & chipclk) ? data_out : 8'bZ;
	assign data_in = data_bi;

	reg [7:0] int_reg [15:0]; // 16 8 bit registers
	reg [3:0] curr_addr;		// Current address
	
	assign screen_w_address [7:0] = int_reg[3][7:0];
	assign screen_w_address [15:8] = (int_reg[4][7:0]);	
	
	assign screen_r_address = (int_reg[0] == 0) ? mtxt_scr_addr : ((int_reg[0] == 1) ? ctxt_scr_addr : ((int_reg[0] == 2) ? mlbmp_scr_addr : ((int_reg[0] == 3) ? mmbmp_scr_addr : ((int_reg[0] == 4) ? mhbmp_scr_addr : ((int_reg[0] == 5) ? clbmp_scr_addr : cmbmp_scr_addr)))));
	assign chr_sub_addr = (int_reg[0] == 0) ? mtxt_chr_sub_addr : ((int_reg[0] == 1) ? ctxt_chr_sub_addr : 0);
	
	wire [15:0] address_a;
	assign address_a = (command_active) ? command_address : screen_r_address;
	assign wren_a = (command_active) ? command_wren : 0;
	
	
	wire [3:0] r_pixel;
	wire [3:0] g_pixel;
	wire [3:0] b_pixel;
	
	f_clock a (
		.inclk0 (clk),
		.c0 (fclock),
		.c1 (mclock)
	);
	
	vga_clock b (
		.inclk0 (clk),
		.c0 (vga_clk)
	);
	
	commands c (
		.clock (mclock),
		.command (int_reg[5]),
		.request (command_request),
		.user_addr (screen_w_address),
		.cmd_mem_addr (command_address),
		.cmd_mem_data (command_data),
		.cmd_mem_wren (command_wren),
		.active (command_active)
	);
	
	screen_ram d  (
		.address_a (address_a),
		.address_b (screen_w_address),
		.clock (fclock),
		.data_a (command_data),
		.data_b (int_reg[1]),
		.wren_a (wren_a),
		.wren_b (wren_screen),
		.q_a (screen_data),
		.q_b (data_out)
	);
	
	chr_rom e (
		.clock (fclock),
		.address (chr_sub_addr),
		.q (chr_sub)
	);
	
	
	wire [3:0] mtxt_pixel;
	wire [15:0] mtxt_scr_addr;
	wire [11:0] mtxt_chr_sub_addr;
	
	mtxt_ctrl f (
		.clk (fclock),
		.chr_addr (mtxt_scr_addr),
		.chr_val (screen_data),
		.chr_sub (chr_sub),
		.chr_sub_addr (mtxt_chr_sub_addr),
		.posx (posx),
		.posy (posy),
		.m_pixel (mtxt_pixel)
	);
	
	wire [3:0] ctxt_r_pixel;
	wire [3:0] ctxt_b_pixel;
	wire [3:0] ctxt_g_pixel;
	wire [15:0] ctxt_scr_addr;
	wire [11:0] ctxt_chr_sub_addr;
	
	ctxt_ctrl g (
		.clk (fclock),
		.scr_addr (ctxt_scr_addr),
		.scr_val (screen_data),
		.chr_sub_addr (ctxt_chr_sub_addr),
		.chr_sub (chr_sub),
		.posx (posx),
		.posy (posy),
		.r_pixel (ctxt_r_pixel),
		.g_pixel (ctxt_g_pixel),
		.b_pixel (ctxt_b_pixel)
	);
	
	
	wire [3:0] mlbmp_pixel;
	(*keep*)wire [15:0] mlbmp_scr_addr;
	
	mlbmp_ctrl h (
		.clk (fclock),
		.scr_addr (mlbmp_scr_addr),
		.val (screen_data),
		.posx (posx),
		.posy (posy),
		.m_pixel (mlbmp_pixel)	
	
	);
	
	
	wire [3:0] mmbmp_pixel;
	(*keep*)wire [15:0] mmbmp_scr_addr;
	
	mmbmp_ctrl i (
		.clk (fclock),
		.scr_addr (mmbmp_scr_addr),
		.val (screen_data),
		.posx (posx),
		.posy (posy),
		.m_pixel (mmbmp_pixel)	
	
	);
	
	wire [3:0] mhbmp_pixel;
	wire [15:0] mhbmp_scr_addr;
	
	//hbmp_ctrl j ();
	
	
	wire [3:0] clbmp_r_pixel;
	wire [3:0] clbmp_g_pixel;
	wire [3:0] clbmp_b_pixel;
	wire [15:0] clbmp_scr_addr;
	
	clbmp_ctrl k (
		.clk (fclock),
		.scr_addr (clbmp_scr_addr),
		.scr_val (screen_data),
		.posx (posx),
		.posy (posy),
		.r_pixel (clbmp_r_pixel),
		.g_pixel (clbmp_g_pixel),
		.b_pixel (clbmp_b_pixel),
	);
	
	
	wire [3:0] cmbmp_r_pixel;
	wire [3:0] cmbmp_g_pixel;
	wire [3:0] cmbmp_b_pixel;
	wire [15:0] cmbmp_scr_addr;
	
	//cmbmp_ctrl l ();
	
	assign r_pixel = (int_reg[0] == 0) ? mtxt_pixel : ((int_reg[0] == 1) ? ctxt_r_pixel : ((int_reg[0] == 2) ? mlbmp_pixel : ((int_reg[0] == 3) ? mmbmp_pixel : ((int_reg[0] == 4) ? mhbmp_pixel : ((int_reg[0] == 5) ? clbmp_r_pixel : cmbmp_r_pixel)))));
	assign g_pixel = (int_reg[0] == 0) ? mtxt_pixel : ((int_reg[0] == 1) ? ctxt_g_pixel : ((int_reg[0] == 2) ? mlbmp_pixel : ((int_reg[0] == 3) ? mmbmp_pixel : ((int_reg[0] == 4) ? mhbmp_pixel : ((int_reg[0] == 5) ? clbmp_g_pixel : cmbmp_g_pixel)))));
	assign b_pixel = (int_reg[0] == 0) ? mtxt_pixel : ((int_reg[0] == 1) ? ctxt_b_pixel : ((int_reg[0] == 2) ? mlbmp_pixel : ((int_reg[0] == 3) ? mmbmp_pixel : ((int_reg[0] == 4) ? mhbmp_pixel : ((int_reg[0] == 5) ? clbmp_b_pixel : cmbmp_b_pixel)))));
	
	assign r_vga_o = (h_pixel < 640) ? r_pixel : 4'b0000;
	assign g_vga_o = (h_pixel < 640) ? g_pixel : 4'b0000;
	assign b_vga_o = (h_pixel < 640) ? b_pixel : 4'b0000;
	
	
	always @ (posedge clk) begin		// Main code should run here, after data has been recieved
		if (~cs) begin
		curr_addr = rs;
			if (~wren) begin
				int_reg[curr_addr] = data_in;		// Write data to register
			end
		end
	end

	always @(posedge vga_clk) begin
		if (h_pixel < 639) begin
			h_pixel <= h_pixel + 10'b1;
			posx <= posx + 10'b1;				// Increase posx during draw window only
		end
		else if (h_pixel < 660) begin
			h_pixel <= h_pixel + 10'b1;
		end
		else if (h_pixel < 756) begin		
			h_sync_o <= 0;
			h_pixel <= h_pixel + 10'b1; 
		end
		else if (h_pixel < 800) begin
			h_sync_o <= 1;
			h_pixel <= h_pixel + 10'b1;
		end
		else begin
			posx <= 0;							// Reset posx after each line
			h_pixel <= 0;
		end
	end
	
	always @(posedge h_sync_o) begin
		if (line < 480) begin
			v_sync_o <= 1;
			line <= line + 10'b1;
			posy <= posy + 9'b1;			// Increase posy during draw window only
		end
		else if (line < 494) begin
			v_sync_o <= 0;
			line <= line + 10'b1;
		end
		else if (line < 525) begin
			v_sync_o <= 1;
			line <= line + 10'b1;
		end
		else begin
			line <= 0;
			posy <= 0;							// Reset posy after each frame
		end
	end
	
endmodule
	