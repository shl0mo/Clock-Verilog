module decod(input reg[3:0] num,
					  output reg[6:0] out);
always @ (num)begin
  case (num)
    4'b0000 : out = 7'b0111111;
    4'b0001 : out = 7'b0000110;
    4'b0010 : out = 7'b1011011;
    4'b0011 : out = 7'b1001111;
    4'b0100 : out = 7'b1100110;
    4'b0101 : out = 7'b1101101;
    4'b0110 : out = 7'b1111101;
    4'b0111 : out = 7'b0000111;
    4'b1000 : out = 7'b1111111;
    4'b1001 : out = 7'b1101111;
  endcase
	end
endmodule


module relogio #(parameter ciclo = 37)(input clk_in,
				output reg[6:0] disp1, disp2, disp3, disp4);
reg[3:0] count1, count2, count3, count4, count5, count6;
wire[6:0] s1,s2,m1,m2,h1,h2;
reg[15:0] numero;
reg clk_out;
always @ (negedge clk_in)
  begin
  numero <= numero + 1;
  if (numero == ciclo - 2)begin
    clk_out <= ~clk_out;
    end
  else if (numero == ciclo - 1)begin
    clk_out <= ~clk_out;
    numero <= 0;
    end
  end
always @ (negedge clk_out) 
	begin
	count1 <=  count1 + 1;
	if (count1 == 9) begin
		count2 <= count2 + 1;
		count1 <= 0;
		end 
	if (count2 == 5 & count1 == 9)begin
		count2 <= 0;		
		count3 <= count3 + 1;
		end
	if (count3 == 9 & count2 == 5 & count1 == 9)begin 
		count3 <= 0;
		count4 <=  count4 + 1;
		end	
	if (count4 == 5 & count3 == 9 & count2 == 5 & count1 == 9)begin
		count4 <= 0;
		count5 <= count5 + 1;
		end
	if (count5 == 9 & count4 == 5 & count3 == 9 & count2 == 5 & count1 == 9)begin
		count5 <= 0;
		count6 <= count6 + 1;
		end
 	if (count6 == 2 & count5 == 3 & count4 == 5 & count3 == 9 & count2 == 5 & count1 == 9)begin
		count6 <= 0;
		count5 <= 0;
		end
	end
  decod decoder1 (count1,s1);
  decod decoder2 (count2,s2);
  decod decoder3 (count3,m1);
  decod decoder4 (count4,m2);
  decod decoder5 (count5,h1);
  decod decoder6 (count6,h2);
  always @ (count2)
    begin
    if (count2 == 4'b0000 | count2 == 4'b0010 | count2 == 4'b0100)begin
      assign disp1 = s1;
      assign disp2 = s2;
      assign disp3 = m1;
      assign disp4 = m2;
      end
    else begin
      assign disp1 = m1;
      assign disp2 = m2;
      assign disp3 = h1;
      assign disp4 = h2;
      end
    end
endmodule   