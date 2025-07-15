module activation_pe(input logic signed [15:0] input_featuremap,
							input logic clk,n_reset,start,enable,
							output logic signed [15:0] output_featuremap,
							output logic flag);
							
always_ff@(posedge clk, negedge n_reset)
	begin
		if(!n_reset)
			begin
				output_featuremap=0;
			end
		else
			begin
				if (start==0)
					begin
						output_featuremap=0;
						flag<=0;
					end
				else
					begin
						flag<=enable;
						if(input_featuremap>0)
							begin
								if(input_featuremap<16'd6144)
									begin
										output_featuremap<=input_featuremap;
									end
								else
									begin
										output_featuremap<=16'd6144;
									end
							end
						else
							begin
								output_featuremap<='0;
							end
					end
			end						
end
endmodule