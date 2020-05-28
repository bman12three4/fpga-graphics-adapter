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
	
	
	(*keep*) wire [7:0] chr_sub;
	
	wire wren_screen;
	assign wren_screen = (curr_addr == 4'b1) ? ~wren & ~cs & clk_ext1: 1'b0;
	
	(*keep*)wire [7:0] screen_data;

	
	wire chipclk;
	assign chipclk = clk_ext1 & ~cs;
	
	wire [7:0] data_in;
	wire [7:0] data_out;
	
	assign data_bi = (wren & chipclk) ? data_out : 8'bZ;
	assign data_in = data_bi;

	// various mode constants  to use for the arrays
	localparam [7:0] mtext = 8'd0;
	localparam [7:0] ctext = 8'd1;
	localparam [7:0] mlbmp = 8'd2;
	localparam [7:0] mhbmp = 8'd3;
	localparam [7:0] clbmp = 8'd4;
	localparam [7:0] chbmp = 8'd5;
	localparam [7:0] mtini = 8'd6;
	localparam [7:0] mtdrw = 8'd7;
	
	reg [7:0] int_reg [15:0]; // 16 8 bit registers
	reg [3:0] curr_addr;		// Current address
	
	
	//256 possible values for each mode, not all are used though
	wire [3:0] r_pixel [255:0];
	wire [3:0] b_pixel [255:0];
	wire [3:0] g_pixel [255:0];
	wire [15:0] scr_addr [255:0];
	wire [11:0] chr_rom_addr [255:0];
	wire [15:0] screen_w_address [255:0];
	
	
	/* 
	 *	These are so you can use 2 full bytes (x and y usually) but compress it down to fewer bits
	 *	If you don't need all 16. mtdrw needs only 9 for example, so only the first few bits from each
	 *	reg are actually used, the others we don't care about. 
	 */
	assign screen_w_address[mtext] = {int_reg[4][7:0], int_reg[3][7:0]};	//standard address model, terribly inefficient.
	assign screen_w_address[ctext] = {int_reg[4][7:0], int_reg[3][7:0]};	//can access entire
	assign screen_w_address[mlbmp] = {int_reg[4][7:0], int_reg[3][7:0]};	
	assign screen_w_address[mhbmp] = {int_reg[4][7:0], int_reg[3][7:0]};	
	assign screen_w_address[clbmp] = {int_reg[4][7:0], int_reg[3][7:0]};	
	assign screen_w_address[chbmp] = {int_reg[4][7:0], int_reg[3][7:0]};
	assign screen_w_address[mtini] = {1'b0, int_reg[4][6:0], int_reg[3][7:0]}; // Tile data takes up all of low ram
	assign screen_w_address[mtdrw] = {1'b1, 5'b0, int_reg[4][3:0], int_reg[3][4:0]}; // There is less space above $8000 so the small table is stored there.

	
	
	f_clock a (
		.inclk0 (clk),
		.c0 (fclock)
	);
	
	vga_clock b (
		.inclk0 (clk),
		.c0 (vga_clk)
	);
	
	
	screen_ram d  (
		.rdaddress (scr_addr[int_reg[0]]),
		.wraddress (screen_w_address[int_reg[0]]),
		.clock (fclock),
		.data (int_reg[1]),
		.wren (wren_screen),
		.q (screen_data)
	);
	
	
	chr_rom e (
		.clock (fclock),
		.address (chr_rom_addr[int_reg[0]]),
		.q (chr_sub)
	);
	
	wire [3:0] mtxt_pixel;										// All the modes work in the same way.
	wire [15:0] mtxt_scr_addr;									// These wires are passed through to the controller
	wire [11:0] mtxt_chr_sub_addr;							// Only really necesary for the mono pixels though.
	
	assign r_pixel[mtext] = mtxt_pixel;						// The wires in the main array are assigned as these
	assign g_pixel[mtext] = mtxt_pixel;						// wires for the specific mode, so it's easy to choose 
	assign b_pixel[mtext] = mtxt_pixel;						// which one you want. 
	assign scr_addr[mtext] = mtxt_scr_addr;
	assign chr_rom_addr[mtext] = mtxt_chr_sub_addr;
	
	mtxt_ctrl f (													// The controller module
		.clk (fclock),												// The local wires are passed in but they are the same as
		.chr_addr (mtxt_scr_addr),								// the ones from the big array.
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
	
	assign r_pixel[ctext] = ctxt_r_pixel;
	assign g_pixel[ctext] = ctxt_g_pixel;
	assign b_pixel[ctext] = ctxt_b_pixel;
	assign scr_addr[ctext] = ctxt_scr_addr;
	assign chr_rom_addr[ctext] = ctxt_chr_sub_addr;
	
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
	wire [15:0] mlbmp_scr_addr;
	
	assign r_pixel[mlbmp] = mlbmp_pixel;
	assign g_pixel[mlbmp] = mlbmp_pixel;
	assign b_pixel[mlbmp] = mlbmp_pixel;
	assign scr_addr[mlbmp] = mlbmp_scr_addr;
	
	mlbmp_ctrl h (
		.clk (fclock),
		.scr_addr (mlbmp_scr_addr),
		.val (screen_data),
		.posx (posx),
		.posy (posy),
		.m_pixel (mlbmp_pixel)	
	);
	
	wire [3:0] mhbmp_pixel;
	wire [15:0] mhbmp_scr_addr;
	
	assign r_pixel[mhbmp] = mhbmp_pixel;
	assign g_pixel[mhbmp] = mhbmp_pixel;
	assign b_pixel[mhbmp] = mhbmp_pixel;
	assign scr_addr[mhbmp] = mhbmp_scr_addr;
	
	//mhbmp_ctrl i ();
	
	wire [3:0] mtile_pixel;
	wire [15:0] mtile_scr_addr;
	
	assign r_pixel[mtdrw] = mtile_pixel;		// Draw tiles in draw mode
	assign g_pixel[mtdrw] = mtile_pixel;
	assign b_pixel[mtdrw] = mtile_pixel;
	assign scr_addr[mtdrw] = mtile_scr_addr;
	
	assign r_pixel[mtini] = mtile_pixel;		// Still draw tiles in init mode.
	assign g_pixel[mtini] = mtile_pixel;		// but any writes will be to tile data,
	assign b_pixel[mtini] = mtile_pixel;		// so you can't change what tiles appear
	assign scr_addr[mtini] = mtile_scr_addr;	// on the screen.
	
	mtile_ctrl j (
		.clk (fclock),
		.scr_addr (mtile_scr_addr),
		.val (screen_data),
		.posx (posx),
		.posy (posy),
		.m_pixel (mtile_pixel)
	);
	
	// Get the pixels for the current mode and draw them within the frame.
	assign r_vga_o = (h_pixel < 640) ? r_pixel[int_reg[0]] : 4'b0000;
	assign g_vga_o = (h_pixel < 640) ? g_pixel[int_reg[0]] : 4'b0000;
	assign b_vga_o = (h_pixel < 640) ? b_pixel[int_reg[0]] : 4'b0000;
	
	always @ (posedge ~cs) begin
		curr_addr = rs;
	end
	
	always @ (posedge (~wren & ~cs & clk)) begin		// Main code should run here, after data has been recieved
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
	