module weight_ful1(input logic [4:0] count_ful,input logic [4:0] count_finish,
						 output logic signed [15:0] weight_ful1[3:1]);
reg signed [15:0] weight [1440:0];
initial
	begin
		$readmemb("weight_ful.txt", weight,1439,0);
		weight[1440]='0;
	end 
always_comb
	begin
		if(count_ful==0)
			begin
				weight_ful1='{3{16'b0}};
			end
		else
			begin
				weight_ful1[3]=weight[1440-960-(count_finish-1)*30-count_ful];
				weight_ful1[2]=weight[1440-480-(count_finish-1)*30-count_ful];
				weight_ful1[1]=weight[1440-(count_finish-1)*30-count_ful];
			end
	end
endmodule