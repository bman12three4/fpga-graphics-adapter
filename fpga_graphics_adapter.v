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
	
	wire vga_clk;
	reg [9:0] posx;
	reg [8:0] posy;
	reg [9:0] h_pixel;
	reg [9:0] line;
	
	
	(*keep*) wire [15:0] screen_r_address;
	(*keep*) wire [15:0] screen_w_address;
	
	(*keep*) wire [7:0] chr_sub;
	(*keep*) wire [11:0] chr_sub_addr;
	
	wire wren_screen;
	assign wren_screen = (curr_addr == 4'b1) ? ~wren : 1'b0;
	
	(*keep*)wire [7:0] screen_data;

	
	wire chipclk;
	assign chipclk = clk_ext1 & ~cs;
	
	wire [7:0] data_in;
	wire [7:0] data_out;
	
	assign data_bi = (wren & chipclk) ? data_out : 8'bZ;
	assign data_in = data_bi;

	reg [7:0] int_reg [15:0]; // 16 8 bit registers
	reg [3:0] curr_addr;		// Current address
	
	
	// modes 0 and 1 use xy mode, modes 2 and 3 use address mode
	assign screen_w_address [6:0] = int_reg[3][6:0];
	assign screen_w_address [7] = int_reg[0][1] ? (int_reg[3][7]) : (int_reg[4][0]);
	assign screen_w_address [15:8] = int_reg[0][1] ? (int_reg[4][7:0]) : (int_reg[4][7:1]);	
	
	
	wire [3:0] r_pixel;
	wire [3:0] g_pixel;
	wire [3:0] b_pixel;
	
	f_clock a (
		.inclk0 (clk),
		.c0 (fclock)
	);
	
	vga_clock b (
		.inclk0 (clk),
		.c0 (vga_clk)
	);
	
	
	screen_ram d  (
		.rdaddress (screen_r_address),
		.wraddress (screen_w_address),
		.clock (fclock),
		.data (int_reg[1]),
		.wren (wren_screen),
		.q (screen_data)
	);
	
	/*
	DEBUGscreen_rom d (
		.clock (fclock),
		.address (screen_r_address),
		.q (screen_data)
	);
	*/
	
	chr_rom e (
		.clock (fclock),
		.address (chr_sub_addr),
		.q (chr_sub)
	);
	
	wire [3:0] mtxt_pixel;
	
	mtxt_ctrl f (
		.clk (fclock),
		.chr_addr (screen_r_address),
		.chr_val (screen_data),
		.chr_sub (chr_sub),
		.chr_sub_addr (chr_sub_addr),
		.posx (posx),
		.posy (posy),
		.m_pixel (mtxt_pixel)
	);
	
	wire [3:0] ctxt_r_pixel;
	wire [3:0] ctxt_b_pixel;
	wire [3:0] ctxt_g_pixel;
	
	ctxt_ctrl g ();
	
	wire [3:0] lbmp_r_pixel;
	wire [3:0] lbmp_b_pixel;
	wire [3:0] lbmp_g_pixel;
	
	//lbmp_ctrl h ();
	
	wire [3:0] hbmp_pixel;
	
	//hbmp_ctrl i ();
	assign r_pixel = (int_reg[0] == 0) ? mtxt_pixel : ((int_reg[0] == 1) ? ctxt_r_pixel : ((int_reg[0] == 2) ? lbmp_r_pixel : hbmp_pixel));
	assign g_pixel = (int_reg[0] == 0) ? mtxt_pixel : ((int_reg[0] == 1) ? ctxt_g_pixel : ((int_reg[0] == 2) ? lbmp_g_pixel : hbmp_pixel));
	assign b_pixel = (int_reg[0] == 0) ? mtxt_pixel : ((int_reg[0] == 1) ? ctxt_b_pixel : ((int_reg[0] == 2) ? lbmp_b_pixel : hbmp_pixel));
	
	assign r_vga_o = (h_pixel < 640) ? r_pixel : 4'b0000;
	assign g_vga_o = (h_pixel < 640) ? b_pixel : 4'b0000;
	assign b_vga_o = (h_pixel < 640) ? g_pixel : 4'b0000;
	
	always @ (posedge chipclk) begin
		curr_addr = rs;
	end
	
	always @ (negedge chipclk) begin		// Main code should run here, after data has been recieved
		int_reg[curr_addr] = data_in;
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
	