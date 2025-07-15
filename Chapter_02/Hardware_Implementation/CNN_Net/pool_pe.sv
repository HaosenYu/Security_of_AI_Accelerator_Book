module pool_pe(input logic signed [15:0] input_featuremap,
					input logic clk,n_reset,start,enable,
					output logic signed [15:0] output_featuremap,
					output logic flag);
					
reg signed [15:0] max_value;
reg [2:0] counter=3'b0;
always_ff@(posedge clk, negedge n_reset)
	begin
		if(!n_reset)
			begin
				max_value<='0;
				counter<=3'b0;
			end
		else
			begin
				if(start==1)
					begin
					if(counter==4)
						begin
							counter<=0;
							max_value<=input_featuremap;
						end
					else
						begin
							if(enable==1)
								begin
									counter<=counter+1'b1;
										if (max_value<=input_featuremap)
											begin
												max_value<=input_featuremap;
											end
										else 
											begin
												max_value<=max_value;
											end
								end
							else
								begin
									counter<=counter;
									max_value<=max_value;
								end
						end
					end
				else					
					begin
						max_value<='0;
						counter<='0;
					end						
			end
	end
always_comb
	begin
		if(counter==4)
			begin
				flag='1;
				output_featuremap=max_value;
			end
		else
			begin
				flag='0;
				output_featuremap='0;
			end
	end
endmodule			