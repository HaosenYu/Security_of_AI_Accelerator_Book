module gdp_net(input logic start,clk,n_reset,
					input logic signed [15:0] image_pixel,
					input logic store,
					output logic store_finish,
					output logic signed [3:0] categories,
					output logic one_end);

reg [15:0] address;
reg signed [15:0] conv1_weight[3:1];
reg signed [15:0] in;
reg signed ready_in;
reg signed [15:0] bias_conv1[3:1];
address_extract ae (.start(start),.clk(clk),.n_reset(n_reset),
					.address(address));
image_read ir (.start(start),.clk(clk),.n_reset(n_reset),.store(store),.image_pixel(image_pixel),
					.address(address),
					.input_feature(in),.ready_in(ready_in),.store_finish(store_finish));
kernel_conv1 kc1 (.start(start),.clk(clk),.n_reset(n_reset),
						.weight_conv1(conv1_weight),.bias_conv1(bias_conv1));
						
reg signed [15:0] output_conv1 [3:1];
reg ready_conv1;

conv_layer c1 (.input_feature(in),.weight(conv1_weight),.ready_in(ready_in),
					.clk(clk),.n_reset(n_reset),.start(start),
					.output_feature(output_conv1),
					.ready(ready_conv1),.bias_conv1(bias_conv1));
					
reg signed [15:0] output_act1 [3:1];
reg ready_act1;
					
activation_layer act1(.input_feature(output_conv1),.ready(ready_conv1),
							 .clk(clk),.n_reset(n_reset),.start(start),
							 .output_feature(output_act1),
							 .ready_activation(ready_act1));
							 
reg signed [15:0] output_pool1 [3:1];
reg ready_pool1;

pool_layer p1 (.input_feature(output_act1),.ready(ready_act1),
							 .clk(clk),.n_reset(n_reset),.start(start),
							 .output_feature(output_pool1),
							 .ready_pool(ready_pool1));

							 
reg signed [15:0] conv2_weight [9:1];
reg signed [15:0] bias_conv2[3:1];
kernel_conv2 kc2 (.start(start),.n_reset(n_reset),.clk(clk),.ready(ready_pool1),
						.weight_conv2_1(conv2_weight [3:1]),
						.weight_conv2_2(conv2_weight [6:4]),
						.weight_conv2_3(conv2_weight [9:7]),
						.bias_conv2(bias_conv2));
						
reg signed [15:0] output_conv2 [3:1];
reg ready_conv2;
						
conv_layer2 c2	(.input_feature(output_pool1),.weight(conv2_weight),.bias_conv2(bias_conv2),
					 .clk(clk),.n_reset(n_reset),.start(n_reset),.ready_pool(ready_pool1),
					 .output_feature(output_conv2),.ready(ready_conv2));	

reg signed [15:0] output_act2 [3:1];
reg ready_act2;
					
activation_layer act2(.input_feature(output_conv2),.ready(ready_conv2),
							 .clk(clk),.n_reset(n_reset),.start(start),
							 .output_feature(output_act2),
							 .ready_activation(ready_act2));	

reg signed [15:0] output_pool2 [3:1];
reg ready_pool2;

pool_layer p2 (.input_feature(output_act2),.ready(ready_act2),
							 .clk(clk),.n_reset(n_reset),.start(start),
							 .output_feature(output_pool2),
							 .ready_pool(ready_pool2));
reg signed [15:0] weight_ful1 [3:1];	
reg signed [15:0] output_full1 [30:1];
//reg signed [15:0] bias_ful1[30:1];
reg ready_ful1;
reg [4:0] count_ful1,count_finish;		
reg ready_ful2;			 
full_layer1 full1 (.input_feature(output_pool2 ),.ready(ready_pool2),.weight_ful1(weight_ful1),
							 .clk(clk),.n_reset(n_reset),.start(start),.count_finish1(count_finish),.finish(ready_ful2),
							 .output_feature(output_full1),
							 .count_ful1(count_ful1),.ready_ful1(ready_ful1));	

weight_ful1 wf1 (.count_ful(count_ful1),.count_finish(count_finish),
					  .weight_ful1(weight_ful1));

reg signed [15:0] output_act3 [30:1];
reg ready_act3;
					
activation_layer_full actf2(.input_feature(output_full1),.ready(ready_ful1),
							 .clk(clk),.n_reset(n_reset),.start(start),
							 .output_feature(output_act3),
							 .ready_activation(ready_act3));	
reg [3:0]count_1;
reg [4:0]count_2;	
reg signed [15:0] output_full2 [10:1];	
reg signed [15:0] weight_full2;	
reg signed flag_ful2;				 
full_layer2 full2 (.input_feature(output_act3),.ready(ready_act3),.weight_ful2(weight_full2),.flag_ful2(flag_ful2),
							 .clk(clk),.n_reset(n_reset),.start(start),.count1(count_1),.count2(count_2),
							 .output_feature(output_full2),
							 .finish(ready_ful2));
							 
weight_ful2 wf2(.count_2(count_2),.count_1(count_1),.flag_ful2(flag_ful2),
					 .weight_ful2(weight_full2));		

classify cl1 (.input_feature(output_full2),
				  .clk(clk),.ready(ready_ful2),.n_reset(n_reset),
				  .categories(categories),
				  .one_end(one_end));					 
endmodule