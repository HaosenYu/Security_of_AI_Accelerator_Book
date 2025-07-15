module address_extract(input logic start,clk,n_reset,
								output logic [15:0]address);
reg [2:0] j;
reg [2:0] i;
reg [1:0] i_p;
reg [1:0] j_p;
reg [2:0] i_c;
reg [2:0] j_c;
reg [1:0] j_p2;
reg [1:0] i_p2;
reg [2:0] ki;
reg [2:0] kj;

always_ff @ (posedge clk,negedge n_reset)
begin
	if(!n_reset==1)
		begin
			i<=1;
			j<=0;
			i_p<=1;
			j_p<=1;
			i_c<=1;
			j_c<=1;
			j_p2<=1;
			i_p2<=1;
			ki<=1;
			kj<=1;
		end
	else
		begin
			if(start==1)
				begin
					if(j==5)
						begin
							j<=1;
							if(i==5)
								begin
									i<=1;
									if(j_p==2)
										begin
											j_p<=1;
											if(i_p==2)
												begin
													i_p<=1;
													if(j_c==5)
														begin
															j_c<=1;
															if(i_c==5)
																begin
																	i_c<=1;
																	if(j_p2==2)
																		begin
																			j_p2<=1;
																			if(i_p2==2)
																				begin
																					i_p2<=1;
																						if(kj==4)
																							begin
																								kj<=1;
																								if(ki==4)
																									begin
																										ki<=1;
																									end
																								else
																									begin
																										ki<=ki+1;
																									end
																							end
																						else
																							begin
																								kj<=kj+1;
																							end
																				end
																			else
																				begin
																					i_p2<=i_p2+1;
																				end
																		end
																	else
																		begin
																			j_p2<=j_p2+1;
																		end
																end
															else
																begin
																	i_c<=i_c+1;
																end
														end
													else
														begin
															j_c<=j_c+1;
														end
												end
											else
												begin
													i_p<=i_p+1;
												end
										end
									else
										begin
											j_p<=j_p+1;
										end
								end
							else
								begin
									i=i+1;
								end
						end
					else
						begin
							j<=j+1;
						end
				end
			else
				begin
					i<=1;
					j<=0;
					i_p<=1;
					j_p<=1;
					i_c<=1;
					j_c<=1;
					j_p2<=1;
					i_p2<=1;
					ki<=1;
					kj<=1;
				end				
		end
end

always_comb
	begin
		if(start==1)
			begin
				address=j+((j_p-1)+2*(j_c-1+j_p2-1+2*(kj-1)))+28*(i+((i_p-1)+2*(i_c-1+i_p2-1+2*(ki-1))-1));
			end
		else
			begin
				address=0;
			end
	end
	
endmodule