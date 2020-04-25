module mlbmp (
		input clk,
		input [7:0] val,
		input [9:0] posx,
		input [8:0] posy,
		
		output [15:0] chr_addr,
		output [3:0] m_pixel
);

	wire [8:0] col;
	wire [7:0] row;
	wire [7:0] pixel_mask;
	
	assign col = posx [9:1];
	assign row = posy [8:1];
	assign pixel_mask = (8'd128 >> col); // Start at msb, go to lsb so screen isn't mirrored.
	
	assign chr_addr [7:0] = col [8:3];
	assign chr_addr [15:8] = row;
	
	wire pixel;
	
	assign pixel = (val & pixel_mask) >> col;
	assign m_pixel = (pixel) ? 4'b1111 : 4'b0000;

endmodule
