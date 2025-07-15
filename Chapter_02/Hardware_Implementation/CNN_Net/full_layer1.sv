module full_layer1(input logic signed [15:0] input_feature[3:1],
						 input logic signed [15:0] weight_ful1[3:1],
						 input logic clk, n_reset, start, ready,finish,
						 output logic signed [15:0] output_feature[30:1],
						 output logic [4:0] count_ful1, count_finish1,
						 output logic ready_ful1);

reg flag,flag1;
reg [4:0] count,count1;
reg [4:0] count_finish;
reg signed [15:0] feature1,feature2,feature3;
reg signed [15:0] neuron_hidden [30:0];
reg signed [15:0] in [3:1];
reg signed [15:0] bias_ful1 [29:0];

initial
	begin
		$readmemb("bias_ful.txt", bias_ful1);
	end
	
full_pe fp1 (.input_featuremap(in[1]),.weight(weight_ful1[1]),
				 .clk(clk),.n_reset(n_reset),.start(start),
				 .output_featuremap(feature1));
full_pe fp2 (.input_featuremap(in[2]),.weight(weight_ful1[2]),
				 .clk(clk),.n_reset(n_reset),.start(start),
				 .output_featuremap(feature2));
full_pe fp3 (.input_featuremap(in[3]),.weight(weight_ful1[3]),
				 .clk(clk),.n_reset(n_reset),.start(start),
				 .output_featuremap(feature3));
				 
always_ff @ (posedge clk, negedge n_reset)
	begin
		if(!n_reset==1)
			begin
				count<=0;
				count_finish<=0;
				in<='{3{16'b0}};
				neuron_hidden<='{31{32'b0}};
			end
		else
			begin
				if(finish)
					begin
						count_finish<=0;
						neuron_hidden<='{31{32'b0}};
					end
				else
					begin
						count_finish<=count_finish;
						neuron_hidden<=neuron_hidden;
					end
				if(ready==1)
					begin
						count_finish<=count_finish+1;
						flag<=1;
					end
				else
					begin
						count_finish<=count_finish;
						flag<=flag;
					end
				if(flag==1)
					begin
					in<=in;
					if(count==0)
						begin
							count1<=0;
						end
					else
						begin
							count1<=count1+1;
						end
					if(count1==30)
						begin
							flag<=0;
						end
					else
						begin
							flag<=flag;
						end
						
					neuron_hidden[count1]<=neuron_hidden[count1]+feature1+feature2+feature3;
						if(count==30)
							begin
								count<=0;
							end
						else
							begin
								count<=count+5'b1;
							end
					end
				else
					begin
						neuron_hidden<=neuron_hidden;
						in<=input_feature;
						count<=0;
					end
				if(count_finish==16&&count1==30)
					begin
						flag1<=1;
					end
				else
					begin
						flag1<=0;
					end
			end
	end

always_comb
	begin
		count_ful1=count;
		count_finish1=count_finish;
		if(flag1)
			begin
//				output_feature[1]={neuron_hidden[1][31],neuron_hidden[1][24:10]}+bias_ful1[0];
//				output_feature[2]={neuron_hidden[2][31],neuron_hidden[2][24:10]}+bias_ful1[1];
//				output_feature[3]={neuron_hidden[3][31],neuron_hidden[3][24:10]}+bias_ful1[2];
//				output_feature[4]={neuron_hidden[4][31],neuron_hidden[4][24:10]}+bias_ful1[3];
//				output_feature[5]={neuron_hidden[5][31],neuron_hidden[5][24:10]}+bias_ful1[4];
//				output_feature[6]={neuron_hidden[6][31],neuron_hidden[6][24:10]}+bias_ful1[5];
//				output_feature[7]={neuron_hidden[7][31],neuron_hidden[7][24:10]}+bias_ful1[6];
//				output_feature[8]={neuron_hidden[8][31],neuron_hidden[8][24:10]}+bias_ful1[7];
//				output_feature[9]={neuron_hidden[9][31],neuron_hidden[9][24:10]}+bias_ful1[8];
//				output_feature[10]={neuron_hidden[10][31],neuron_hidden[10][24:10]}+bias_ful1[9];
//				output_feature[11]={neuron_hidden[11][31],neuron_hidden[11][24:10]}+bias_ful1[10];
//				output_feature[12]={neuron_hidden[12][31],neuron_hidden[12][24:10]}+bias_ful1[11];
//				output_feature[13]={neuron_hidden[13][31],neuron_hidden[13][24:10]}+bias_ful1[12];
//				output_feature[14]={neuron_hidden[14][31],neuron_hidden[14][24:10]}+bias_ful1[13];
//				output_feature[15]={neuron_hidden[15][31],neuron_hidden[15][24:10]}+bias_ful1[14];
//				output_feature[16]={neuron_hidden[16][31],neuron_hidden[16][24:10]}+bias_ful1[15];
//				output_feature[17]={neuron_hidden[17][31],neuron_hidden[17][24:10]}+bias_ful1[16];
//				output_feature[18]={neuron_hidden[18][31],neuron_hidden[18][24:10]}+bias_ful1[17];
//				output_feature[19]={neuron_hidden[19][31],neuron_hidden[19][24:10]}+bias_ful1[18];
//				output_feature[20]={neuron_hidden[20][31],neuron_hidden[20][24:10]}+bias_ful1[19];
//				output_feature[21]={neuron_hidden[21][31],neuron_hidden[21][24:10]}+bias_ful1[20];
//				output_feature[22]={neuron_hidden[22][31],neuron_hidden[22][24:10]}+bias_ful1[21];
//				output_feature[23]={neuron_hidden[23][31],neuron_hidden[23][24:10]}+bias_ful1[22];
//				output_feature[24]={neuron_hidden[24][31],neuron_hidden[24][24:10]}+bias_ful1[23];
//				output_feature[25]={neuron_hidden[25][31],neuron_hidden[25][24:10]}+bias_ful1[24];
//				output_feature[26]={neuron_hidden[26][31],neuron_hidden[26][24:10]}+bias_ful1[25];
//				output_feature[27]={neuron_hidden[27][31],neuron_hidden[27][24:10]}+bias_ful1[26];
//				output_feature[28]={neuron_hidden[28][31],neuron_hidden[28][24:10]}+bias_ful1[27];
//				output_feature[29]={neuron_hidden[29][31],neuron_hidden[29][24:10]}+bias_ful1[28];
//				output_feature[30]={neuron_hidden[30][31],neuron_hidden[30][24:10]}+bias_ful1[29];	
				output_feature[1]=neuron_hidden[1]+bias_ful1[0];
				output_feature[2]=neuron_hidden[2]+bias_ful1[1];
				output_feature[3]=neuron_hidden[3]+bias_ful1[2];
				output_feature[4]=neuron_hidden[4]+bias_ful1[3];
				output_feature[5]=neuron_hidden[5]+bias_ful1[4];
				output_feature[6]=neuron_hidden[6]+bias_ful1[5];
				output_feature[7]=neuron_hidden[7]+bias_ful1[6];
				output_feature[8]=neuron_hidden[8]+bias_ful1[7];
				output_feature[9]=neuron_hidden[9]+bias_ful1[8];
				output_feature[10]=neuron_hidden[10]+bias_ful1[9];
				output_feature[11]=neuron_hidden[11]+bias_ful1[10];
				output_feature[12]=neuron_hidden[12]+bias_ful1[11];
				output_feature[13]=neuron_hidden[13]+bias_ful1[12];
				output_feature[14]=neuron_hidden[14]+bias_ful1[13];
				output_feature[15]=neuron_hidden[15]+bias_ful1[14];
				output_feature[16]=neuron_hidden[16]+bias_ful1[15];
				output_feature[17]=neuron_hidden[17]+bias_ful1[16];
				output_feature[18]=neuron_hidden[18]+bias_ful1[17];
				output_feature[19]=neuron_hidden[19]+bias_ful1[18];
				output_feature[20]=neuron_hidden[20]+bias_ful1[19];
				output_feature[21]=neuron_hidden[21]+bias_ful1[20];
				output_feature[22]=neuron_hidden[22]+bias_ful1[21];
				output_feature[23]=neuron_hidden[23]+bias_ful1[22];
				output_feature[24]=neuron_hidden[24]+bias_ful1[23];
				output_feature[25]=neuron_hidden[25]+bias_ful1[24];
				output_feature[26]=neuron_hidden[26]+bias_ful1[25];
				output_feature[27]=neuron_hidden[27]+bias_ful1[26];
				output_feature[28]=neuron_hidden[28]+bias_ful1[27];
				output_feature[29]=neuron_hidden[29]+bias_ful1[28];
				output_feature[30]=neuron_hidden[30]+bias_ful1[29];				
				ready_ful1=1;
			end
		else
			begin
				output_feature= '{30{16'b0}};
				ready_ful1=0;
			end		
	end
endmodule