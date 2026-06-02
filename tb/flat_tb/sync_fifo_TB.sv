module sync_fifo_TB;
  parameter DATA_WIDTH = 8;
  
  reg clk, rst_n;
  reg w_en, r_en;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  wire full, empty;
  
  reg [DATA_WIDTH-1:0] wdata_q[$], wdata;
  synchronous_fifo s_fifo(clk, rst_n, w_en, r_en, data_in, data_out, full, empty);
  always #5 clk = ~clk;
  
  initial begin
    clk = 1'b0; rst_n = 1'b0;
    w_en = 1'b0;
    r_en = 1'b0;
    data_in = 0;
    
    repeat(2) @(posedge clk);
    rst_n = 1'b1;
    #1;
    w_en = 1'b1;
    for(int i=0;i<8;i++) begin
      if(!full)
        begin
          data_in = $urandom;
          wdata_q.push_back(data_in);
          @(posedge clk); #1;
        end
      else
        $display("Skip Write because fifo is full");
    end
    @(posedge clk); #1; w_en = 1'b0;
      //inserting a small gap between write and read
      repeat(2) @(posedge clk);
      //read begins
  // first data_out now valid
    @(posedge clk); #1; r_en = 1'b1;
    @(posedge clk);#1;
    while(wdata_q.size() > 0) begin
      wdata = wdata_q.pop_front();
       if(data_out !== wdata)
         $error("FAIL: expected %h, got %h", wdata,data_out);
       else
         $display("PASS: data_out = %h", data_out);
      @(posedge clk); #1;
  end
  
 r_en = 1'b0;
  
 repeat(2) @(posedge clk);
 $finish;
 end
  
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
