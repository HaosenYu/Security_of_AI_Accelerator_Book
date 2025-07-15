module full_pe (input logic signed [15:0] input_featuremap,
					 input logic signed [15:0] weight,
					 input logic clk,n_reset,start,
					 output logic signed [15:0] output_featuremap);

reg signed [31:0] mul;

always_ff @ (posedge clk, negedge n_reset)
	begin
		if(!n_reset==1)
			begin
				mul<=0;
			end
		else
			begin
				if(start==0)
					begin
						mul<=0;
					end
				else
					begin
						mul<=input_featuremap*weight;
					end
			end
	end

always_comb
	begin
		  output_featuremap={mul[31],mul[24:10]};
	end
endmodule