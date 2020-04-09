module vga_ctrl (
		input vga_clk,
		
		output reg [9:0] posx,
		output reg [9:0] posy,
		
		output reg vsync,
		output reg hsync
	);
	
	reg [9:0] h_pixel;
	reg [9:0] line;

	always @(posedge vga_clk) begin
		if (h_pixel < 639) begin
			h_pixel <= h_pixel + 10'b1;
			posx <= posx + 10'b1;				// Increase posx during draw window only
		end
		else if (h_pixel < 660) begin
			h_pixel <= h_pixel + 10'b1;
		end
		else if (h_pixel < 756) begin		
			hsync <= 0;
			h_pixel <= h_pixel + 10'b1; 
		end
		else if (h_pixel < 800) begin
			hsync <= 1;
			h_pixel <= h_pixel + 10'b1;
		end
		else begin
			posx <= 0;							// Reset posx after each line
			h_pixel <= 0;
		end
	end
	
	always @(posedge hsync) begin
		if (line < 480) begin
			vsync <= 1;
			line <= line + 10'b1;
			posy <= posy + 10'b1;			// Increase posy during draw window only
		end
		else if (line < 494) begin
			vsync <= 0;
			line <= line + 10'b1;
		end
		else if (line < 525) begin
			vsync <= 1;
			line <= line + 10'b1;
		end
		else begin
			line <= 0;
			posy <= 0;							// Reset posy after each frame
		end
	end

	
endmodule
