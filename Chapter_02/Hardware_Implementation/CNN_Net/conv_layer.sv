module conv_layer(input logic signed [15:0] input_feature,
						input logic signed [15:0] weight[3:1],
						input logic signed [15:0] bias_conv1[3:1],
						input logic clk,n_reset,start,ready_in,
						output logic signed [15:0] output_feature[3:1],
					   output logic ready);
						
reg signed [15:0] feature1;
reg signed [15:0] feature2;
reg signed [15:0] feature3;
reg [2:0]flag;
logic signed [15:0] weight_conv[3:1];
always_ff @ (posedge clk, negedge n_reset)
begin
	if(!n_reset)
		begin
			weight_conv[1]=0;
			weight_conv[2]=0;
			weight_conv[3]=0;
		end
	else
		begin
			weight_conv[1]<=weight[1];
			weight_conv[2]<=weight[2];
			weight_conv[3]<=weight[3];
		end	
end
conv_pe #(25) cp1 (.input_featuremap(input_feature),.weight(weight_conv[1]),.bias(bias_conv1[1]),
				 .clk(clk),.n_reset(n_reset),.start(start),.ready_in(ready_in),
				 .output_featuremap(feature1),.flag(flag[0]));
conv_pe #(25) cp2 (.input_featuremap(input_feature),.weight(weight_conv[2]),.bias(bias_conv1[2]),
				 .clk(clk),.n_reset(n_reset),.start(start),.ready_in(ready_in),
				 .output_featuremap(feature2),.flag(flag[1]));
conv_pe #(25) cp3 (.input_featuremap(input_feature),.weight(weight_conv[3]),.bias(bias_conv1[3]),
				 .clk(clk),.n_reset(n_reset),.start(start),.ready_in(ready_in),
				 .output_featuremap(feature3),.flag(flag[2]));

				 
always_comb
	begin
	if(flag[0]&flag[1]&flag[2])
		begin
		  output_feature[1]=feature1;
		  output_feature[2]=feature2;
		  output_feature[3]=feature3;
		  ready='1;
		end
	else if(flag[0]|flag[1]|flag[2])
		begin
			$display("Running Error"); 
			output_feature='{3{16'bx}};
			ready=0;
		end
	else
		begin
			output_feature='{3{16'b0}};
         ready='0;
		end
	end
endmodule
					