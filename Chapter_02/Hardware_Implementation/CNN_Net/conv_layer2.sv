module conv_layer2(input logic signed [15:0] input_feature [3:1],
						input logic signed [15:0] weight[9:1],
						input logic signed [15:0] bias_conv2[3:1],
						input logic clk,n_reset,start,ready_pool,
						output logic signed [15:0] output_feature[3:1],
					   output logic ready);
						
reg signed [15:0] feature1;
reg signed [15:0] feature2;
reg signed [15:0] feature3;
reg [2:0]flag;
conv_pe2 #(25) cp2_1 (.input_featuremap(input_feature[3:1]),.weight(weight[3:1]),.bias(bias_conv2[1]),
				 .clk(clk),.n_reset(n_reset),.start(start),.ready_pool(ready_pool),
				 .output_featuremap(feature1),.flag(flag[0]));
conv_pe2 #(25) cp2_2 (.input_featuremap(input_feature),.weight(weight[6:4]),.bias(bias_conv2[2]),
				 .clk(clk),.n_reset(n_reset),.start(start),.ready_pool(ready_pool),
				 .output_featuremap(feature2),.flag(flag[1]));
conv_pe2 #(25) cp2_3 (.input_featuremap(input_feature),.weight(weight[9:7]),.bias(bias_conv2[3]),
				 .clk(clk),.n_reset(n_reset),.start(start),.ready_pool(ready_pool),
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
					