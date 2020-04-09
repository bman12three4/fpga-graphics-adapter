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
		
		output v_sync_o,
		output h_sync_o
		
	);
	
	wire fclock;
	
	
	wire chipclk;
	assign chipclk = clk_ext1 & ~cs;
		
	wire [7:0] data_in;
	wire [7:0] data_out;
	
	assign data_bi = (wren & chipclk) ? data_out : 8'bZ;
	assign data_in = data_bi;
	
	
	wire vga_clk;
	wire [9:0] posx;
	wire [9:0] posy;
	
	
	wire [15:0] screen_r_address;
	wire [15:0] screen_w_address;
	
	wire wren_screen;
	
	wire [7:0] screen_data;

	
	reg [7:0] int_reg [15:0]; // 16 8 bit registers
	reg [3:0] curr_addr;		// Current address
	
	f_clock a (
		.inclk0 (clk),
		.c0 (fclock)
	);
	
	vga_clock b (
		.inclk0 (clk),
		.c0 (vga_clk)
	);
	
	vga_ctrl c (
		.vga_clk (vga_clk),
		.posx (posx),
		.posy (posy),
		.vsync (v_sync_o),
		.hsync (h_sync_o)
	);
	
	screen_ram d  (
		.rdaddress (screen_r_address),
		.wraddress (screen_w_address),
		.clock (fclock),
		.data (int_reg[1]),
		.wren (wren_screen),
		.q (screen_data)
	);
	
	
endmodule
	