module conv_pe #(parameter kernel_size=9) 
					(input logic signed [15:0] input_featuremap,
					 input logic signed [15:0] weight,
					 input logic signed [15:0] bias,
				    input logic n_reset, clk, start,ready_in,
				    output logic signed [15:0] output_featuremap,
					 output logic flag);
					 
				
reg signed [31:0] mul;
reg signed [36:0] sum;
reg [7:0] counter=8'b0;

always_ff @ (posedge clk, negedge n_reset)
	begin
		if(!n_reset)
			begin
				mul<=0;
				counter<=0;
				sum<=0;
			end
		else if (start==1)
			begin
				if(ready_in==1)
					begin
						mul<=input_featuremap*weight;
						if(counter==kernel_size+1)
							begin
								counter<=2;
								sum<=input_featuremap*weight;
							end
						else
							begin
								counter<=counter+8'b1;
								sum<=sum+input_featuremap*weight;
							end	
					end
				else
					begin
						mul<=0;
						counter<=0;
						sum<=0;
					end
			end
		else
			begin
				mul<=0;
				counter<=0;
				sum<=0;
			end			
	end
	
always_comb
	begin
		if(counter==kernel_size+1)
			begin
				flag=1;
				output_featuremap={sum[36],sum[24:10]}+bias;
			end
		else
			begin
				flag=0;
				output_featuremap='0;
			end
	end	
endmodule