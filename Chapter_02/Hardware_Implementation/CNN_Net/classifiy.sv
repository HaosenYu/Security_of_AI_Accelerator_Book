module classify (input logic signed [15:0] input_feature [10:1],
						input logic clk,ready,n_reset,
						output logic [3:0]categories,
						output logic one_end);
reg signed [15:0] maximum[1:1];
always_comb
	begin
		if(input_feature[1]>input_feature[2])
			begin
				maximum[1]=input_feature[1];
			end
		else
			begin
				maximum[1]=input_feature[2];
			end
			
		if(maximum[1]<input_feature[3])
			maximum[1]=input_feature[3];
		else
			maximum[1]=maximum[1];
		
		if(maximum[1]<input_feature[4])
			maximum[1]=input_feature[4];
		else
			maximum[1]=maximum[1];
		
		if(maximum[1]<input_feature[5])
			maximum[1]=input_feature[5];
		else
			maximum[1]=maximum[1];	
			
		if(maximum[1]<input_feature[6])
			maximum[1]=input_feature[6];
		else
			maximum[1]=maximum[1];

		if(maximum[1]<input_feature[7])
			maximum[1]=input_feature[7];
		else
			maximum[1]=maximum[1];

		if(maximum[1]<input_feature[8])
			maximum[1]=input_feature[8];
		else
			maximum[1]=maximum[1];

		if(maximum[1]<input_feature[9])
			maximum[1]=input_feature[9];
		else
			maximum[1]=maximum[1];	
			
		if(maximum[1]<input_feature[10])
			maximum[1]=input_feature[10];
		else
			maximum[1]=maximum[1];		
			
	end
always_ff @ (posedge clk, negedge n_reset)
	begin
		if(!n_reset==1)
			begin
				categories<=0;
			end
		else
			begin
				if(ready==0)
					begin
						categories<=0;
						one_end<=0;
					end
				else
					begin
						one_end<=1;
						if(maximum[1]==input_feature[1])
							begin
								categories<=1;
							end
						else if(maximum[1]==input_feature[2])
							begin
								categories<=2;
							end
						else if(maximum[1]==input_feature[3])
							begin
								categories<=3;
							end
						else if(maximum[1]==input_feature[4])
							begin
								categories<=4;
							end
						else if(maximum[1]==input_feature[5])
							begin
								categories<=5;
							end
						else if(maximum[1]==input_feature[6])
							begin
								categories<=6;
							end
						else if(maximum[1]==input_feature[7])
							begin
								categories<=7;
							end
						else if(maximum[1]==input_feature[8])
							begin
								categories<=8;
							end
						else if(maximum[1]==input_feature[9])
							begin
								categories<=9;
							end
						else 
							begin
								categories<=10;
							end
					end
			end
	end
endmodule