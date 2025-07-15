module image_read(input logic [15:0] address,
						input logic clk,n_reset,start,store,
						input logic signed [15:0] image_pixel,
						output logic signed [15:0] input_feature,
						output logic store_finish,
						output logic ready_in);

logic signed [15:0] image_memory [784:0];
logic signed [15:0] feature;
logic [15:0] count=0;
logic [1:0]flag;
integer i;
//initial
//	begin
//		$readmemb("image1.txt", image_memory,783,0);
//		image_memory[784]='0;
//	end
//					

always_ff @ (posedge clk, negedge n_reset)
	begin
		if(!n_reset==1)
			begin
				feature<=0;
				ready_in<=0;
				store_finish<=0;
				flag = 0;
				for (i = 0; i <= 784; i = i + 1)
					image_memory[i]='0;
			end
		else
		begin
			i<=0;
			if(store)
				begin
					if(count<16'd783)
						begin
							flag =1;
							image_memory[count]<= image_pixel;
							count <= count+1;
							store_finish<=0;
						end
					else
						begin
							flag = 2;
							count<=0;
							store_finish<=1;
						end
					
				end
			else
				begin
					feature<=image_memory[784-address];
					if(address==0)
						begin
						  ready_in<=0;
						end
					else
						begin
							ready_in<=1;
						end				
				end
		end
	end

always_comb
	begin
		if(start==1)
			begin
				input_feature=feature;
			end
		else
			begin
				input_feature=0;
			end
	end
endmodule