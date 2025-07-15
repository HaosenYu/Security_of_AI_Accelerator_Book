module full_layer2(input logic signed [15:0] input_feature [30:1],
						 input logic signed [15:0] weight_ful2,
						 input logic clk,n_reset,start,ready,
						 output logic signed [15:0] output_feature[10:1],
						 output logic [3:0] count1,
						 output logic [4:0] count2,
						 output logic finish,flag_ful2);

reg signed [15:0] feature1;
reg signed [15:0] hidden_neurons[30:1];
reg signed [15:0] output_neurons[10:1];
reg [3:0] count_1,count_1_1;
reg [4:0] count_2;
reg flag;
reg signed [15:0] bias [9:0];

initial
	begin
	$readmemb("bias_ful2.txt", bias);
	end
	
full_pe fp1 (.input_featuremap(hidden_neurons[count_2]),.weight(weight_ful2),
				 .clk(clk),.n_reset(n_reset),.start(start),
				 .output_featuremap(feature1));
			 
always_ff @ (posedge clk,negedge n_reset)
	begin
		if(!n_reset==1)
			begin
				count_1<=1;
				count_2<=1;
				count_1_1<=0;
				hidden_neurons<='{30{16'b0}};
				output_neurons<='{10{16'b0}};
				flag<=0;
				finish<=0;
			end
		else
			begin
			
				if(ready==1)
					begin
						flag<=1;
					end
				else
					begin
						if(count_1==10&&count_2==30)
							begin
								flag<=0;
							end
						else
							begin
								flag<=flag;
							end
					end
					
				if(flag==1)
					begin
						hidden_neurons<=hidden_neurons;
						if(count_1_1==10)
							begin
								count_1_1<=1;
							end
						else					
							begin
								count_1_1<=count_1_1+1;
							end
						if (count_1==10)
							begin
								count_1<=1;
									if(count_2==30)
										begin
											count_2<=1;
											finish<=1;
										end
									else
										begin
											finish<=0;
											count_2<=count_2+1;
										end
							end
						else
							begin
								finish<=0;
								count_1<=count_1+1;
							end
						output_neurons[count_1_1]<=output_neurons[count_1_1]+feature1;
					end
				else	
					begin
						count_1<=1;
						count_2<=1;
						hidden_neurons<=input_feature;
						finish<=0;
					end						
			end
	end
	
	
	
	
always_comb
begin
	flag_ful2=flag;
	count1=count_1;
	count2=count_2;
	if(finish==1)
		begin
			output_feature[1]=output_neurons[1]+bias[0];
			output_feature[2]=output_neurons[2]+bias[1];
			output_feature[3]=output_neurons[3]+bias[2];
			output_feature[4]=output_neurons[4]+bias[3];
			output_feature[5]=output_neurons[5]+bias[4];
			output_feature[6]=output_neurons[6]+bias[5];
			output_feature[7]=output_neurons[7]+bias[6];
			output_feature[8]=output_neurons[8]+bias[7];
			output_feature[9]=output_neurons[9]+bias[8];
			output_feature[10]=output_neurons[10]+bias[9];
		end
	else
		begin
			output_feature='{10{16'b0}};
		end
end
endmodule