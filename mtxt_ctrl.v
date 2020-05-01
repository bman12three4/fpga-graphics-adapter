module mtxt_ctrl (
		input clk,
		input [7:0] chr_val,
		input [9:0] posx,
		input [8:0] posy,
		input [7:0] chr_sub,
		input [7:0] y_reg,
		
		output [15:0] chr_addr,
		output [15:0] chr_scroll_addr,
		output [11:0] chr_sub_addr,
		output [3:0] m_pixel
	);
	
	(*keep*) reg [8:0] scrolly;
	(*keep*) reg [8:0] yadjust;
	(*keep*) wire [3:0] row;
	(*keep*) wire [2:0] col;
	(*keep*) wire [7:0] pixel_mask;
	
	assign row = posy [3:0];
	assign col = posx [2:0];
	assign pixel_mask = (8'b1 << col);
	
	assign chr_addr [6:0] = posx [9:3];
	assign chr_addr [11:7] = posy [8:4];
	assign chr_addr [15:12] = 0;
	
	assign chr_scroll_addr [6:0] = posx [9:3];
	assign chr_scroll_addr [15:7] = yadjust;
	
	assign chr_sub_addr = ((chr_val - 32) << 4) + row;
	
	wire pixel;
	
	assign m_pixel = (pixel) ? 4'b1111 : 4'b0000;
	
	assign pixel = (chr_sub & pixel_mask) >> col;
	
	always @(posedge clk) begin
		scrolly [4:0] <= posy [8:4];
		scrolly [8:5] <= 0;
		if (y_reg > 29) begin
			yadjust <= scrolly + y_reg - 29;
		end
		else begin
			yadjust <= scrolly;
		end
	end
	
endmodule
