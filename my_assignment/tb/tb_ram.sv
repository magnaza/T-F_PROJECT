`default_nettype none
`define EXIT_SUCCESS_ADDR 00ff2000

`include "utils.sv"

module tb_ram
#(
  parameter integer ADDRESS_WIDTH = 14 // 512kB
)(
  input   wire         clk,
  input   wire         data_req_i,        // Master -> Slave: New Request
  input   wire         data_we_i,         // Master -> Slave: Write Enable
  input   wire [ 3:0]  data_be_i,         // Master -> Slave: Write Byte Enable (Mask)
  input   wire [31:0]  data_addr_i,       // Master -> Slave: Address
  input   wire [31:0]  data_wdata_i,      // Master -> Slave: Write Data (1,2,4 Byte)
  input   wire [ 6:0]  data_wdata_intg_i, 

  input   wire         instr_req_i,
  input   wire [31:0]  instr_addr_i,

  output  wire         data_gnt_o,        // Slave -> Master: Grant Next Transaction (Ack)
  output  wire         data_rvalid_o,     // Slave -> Master: Response Valid
  output  wire [31:0]  data_rdata_o,      // Slave -> Master: Read Data (4 Byte)
  output  wire [ 6:0]  data_rdata_intg_o, // Slave -> Master: Read Data ECC
  output  wire         data_err_o,        // Slave -> Master: Error
  output  wire         exit_success,      // Slave -> TB: Address = 00ff2000

  output  wire         instr_gnt_o,
  output  wire         instr_rvalid_o,
  output  wire [31:0]  instr_rdata_o,
  output  wire [ 6:0]  instr_rdata_intg_o,
  output  wire         instr_err_o
);

  localparam mem_bytes_capacity = 2 ** ADDRESS_WIDTH;

  logic [ADDRESS_WIDTH-1:0] mem[mem_bytes_capacity];
  logic [ADDRESS_WIDTH-1:0] mem_iaddr_int, mem_daddr_int;

  always_comb mem_daddr_int = { data_addr_i[ADDRESS_WIDTH-1:2], 2'b00};  
  always_comb mem_iaddr_int = {instr_addr_i[ADDRESS_WIDTH-1:2], 2'b00}; 

  reg [31:0] data_rdata; 
  reg [31:0] instr_rdata;
  reg data_rvalid  = 1'b0;
  reg instr_rvalid = 1'b0; 

  always_ff @(posedge clk) begin 

    data_rvalid <= 0'b0;
    instr_rvalid <= 0'b0;
    // MEM
    if (data_req_i == 1'b1) begin 

      data_rvalid <= 1'b1;

      if (data_we_i == 1'b1) begin

        if ($test$plusargs("memory_debug")) begin 

          `MDBG({"[DRAM] Store, addr=0x", hex32_to_string(mem_daddr_int),
           ", data=0x", hex32_to_string(data_wdata_i),
           ", bytemask=0b", bin_to_string({data_be_i[3],data_be_i[2],data_be_i[1],data_be_i[0]})});

        end 

        if (data_be_i[0]) mem[mem_daddr_int    ] <= data_wdata_i[ 7: 0];
        if (data_be_i[1]) mem[mem_daddr_int + 1] <= data_wdata_i[15: 8];
        if (data_be_i[2]) mem[mem_daddr_int + 2] <= data_wdata_i[23:16];
        if (data_be_i[3]) mem[mem_daddr_int + 3] <= data_wdata_i[31:24];

      end else begin               

        if ($test$plusargs("memory_debug")) begin 

          `MDBG({"[DRAM] Load, addr=0x", hex32_to_string(mem_daddr_int),
           ", data=0x", hex32_to_string(data_wdata_i)});

        end 

        data_rdata[ 7: 0] <= mem[mem_daddr_int    ];
        data_rdata[15: 8] <= mem[mem_daddr_int + 1];
        data_rdata[23:16] <= mem[mem_daddr_int + 2];
        data_rdata[31:24] <= mem[mem_daddr_int + 3];

      end  

    end

    // FETCH 
    if (instr_req_i == 1'b1) begin 

      instr_rvalid <= 1'b1;

      if ($test$plusargs("memory_debug")) begin 

        `MDBG({"[IRAM] Fetch, addr=0x", hex32_to_string(mem_iaddr_int),
          ", data=0x", hex32_to_string(instr_rdata)});

      end 
        
      instr_rdata[ 7: 0] <= mem[mem_iaddr_int    ];
      instr_rdata[15: 8] <= mem[mem_iaddr_int + 1];
      instr_rdata[23:16] <= mem[mem_iaddr_int + 2];
      instr_rdata[31:24] <= mem[mem_iaddr_int + 3];

    end 

  end                          

  /* Exit success */
  reg exit_success_wire = 1'b0;
  always_ff@(posedge clk) begin 

    if (data_req_i == 1'b1) begin 

      if(data_addr_i == 32'h`EXIT_SUCCESS_ADDR) begin 

        exit_success_wire = 1'b1;

      end

    end 

  end

  assign exit_success = exit_success_wire; 

  assign instr_rvalid_o = instr_rvalid;
  assign data_rvalid_o  = data_rvalid;

  /* GRANT NEXT TRANSACTION SIGNALS FOLLOW REQUIREMENT SIGNAL */
  assign instr_gnt_o = instr_req_i; 
  assign data_gnt_o  = data_req_i;

  assign instr_rdata_o = instr_rdata; 
  assign data_rdata_o = data_rdata;

  assign data_err_o = 1'b0;        // never causes errors 
  assign instr_err_o = 1'b0;

  assign instr_rdata_intg_o = 6'h0; 
  assign data_rdata_intg_o = 6'h0; 

endmodule 


