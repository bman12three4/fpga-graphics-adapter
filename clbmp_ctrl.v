module clbmp_ctrl (
		input clk,
		input [7:0] scr_val,
		input [9:0] posx,
		input [8:0] posy,
		
		output [15:0] scr_addr,
		output [3:0] r_pixel,
		output [3:0] g_pixel,
		output [3:0] b_pixel
);

	reg sel;

	wire [8:0] col;
	wire [7:0] row;
	(*keep*) wire [7:0] pixel_mask;
	
	reg [7:0] chr_val;
	reg [7:0] colr_val;
	
	assign col = posx [9:2];
	assign row = posy [8:2];
	assign pixel_mask = (8'b1 << col[2:0]); 
	
	assign scr_addr [0] = sel;
	assign scr_addr [6:1] = col [8:3];
	assign scr_addr [7] = 0;
	assign scr_addr [15:8] = row;
	
	always @(posedge clk) begin
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
	
	wire pixel;
	
	assign pixel = (chr_val & pixel_mask) >> col[2:0];
	
	wire [3:0] r_fgnd;
	wire [3:0] g_fgnd;
	wire [3:0] b_fgnd;
	
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