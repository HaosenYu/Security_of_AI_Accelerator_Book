module kernel_conv2(input logic start,n_reset,clk,ready,
						 output logic signed [15:0] weight_conv2_1 [3:1],
						 output logic signed [15:0] weight_conv2_2 [3:1],
						 output logic signed [15:0] weight_conv2_3 [3:1],
						 output logic signed [15:0] bias_conv2[3:1]);
reg [4:0] count;
reg signed [15:0] kernel1 [75:0];
reg signed [15:0] kernel2 [75:0];
reg signed [15:0] kernel3 [75:0];
reg signed [15:0] bias [2:0];
initial
	begin
		$readmemb("kernel1_conv2.txt", kernel1,74,0);
		$readmemb("kernel2_conv2.txt", kernel2,74,0);
		$readmemb("kernel3_conv2.txt", kernel3,74,0);
		$readmemb("bias_conv2.txt", bias);
		kernel1[75]='0;
		kernel2[75]='0;
		kernel3[75]='0;
	end
always_ff @ (posedge clk, negedge n_reset)
	begin
		if(!n_reset==1)
			begin
				count<=1;
			end
		else
			begin
				if(start&&ready)
					begin
						if(count==5'd25)
							begin
								count<=1;
							end
						else
							begin
								count<=count+1;
							end
					end
				else
					begin
						count<=count;
					end
			end				
	end
always_comb
	begin
		bias_conv2=bias;
		if(start&&ready)
			begin
				weight_conv2_1[1]=kernel1[75-count];
				weight_conv2_1[2]=kernel1[50-count];
				weight_conv2_1[3]=kernel1[25-count];
				weight_conv2_2[1]=kernel2[75-count];
				weight_conv2_2[2]=kernel2[50-count];
				weight_conv2_2[3]=kernel2[25-count];
				weight_conv2_3[1]=kernel3[75-count];
				weight_conv2_3[2]=kernel3[50-count];
				weight_conv2_3[3]=kernel3[25-count];
			end
		else
			begin
				weight_conv2_1='{3{16'b0}};
				weight_conv2_2='{3{16'b0}};
				weight_conv2_3='{3{16'b0}};				
			end
	end
endmodule