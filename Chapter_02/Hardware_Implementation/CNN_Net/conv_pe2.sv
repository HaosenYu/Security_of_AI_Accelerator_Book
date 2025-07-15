module conv_pe2 #(parameter kernel_size=9) 
					(input logic signed [15:0] input_featuremap [3:1],
					 input logic signed [15:0] weight [3:1],
					 input logic signed [15:0] bias,
				    input logic n_reset, clk, start,ready_pool,
				    output logic signed [15:0] output_featuremap,
					 output logic flag);
					 
				
reg signed [36:0] sum;
reg [7:0] counter=8'b0;

always_ff @ (posedge clk, negedge n_reset)
	begin
		if(!n_reset)
			begin
				counter<=0;
				sum<=0;
			end
		else if (start==1)
			begin
				if(counter==kernel_size)
					begin
						counter<=0;
						sum<=input_featuremap[1]*weight[1]+input_featuremap[2]*weight[2]+input_featuremap[3]*weight[3];
					end
				else
					begin
						if(ready_pool==1)
							begin
								counter<=counter+8'b1;
								sum<=sum+input_featuremap[1]*weight[1]+input_featuremap[2]*weight[2]+input_featuremap[3]*weight[3];	
							end
						 else
							begin
								counter<=counter;
								sum<=sum;
							end
					end
			end
		else
			begin
				counter<=0;
				sum<=0;
			end			
	end
	
always_comb
	begin
		if(counter==kernel_size)
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