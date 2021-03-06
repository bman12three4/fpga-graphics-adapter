module mtxt_ctrl (
		input clk,
		input [7:0] chr_val,
		input [9:0] posx,
		input [8:0] posy,
		input [7:0] chr_sub,
		
		output [15:0] chr_addr,
		output [11:0] chr_sub_addr,
		output [3:0] m_pixel
	);
	
	(*keep*) wire [3:0] row;
	(*keep*) wire [2:0] col;
	(*keep*) wire [7:0] pixel_mask;
	
	assign row = posy [3:0];
	assign col = posx [2:0];
	assign pixel_mask = (8'b1 << col);
	
	assign chr_addr [7:0] = posx [9:3];
	assign chr_addr [12:8] = posy [8:4];
	
	assign chr_sub_addr = ((chr_val - 32) << 4) + row;
	
	wire pixel;
	
	assign m_pixel = (pixel) ? 4'b1111 : 4'b0000;
	
	assign pixel = (chr_sub & pixel_mask) >> col;
	
endmodule
