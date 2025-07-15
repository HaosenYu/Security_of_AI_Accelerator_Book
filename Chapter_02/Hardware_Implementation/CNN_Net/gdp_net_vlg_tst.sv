

`timescale 1 ps/ 1 ps
module gdp_net_vlg_tst();
logic signed [15:0] image_memory[783:0];
logic clk;
logic n_reset;
logic start;  
logic store;                                          
logic [3:0]  categories;
logic [3:0]	categories_store;
logic one_end;  
logic store_finish;  
logic signed [15:0] image_pixel;  
integer i;                  
gdp_net i1 (
	.clk(clk),
	.categories(categories),
	.n_reset(n_reset),
	.start(start),
	.one_end(one_end),
	.store(store),
	.store_finish(store_finish),
	.image_pixel(image_pixel)
	
);
initial                                                
begin                                                  
clk=0;
n_reset=0;
start=0;
store =0;
$readmemb("image1.txt", image_memory,783,0);
# 10 n_reset=1;                                                        
end  
initial begin
	 #10
    clk = 0;
    forever #5 clk = ~clk;  
end
initial begin
	n_reset=0;
	start=0;
	store =0;
	$readmemb("image1.txt", image_memory,783,0);
	# 10 n_reset=1;    
    forever begin
        #5; // 1
        #5;  // 0

        store = 1;
        for (i = 0; i <= 783; i = i + 1) begin
            image_pixel = image_memory[i];
            #5;  // 1
            #5; // 0
        end
		  wait (store_finish ==1)
        store = 0;
        start = 1;

        wait (one_end == 1);
		  categories_store=categories;
		  $display("Finished. Categories (dec): %0d", categories);
        n_reset = 0;
        start = 0;
        store = 0;
        #10; 
        $readmemb("image1.txt", image_memory, 783, 0);
        #10 n_reset = 1;
    end
end
                                                                                                   
endmodule

