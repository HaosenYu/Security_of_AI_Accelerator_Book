module weight_ful2(input logic [4:0] count_2,input logic [3:0] count_1,
						 input logic flag_ful2,
						 output logic signed [15:0] weight_ful2);
reg signed [15:0] weight [300:0];
initial
	begin
		$readmemb("weight_ful2.txt", weight,299,0);
		weight[300]='0;
	end
	
always_comb
	begin
		if(flag_ful2==0)
			begin
				weight_ful2={16'b0};
			end
		else
			begin
				weight_ful2=weight[300-count_1-10*(count_2-1)];
			end
	end
endmodule