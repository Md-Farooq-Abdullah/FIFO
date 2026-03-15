module tb_syn_fifo;
  
  reg clk=0;
  reg rst, wrt_en, rd_en;
  reg [7:0] data_in;
  wire [7:0] data_out;
  wire empty, full;
  
  always #5 clk=~clk;
  
  syn_fifo dut(.*);
  
  initial begin
    $dumpfile("syn_fifo.vcd");
    $dumpvars(0,tb_syn_fifo);
    rst = 0; wrt_en = 0; rd_en = 0; data_in = 0;
    
    #10 rst = 1;
    
    repeat(4) begin  //write operation
      @(posedge clk);
      wrt_en = 1;
      data_in = $random; //generates randomized data
    end
    wrt_en = 0;
    
    repeat(4) begin //read operation
      @(posedge clk);
      rd_en=1;
    end
    rd_en=0;
    
    #20 $finish;
  end
  
endmodule
