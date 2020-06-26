module mmbmp_ctrl (
		input clk,
		input [7:0] val,
		input [9:0] posx,
		input [8:0] posy,
		
		output [15:0] scr_addr,
		output [3:0] m_pixel
);

	// Each row (high 8 address bits) contains 2 rows.
	// The bit 7 (msb of low 7 bits) is which row you are on
	// so each row has 40 bytes starting at 0 and 40 bytes starting at 128
	// so at any given position, the y position is first divided by 2 (480 -> 240)
	// and then divided by 2 again (since each y position has 2 rows).
	// xpos is divided by 4 (640 -> 320) then divided by 8 to turn it into bytes
	// so position 324/214 would become
	//		y: 53
	//		x: 10
	// but since 215/2 = 107, which is an odd number, we want the second set of
	// bytes which means we add 128 to the xpos and it actually becomes 148/53.
	// The address would then be $3594
	// if y=215 the result would be the same, but at y=212 or 213  it would read
	// from 53/20
	// In terms of bits, row is the the top 7 bits of posy (divided by 4) just like
	// lowres.
	// the 2nd bit of the row becomes the 8th bit
	// so for the first two lines (out of 480) it shouold go down the line for 40 bytes starting at 0
	// for the next two lines (out of 480) it should go down the line for 40 bytes starting at 128


	wire [8:0] col;
	wire [7:0] row;
	(*keep*) wire [7:0] pixel_mask;
	
	assign col = posx [9:1];	// divide posx by 2	
	assign row = posy [8:2];	// divide posy by 4
	assign pixel_mask = (8'b1 << col[2:0]); 
	
	assign scr_addr [5:0] = col [8:3];	// divides col by 8
	assign scr_addr [6] = 0;				// max val for col is 40 (not including msb) so 7th bit is unused
	assign scr_addr [7] = posy[1];		// determines even or odd line. adds 128 to low address accordingly.
	assign scr_addr [15:8] = row;			// the high address is every other line.
	
	wire pixel;
	
	assign pixel = (val & pixel_mask) >> col[2:0];
	assign m_pixel = (pixel) ? 4'b1111 : 4'b0000;

endmodule
