module ctxt_ctrl (		
		input clk,
		input [7:0] scr_val,
		input [9:0] posx,
		input [8:0] posy,
		input [7:0] chr_sub,
		
		output [15:0] scr_addr,
		output [11:0] chr_sub_addr,
		output [3:0] r_pixel,
		output [3:0] g_pixel,
		output [3:0] b_pixel
	);
	
	(*keep*) wire [3:0] row;
	(*keep*) wire [2:0] col;
	(*keep*) wire [7:0] pixel_mask;
	
	wire [12:0] chr_addr;
	wire [12:0] colr_addr;
	
	reg [7:0] chr_val;
	reg [7:0] colr_val;
	
	reg sel;
	
	assign row = posy [3:0];
	assign col = posx [2:0];
	assign pixel_mask = (8'b1 << col);
	
	assign scr_addr [0] = sel;
	assign scr_addr [7:1] = posx [9:3];
	assign scr_addr [12:8] = posy [8:4];
	
	always @(negedge clk) begin
		if (sel == 1) begin
			sel = 0;
		end
		else if (sel == 0) begin
			sel = 1;
		end
		if (sel == 0) begin
			chr_val <= scr_val;
		end
		else if (sel == 1) begin
			colr_val <= scr_val;
		end
	end
	
	assign chr_sub_addr = ((chr_val - 32) << 4) + row;
	
	wire pixel;
	
	assign pixel = (chr_sub & pixel_mask) >> col;
	
	(*keep*)wire [3:0] r_fgnd;
	(*keep*)wire [3:0] g_fgnd;
	(*keep*)wire [3:0] b_fgnd;
	
	assign r_fgnd [3] = colr_val [6];
	assign g_fgnd [3] = colr_val [5];
	assign b_fgnd [3] = colr_val [4];
	
	assign r_fgnd [2:0] = (colr_val [7] & r_fgnd [3]) ? 3'b111 : 3'b000;
	assign g_fgnd [2:0] = (colr_val [7] & g_fgnd [3]) ? 3'b111 : 3'b000;
	assign b_fgnd [2:0] = (colr_val [7] & b_fgnd [3]) ? 3'b111 : 3'b000;
	
	wire [3:0] r_bkgnd;
	wire [3:0] g_bkgnd;
	wire [3:0] b_bkgnd;
	
	assign r_bkgnd [3] = colr_val [2];
	assign g_bkgnd [3] = colr_val [1];
	assign b_bkgnd [3] = colr_val [0];
	
	assign r_bkgnd [2:0] = (colr_val [3] & r_bkgnd [3]) ? 3'b111 : 3'b000;
	assign g_bkgnd [2:0] = (colr_val [3] & g_bkgnd [3]) ? 3'b111 : 3'b000;
	assign b_bkgnd [2:0] = (colr_val [3] & b_bkgnd [3]) ? 3'b111 : 3'b000;
	
	assign r_pixel = pixel ? r_fgnd : r_bkgnd;
	assign g_pixel = pixel ? g_fgnd : g_bkgnd;
	assign b_pixel = pixel ? b_fgnd : b_bkgnd;
	
endmodule
