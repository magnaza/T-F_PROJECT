
//  Three-stage pipeline with additional branch traget ALU and 1 cycle multiplier
//  (2 cycles for mulh) so mul does not stall (mulh stall 1 cycles). This is the
//  maximum performance configuration.
// 
//  Author: Nikos Deligiannis 
//

`include "utils.sv"

`timescale 1ns/1ps 

module tb_top ();

    const time CLK_PHASE_HI       = 5ns;
    const time CLK_PHASE_LO       = 5ns;
    const time CLK_PERIOD         = CLK_PHASE_HI + CLK_PHASE_LO;
    const int  RESET_WAIT_CYCLES  = 100;

    const int I_RAM_LO            = 32'h00000080;
    const int I_RAM_HI            = 32'h00030080;
    const int D_RAM_LO            = 32'h00030080;
    const int D_RAM_HI            = 32'h00040080;    

    logic exit_success = 0;

    /* Set timing formats. See: https://gist.github.com/morganp/1149187/a22c0aca6add2d8427f7312eabf619721b6c9e6c */
    initial begin : timing_format
        $timeformat(-9, 0, "ns", 9); // -9 = 1ns
    end           : timing_format

    /* Clock */
    logic clk = 1;
    initial begin : clock_generation
        
        forever begin
            #CLK_PHASE_HI clk = 1'b0;
            #CLK_PHASE_LO clk = 1'b1;
        end

    end           : clock_generation

    /* Activate reset for clock cycles */
    logic reset_n = 0;
    initial begin : reset_activation

        if ( $test$plusargs("verbose")) 
            `INFO( {"Activating reset for ", int_to_string(RESET_WAIT_CYCLES)," clock cycles."} )
				
	    repeat (RESET_WAIT_CYCLES) @(posedge clk);
	    reset_n <= 1;

	    if ( $test$plusargs("verbose"))
            `INFO("Deactivating reset.")
    
    end           : reset_activation 
    
    /* Generate a vcd dump */
    initial begin : vcd_dump

		automatic string vcd_filename;

        if ($value$plusargs("vcd=%s",vcd_filename)) begin

            if ($test$plusargs("verbose"))
                `INFO({"Producing VCD file ", vcd_filename, "."})
            
            $dumpfile(vcd_filename);
            $dumpvars(0, tb_top.dut);

        end
    end           : vcd_dump

    /* Loads the specified .hex file to the TB memory */
    initial begin  : load_sbst

        automatic string firmware;

        if($value$plusargs("firmware=%s", firmware)) begin

            if($test$plusargs("verbose")) 
                `INFO({"Loading SBST firmware to RAM '", firmware,"'"})
           
            $readmemh(firmware, ram.mem);

        end else begin

            `ERROR("SBST firmware not specified! Exiting...")            
            $finish;

	    end
    end            : load_sbst

    logic instr_req_dut_mem;
    logic instr_gnt_mem_dut;
    logic instr_rvalid_mem_dut;
    logic instr_err_mem_dut;
    logic [31:0] instr_addr_dut_mem;
    logic [31:0] instr_rdata_mem_dut;
    logic [ 6:0] instr_rdata_intg_mem_dut;

    logic data_req_dut_mem;
    logic data_gnt_mem_dut;
    logic data_rvalid_mem_dut;
    logic data_we_dut_mem;
    logic data_err_mem_dut;
    logic [ 3:0] data_be_dut_mem;
    logic [31:0] data_addr_dut_mem;
    logic [31:0] data_wdata_dut_mem;
    logic [ 6:0] data_wdata_intg_dut_mem;
    logic [31:0] data_rdata_mem_dut;
    logic [ 6:0] data_rdata_intg_mem_dut;

    always_ff @(posedge clk) begin : exit_success_check

        if(exit_success == 1'b1) begin 
            `SUCCESS("Exit Success!");
            $finish;
        end 
    end                            : exit_success_check

`ifdef RVFI 
    logic                         rvfi_valid;
    logic [63:0]                  rvfi_order;
    logic [31:0]                  rvfi_insn;
    logic                         rvfi_trap;
    logic                         rvfi_halt;
    logic                         rvfi_intr;
    logic [ 1:0]                  rvfi_mode;
    logic [ 1:0]                  rvfi_ixl;
    logic [ 4:0]                  rvfi_rs1_addr;
    logic [ 4:0]                  rvfi_rs2_addr;
    logic [ 4:0]                  rvfi_rs3_addr;
    logic [31:0]                  rvfi_rs1_rdata;
    logic [31:0]                  rvfi_rs2_rdata;
    logic [31:0]                  rvfi_rs3_rdata;
    logic [ 4:0]                  rvfi_rd_addr;
    logic [31:0]                  rvfi_rd_wdata;
    logic [31:0]                  rvfi_pc_rdata;
    logic [31:0]                  rvfi_pc_wdata;
    logic [31:0]                  rvfi_mem_addr;
    logic [ 3:0]                  rvfi_mem_rmask;
    logic [ 3:0]                  rvfi_mem_wmask;
    logic [31:0]                  rvfi_mem_rdata;
    logic [31:0]                  rvfi_mem_wdata;
`endif 

/*
 *      _       _   
 *     | |     | |  
 *   __| |_   _| |_ 
 *  / _` | | | | __|
 * | (_| | |_| | |_ 
 *  \__,_|\__,_|\__|
 *                  
 */                  
    ibex_top 
    dut 
    (   .clk_i                  (clk                     ),    
        .rst_ni                 (reset_n                 ),
    
        .test_en_i              (1'b0                    ),
        .scan_rst_ni            (1'b1                    ),

        .ram_cfg_i              (10'b0                   ),
        .hart_id_i              (32'h0                   ),
        .boot_addr_i            (32'h0000_0000           ),

        .instr_req_o            (instr_req_dut_mem       ),
        .instr_gnt_i            (instr_gnt_mem_dut       ),
        .instr_rvalid_i         (instr_rvalid_mem_dut    ),
        .instr_addr_o           (instr_addr_dut_mem      ),
        .instr_rdata_i          (instr_rdata_mem_dut     ),
        .instr_rdata_intg_i     (instr_rdata_intg_mem_dut),
        .instr_err_i            (instr_err_mem_dut       ),

        .data_req_o             (data_req_dut_mem        ),
        .data_gnt_i             (data_gnt_mem_dut        ),
        .data_rvalid_i          (data_rvalid_mem_dut     ),
        .data_we_o              (data_we_dut_mem         ),
        .data_be_o              (data_be_dut_mem         ),
        .data_addr_o            (data_addr_dut_mem       ),
        .data_wdata_o           (data_wdata_dut_mem      ),
        .data_wdata_intg_o      (data_wdata_intg_dut_mem ),
        .data_rdata_i           (data_rdata_mem_dut      ),
        .data_rdata_intg_i      (data_rdata_intg_mem_dut ),
        .data_err_i             (data_err_mem_dut        ),

`ifdef RVFI 
        .rvfi_valid             ( rvfi_valid             ),
        .rvfi_order             ( rvfi_order             ),
        .rvfi_insn              ( rvfi_insn              ),
        .rvfi_trap              ( rvfi_trap              ),
        .rvfi_halt              ( rvfi_halt              ),
        .rvfi_intr              ( rvfi_intr              ),
        .rvfi_mode              ( rvfi_mode              ),
        .rvfi_ixl               ( rvfi_ixl               ),
        .rvfi_rs1_addr          ( rvfi_rs1_addr          ),
        .rvfi_rs2_addr          ( rvfi_rs2_addr          ),
        .rvfi_rs3_addr          ( rvfi_rs3_addr          ),
        .rvfi_rs1_rdata         ( rvfi_rs1_rdata         ),
        .rvfi_rs2_rdata         ( rvfi_rs2_rdata         ),
        .rvfi_rs3_rdata         ( rvfi_rs3_rdata         ),
        .rvfi_rd_addr           ( rvfi_rd_addr           ),
        .rvfi_rd_wdata          ( rvfi_rd_wdata          ),
        .rvfi_pc_rdata          ( rvfi_pc_rdata          ),
        .rvfi_pc_wdata          ( rvfi_pc_wdata          ),
        .rvfi_mem_addr          ( rvfi_mem_addr          ),
        .rvfi_mem_rmask         ( rvfi_mem_rmask         ),
        .rvfi_mem_wmask         ( rvfi_mem_wmask         ),
        .rvfi_mem_rdata         ( rvfi_mem_rdata         ),
        .rvfi_mem_wdata         ( rvfi_mem_wdata         ),
`endif

        .irq_software_i         (1'b0                    ),
        .irq_timer_i            (1'b0                    ),
        .irq_external_i         (1'b0                    ),
        .irq_fast_i             (15'b0                   ),
        .irq_nm_i               (1'b0                    ),

        .scramble_key_valid_i   (1'b0                    ),
        .scramble_key_i         (128'b0                  ),
        .scramble_nonce_i       (64'b0                   ),
        .scramble_req_o         (                        ),
  
        .debug_req_i            (1'b0                    ),
        .crash_dump_o           (                        ),
        .double_fault_seen_o    (                        ),
        .fetch_enable_i         (4'b0101                 ),
        .alert_minor_o          (                        ),
        .alert_major_internal_o (                        ),
        .alert_major_bus_o      (                        ),
        .core_sleep_o           (                        )
    );

/*
 *  _ __ ___   ___ _ __ ___  
 * | '_ ` _ \ / _ \ '_ ` _ \ 
 * | | | | | |  __/ | | | | |
 * |_| |_| |_|\___|_| |_| |_|
 *
 */
    tb_ram 
    ram 
    (
        .clk (clk),
        
        .data_req_i          (data_req_dut_mem        ),
        .data_we_i           (data_we_dut_mem         ),
        .data_be_i           (data_be_dut_mem         ),
        .data_addr_i         (data_addr_dut_mem       ),
        .data_wdata_i        (data_wdata_dut_mem      ),
        .data_wdata_intg_i   (data_wdata_intg_dut_mem ),
        .instr_req_i         (instr_req_dut_mem       ),
        .instr_addr_i        (instr_addr_dut_mem      ),

        .data_gnt_o          (data_gnt_mem_dut        ),
        .data_rvalid_o       (data_rvalid_mem_dut     ),
        .data_rdata_o        (data_rdata_mem_dut      ),
        .data_rdata_intg_o   (data_rdata_intg_mem_dut ),
        .data_err_o          (data_err_mem_dut        ),
        .exit_success        (exit_success            ),

        .instr_gnt_o         (instr_gnt_mem_dut       ),
        .instr_rvalid_o      (instr_rvalid_mem_dut    ),
        .instr_rdata_o       (instr_rdata_mem_dut     ),
        .instr_rdata_intg_o  (instr_rdata_intg_mem_dut),
        .instr_err_o         (instr_err_mem_dut       )
    );

/*
 *  _                           
 * | |                          
 * | |_ _ __ __ _  ___ ___ _ __ 
 * | __| '__/ _` |/ __/ _ \ '__|
 * | |_| | | (_| | (_|  __/ |   
 *  \__|_|  \__,_|\___\___|_|   
 *                                                  
 */
`ifdef RVFI
    ibex_tracer
    tracer 
    (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .hart_id_i(32'b0),
        .rvfi_valid(rvfi_valid),
        .rvfi_order(rvfi_order),
        .rvfi_insn(rvfi_insn),
        .rvfi_trap(rvfi_trap),
        .rvfi_halt(rvfi_halt),
        .rvfi_intr(rvfi_intr),
        .rvfi_mode(rvfi_mode),
        .rvfi_ixl(rvfi_ixl),
        .rvfi_rs1_addr(rvfi_rs1_addr),
        .rvfi_rs2_addr(rvfi_rs2_addr),
        .rvfi_rs3_addr(rvfi_rs3_addr),
        .rvfi_rs1_rdata(rvfi_rs1_rdata),
        .rvfi_rs2_rdata(rvfi_rs2_rdata),
        .rvfi_rs3_rdata(rvfi_rs3_rdata),
        .rvfi_rd_addr(rvfi_rd_addr),
        .rvfi_rd_wdata(rvfi_rd_wdata),
        .rvfi_pc_rdata(rvfi_pc_rdata),
        .rvfi_pc_wdata(rvfi_pc_wdata),
        .rvfi_mem_addr(rvfi_mem_addr),
        .rvfi_mem_rmask(rvfi_mem_rmask),
        .rvfi_mem_wmask(rvfi_mem_wmask),
        .rvfi_mem_rdata(rvfi_mem_rdata),
        .rvfi_mem_wdata(rvfi_mem_wdata)
    );
`endif

/*
 *                          _   _                 
 *                         | | (_)                
 *   __ _ ___ ___  ___ _ __| |_ _  ___  _ __  ___ 
 *  / _` / __/ __|/ _ \ '__| __| |/ _ \| '_ \/ __|
 * | (_| \__ \__ \  __/ |  | |_| | (_) | | | \__ \
 *  \__,_|___/___/\___|_|   \__|_|\___/|_| |_|___/
 *                                                                                              
 */
    reg [31:0] data_addr_reg; 
    always_ff @(posedge clk)
        data_addr_reg <= data_addr_dut_mem;

    property invalid_ram_access;
        @(posedge clk) disable iff(!reset_n)
            (data_req_dut_mem & data_we_dut_mem) |-> (data_addr_dut_mem >= D_RAM_LO);
    endproperty 

    InvalidInstrRamAccess : assert property(invalid_ram_access) else begin 
        `ERROR({"You are trying to overwrite content in the instruction memory at address 0x",hex32_to_string(data_addr_reg)});
        $finish;
    end 

    reg [31:0] instr_addr_reg; 
    always_ff @(posedge clk) 
        instr_addr_reg <= instr_addr_dut_mem;

    property invalid_pc; 

        @(posedge clk) disable iff(!reset_n) 

            (instr_addr_dut_mem >= I_RAM_LO) & (instr_addr_dut_mem < I_RAM_HI);

    endproperty 

    InvalidPcValue : assert property(invalid_pc) else begin 
        `ERROR({"Program counter got a value (0x", hex32_to_string(instr_addr_reg),") that is outside the bounds of instruction ram"});
        $finish; 
    end 

endmodule 