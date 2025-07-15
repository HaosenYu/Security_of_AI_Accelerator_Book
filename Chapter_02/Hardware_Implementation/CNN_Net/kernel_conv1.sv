module kernel_conv1(input logic start,n_reset,clk,
						 output logic signed [15:0] weight_conv1 [3:1],
						 output logic signed [15:0] bias_conv1[3:1]);
logic [4:0] count;
logic signed [15:0] kernel1 [25:0];
logic signed [15:0] kernel2 [25:0];
logic signed [15:0] kernel3 [25:0];
logic signed [15:0] bias [2:0];
logic signed [15:0] weight [3:1];
initial
	begin
		$readmemb("kernel1_conv1.txt", kernel1,24,0);
		$readmemb("kernel2_conv1.txt", kernel2,24,0);
		$readmemb("kernel3_conv1.txt", kernel3,24,0);
		$readmemb("bias_conv.txt", bias);
		kernel1[25]='0;
		kernel2[25]='0;
		kernel3[25]='0;
	end
always_ff @ (posedge clk, negedge n_reset)
	begin
		if(!n_reset==1)
			begin
				count<=0;
				weight<='{3{16'b0}};
			end
		else
			begin
				if(start==1)
					begin
							if(count==5'd25)
								begin
									count<=5'b1;
								end
							else
								begin
									count<=count+5'b1;
								end
							weight[1]=kernel1[25-count];
							weight[2]=kernel2[25-count];
							weight[3]=kernel3[25-count];
					end
				else
					begin
						count<=0;
						weight<='{3{16'b0}};
					end
			end				
	end
always_comb
	begin
		if(start==1)
			begin
				weight_conv1[1]=weight[1];
				weight_conv1[2]=weight[2];
				weight_conv1[3]=weight[3];	
				bias_conv1=bias;
			end
		else
			begin
				weight_conv1='{3{16'b0}};
				bias_conv1='{3{16'b0}};
			end
	end
endmodule