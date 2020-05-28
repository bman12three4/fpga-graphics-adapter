module mtile_ctrl (		
		input clk,
		input [7:0] val,
		input [9:0] posx,
		input [8:0] posy,
		
		output reg [15:0] scr_addr,
		output [3:0] m_pixel
		);
		
	wire [4:0] row;
	wire [1:0] col8;
	wire [3:0] col;
	wire [7:0] pixel_mask;
	
	reg [7:0] tile_val;
	reg [7:0] tile_byte;
	
	assign row = posy [4:0];
	assign col8 = posx [4:3];
	assign col = posx [2:0];
	assign pixel_mask = (8'b1 << col);
	
	
	wire [15:0] tile_val_addr;
	wire [15:0] tile_data_addr;
	
	assign tile_val_addr [4:0] = posx[9:5];	// The address uses only 9 bits, but when writing you use
	assign tile_val_addr [8:5] = posy[8:5];	// reg 3 as x position and reg 4 as y position. See main module.
	assign tile_val_addr [15] = 1'b1;			//table is in upper RAM
	
	wire pixel;
	
	assign pixel = (tile_byte & pixel_mask) >> col;	// This stuff works the same as the bitmap mode
	assign m_pixel = (pixel) ? 4'b1111 : 4'b0000;	// since they're basically the same at drawing. 
	
	assign tile_data_addr = {1'b0, tile_val, row, col8};	// Get tile data address based on tile val, row, and byte. 
	
	always @(posedge clk) begin
		scr_addr = tile_val_addr;	// Load tile value address
		tile_val = val;				// Set tile value
		scr_addr = tile_data_addr;	// Load tile data address (see above) 
		tile_byte = val;				// Set tile data.
	end
	
	
	/*
			1. Get current tile value (20x15 tiles, 32x32 pixels)
			2. Get byte based on tile value and position in tile (tiles are 4x32 bytes)
			3. Draw pixel based on screen position.
			
			tilex = posx/32 (posx[9:5])
			tiley = posy/32 (posy[8:5])
			
			col = posx%32/4 (posy[4:3]) 
			row = posy%32 (posy[4:0)
			
			tiles start at $0000 and are organized as each line of 4 bytes one after another, all the way to $7FFF.
			Each tile is 128 bytes (32*4)
			
			To get a tile value of 7, line 37, byte 3 would be at (128*7)+(37*4)+3, or 8000+(80*7)+(25*4)+3=$8417
			
			or, [0][tile_val 7:0][row 4:0][col8 1:0]
			
	*/
	
	
	
	

endmodule
