module syn_fifo(input clk, input rst, wrt_en, rd_en,input [7:0]data_in, output empty, full,output reg [7:0]data_out);
  
  reg [7:0]mem[7:0]; //vector(width) and arrays(depth)
  reg [2:0] wr_ptr = 3'b000;
  reg [2:0] rd_ptr = 3'b000;
  
  assign full = ((wr_ptr + 1'b1)==rd_ptr);
  assign empty = (wr_ptr==rd_ptr);
                
  integer i;
  
  always@(posedge clk or negedge rst) begin //write operation
    if(!rst) begin
      wr_ptr<=0;
      for(i=0;i<8;i=i+1)
        mem[i]<=0;
    end
    
    else if(wrt_en && !full) begin  
      mem[wr_ptr]<=data_in;
      wr_ptr <= wr_ptr + 1;
    end
  end
  
  always@(posedge clk or negedge rst) begin  //read operation
      if(!rst) begin
        rd_ptr<=0;
        data_out<=0;
      end
      
    else if(rd_en && !empty) begin
        data_out<=mem[rd_ptr];
        rd_ptr<=rd_ptr + 1;
      end
  end
endmodule
