module mlbmp_ctrl (
		input clk,
		input [7:0] val,
		input [9:0] posx,
		input [8:0] posy,
		
		output [15:0] scr_addr,
		output [3:0] m_pixel
);

	wire [8:0] col;
	wire [7:0] row;
	(*keep*) wire [7:0] pixel_mask;
	
	assign col = posx [9:1];
	assign row = posy [8:1];
	assign pixel_mask = (8'b1 << col[2:0]); 
	
	assign scr_addr [5:0] = col [8:3];
	assign scr_addr [7:6] = 0;
	assign scr_addr [15:8] = row;
	
	wire pixel;
	
	assign pixel = (val & pixel_mask) >> col[2:0];
	assign m_pixel = (pixel) ? 4'b1111 : 4'b0000;

endmodule
