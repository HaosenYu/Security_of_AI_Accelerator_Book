module pool_layer (input logic signed [15:0] input_feature [3:1],
					 input logic clk,n_reset,start,ready,
					 output logic signed [15:0] output_feature [3:1],
					 output logic ready_pool);
					 
reg flag1,flag2,flag3;

reg signed [15:0] feature1, feature2, feature3;

pool_pe pp1(.input_featuremap(input_feature[1]),
				.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
				.output_featuremap(feature1),.flag(flag1));

pool_pe pp2(.input_featuremap(input_feature[2]),
				.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
				.output_featuremap(feature2),.flag(flag2));

pool_pe pp3(.input_featuremap(input_feature[3]),
				.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
				.output_featuremap(feature3),.flag(flag3));
				
always_comb
	begin
	if(flag1 & flag2 & flag3)
		begin
		  output_feature[1]=feature1;
		  output_feature[2]=feature2;
		  output_feature[3]=feature3;
		  ready_pool='1;
		end
	else if(flag1|flag2|flag3)
		begin
			$display("Running Error"); 
			output_feature='{3{16'bx}};
			ready_pool=0;
		end
	else
		begin
			output_feature='{3{16'b0}};
         ready_pool='0;
		end
	end
endmodule