module activation_layer_full (input logic signed [15:0] input_feature [30:1],
								 input logic clk,n_reset,start,ready,
								 output logic signed [15:0] output_feature [30:1],
								 output logic ready_activation);
					 
reg flag1,flag2,flag3,flag4,flag5,flag6,flag7,flag8,flag9,flag10;
reg flag11,flag12,flag13,flag14,flag15,flag16,flag17,flag18,flag19,flag20;
reg flag21,flag22,flag23,flag24,flag25,flag26,flag27,flag28,flag29,flag30;
reg signed [15:0] feature1, feature2, feature3, feature4, feature5, feature6, feature7, feature8, feature9, feature10;
reg signed [15:0] feature11, feature12, feature13, feature14, feature15, feature16, feature17, feature18, feature19, feature20;
reg signed [15:0] feature21, feature22, feature23, feature24, feature25, feature26, feature27, feature28, feature29, feature30;
activation_pe ap1		(.input_featuremap(input_feature[1]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature1),.flag(flag1));

activation_pe ap2		(.input_featuremap(input_feature[2]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature2),.flag(flag2));

activation_pe ap3		(.input_featuremap(input_feature[3]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature3),.flag(flag3));
							
activation_pe ap4		(.input_featuremap(input_feature[4]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature4),.flag(flag4));
							
activation_pe ap5		(.input_featuremap(input_feature[5]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature5),.flag(flag5));
							
activation_pe ap6		(.input_featuremap(input_feature[6]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature6),.flag(flag6));
							
activation_pe ap7		(.input_featuremap(input_feature[7]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature7),.flag(flag7));
							
activation_pe ap8		(.input_featuremap(input_feature[8]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature8),.flag(flag8));	
	
activation_pe ap9		(.input_featuremap(input_feature[9]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature9),.flag(flag9));
						
activation_pe ap10		(.input_featuremap(input_feature[10]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature10),.flag(flag10));
							
activation_pe ap11		(.input_featuremap(input_feature[11]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature11),.flag(flag11));

activation_pe ap12		(.input_featuremap(input_feature[12]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature12),.flag(flag12));

activation_pe ap13		(.input_featuremap(input_feature[13]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature13),.flag(flag13));
							
activation_pe ap14		(.input_featuremap(input_feature[14]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature14),.flag(flag14));
							
activation_pe ap15		(.input_featuremap(input_feature[15]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature15),.flag(flag15));
							
activation_pe ap16		(.input_featuremap(input_feature[16]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature16),.flag(flag16));
							
activation_pe ap17		(.input_featuremap(input_feature[17]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature17),.flag(flag17));
							
activation_pe ap18		(.input_featuremap(input_feature[18]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature18),.flag(flag18));	
	
activation_pe ap19		(.input_featuremap(input_feature[19]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature19),.flag(flag19));
						
activation_pe ap20		(.input_featuremap(input_feature[20]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature20),.flag(flag20));	

activation_pe ap21		(.input_featuremap(input_feature[21]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature21),.flag(flag21));

activation_pe ap22		(.input_featuremap(input_feature[22]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature22),.flag(flag22));

activation_pe ap23		(.input_featuremap(input_feature[23]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature23),.flag(flag23));
							
activation_pe ap24		(.input_featuremap(input_feature[24]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature24),.flag(flag24));
							
activation_pe ap25		(.input_featuremap(input_feature[25]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature25),.flag(flag25));
							
activation_pe ap26		(.input_featuremap(input_feature[26]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature26),.flag(flag26));
							
activation_pe ap27		(.input_featuremap(input_feature[27]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature27),.flag(flag27));
							
activation_pe ap28		(.input_featuremap(input_feature[28]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature28),.flag(flag28));	
	
activation_pe ap29		(.input_featuremap(input_feature[29]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature29),.flag(flag29));
						
activation_pe ap30		(.input_featuremap(input_feature[30]),
							.clk(clk),.n_reset(n_reset),.enable(ready),.start(start),
							.output_featuremap(feature30),.flag(flag30));							
always_comb
	begin
	if(flag1 & flag11 & flag21)
		begin
		  output_feature[1]=feature1;
		  output_feature[2]=feature2;
		  output_feature[3]=feature3;
		  output_feature[4]=feature4;
		  output_feature[5]=feature5;
		  output_feature[6]=feature6;
		  output_feature[7]=feature7;
		  output_feature[8]=feature8;
		  output_feature[9]=feature9;
		  output_feature[10]=feature10;	
		  output_feature[11]=feature11;
		  output_feature[12]=feature12;
		  output_feature[13]=feature13;
		  output_feature[14]=feature14;
		  output_feature[15]=feature15;
		  output_feature[16]=feature16;
		  output_feature[17]=feature17;
		  output_feature[18]=feature18;
		  output_feature[19]=feature19;
		  output_feature[20]=feature20;
		  output_feature[21]=feature21;
		  output_feature[22]=feature22;
		  output_feature[23]=feature23;
		  output_feature[24]=feature24;
		  output_feature[25]=feature25;
		  output_feature[26]=feature26;
		  output_feature[27]=feature27;
		  output_feature[28]=feature28;
		  output_feature[29]=feature29;
		  output_feature[30]=feature30;	  
		  ready_activation='1;
		end
	else if(flag1|flag2|flag3)
		begin
			$display("Running Error"); 
			output_feature='{30{16'bx}};
			ready_activation=0;
		end
	else
		begin
			output_feature='{30{16'b0}};
         ready_activation='0;
		end
	end
endmodule