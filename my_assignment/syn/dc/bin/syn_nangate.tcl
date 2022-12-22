set ROOT_PATH    ..
set RTL_PATH     $ROOT_PATH/../../rtl
set GATE_PATH    ../standalone
set LOG_PATH     ../log

set TECH         NangateOpenCellLibrary
set OPER_COND    typical

set TOPLEVEL     ibex_top

set search_path [ join "${ROOT_PATH}/techlib/ $search_path" ]
set search_path [ join "${ROOT_PATH}/../../rtl/  $search_path" ]
set search_path [ join "${ROOT_PATH}/../../vendor/lowrisc_ip/ip/prim/rtl/  $search_path" ]
set search_path [ join "${ROOT_PATH}/../../vendor/lowrisc_ip/ip/prim_generic/rtl/ $search_path" ]
set search_path [ join "${ROOT_PATH}/../../vendor/lowrisc_ip/dv/sv/dv_utils/  $search_path" ]
set search_path [ join "${ROOT_PATH}/../../dv/uvm/core_ibex/common/prim/ $search_path" ]

set synthetic_library dw_foundation.sldb
set target_library {NangateOpenCellLibrary_typical_ccs_scan.db}
set link_library [list $target_library $synthetic_library "*"]

# Prohibit the use of Latches 
set_dont_use "NangateOpenCellLibrary/DLH_X1"
set_dont_use "NangateOpenCellLibrary/DLH_X2"
set_dont_use "NangateOpenCellLibrary/DLL_X1"
set_dont_use "NangateOpenCellLibrary/DLL_X2"

set DFF_CELL DFF_X2
set LIB_DFF_D NangateOpenCellLibrary/DFF_X2/D

# ------------------------------------------------------------------------------- #
# Ordering of elaboration according to the ${RTL_PATH}/ibex_core.f file           #
# ------------------------------------------------------------------------------- #

analyze -format sverilog -work work ${RTL_PATH}/ibex_pkg.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_alu.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_compressed_decoder.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_controller.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_counter.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_csr.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_cs_registers.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_decoder.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_ex_block.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_id_stage.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_if_stage.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_wb_stage.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_load_store_unit.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_multdiv_slow.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_multdiv_fast.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_prefetch_buffer.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_fetch_fifo.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_register_file_ff.sv
analyze -format sverilog -work work ${RTL_PATH}/ibex_core.sv
analyze -format sverilog -work work -define QUESTASIM ${RTL_PATH}/ibex_top.sv

# ------------------------------------------------------------------------------- #
# Based on 'ibex_configs.yaml' this is the experimental-maxperf setup             #
# ----- ATTRIBUTES ------                                                         #
# Three-stage pipeline with additional branch traget ALU and 1 cycle multiplier   #
# (2 cycles for mulh) so mul does not stall (mulh stall 1 cycles). This is the    #
# maximum performance configuration.                                              #
# ------------------------------------------------------------------------------- #
set RV32E            0
set RV32M            3 
set RV32B            0 
set RegFile          0 
set BranchTargetALU  1
set WritebackStage   1
set ICache           0
set ICacheECC        0
set ICacheScramble   0
set BranchPredictor  0
set DbgTriggerEn     0
set SecureIbex       0
set PMPEnable        0
set PMPGranularity   0
set PMPNumRegions    4
set MHPMCounterNum   0
set MHPMCounterWidth 40

set PARAMETERS "RV32E=${RV32E},
RV32M=${RV32M},
RV32B=${RV32B},
RegFile=${RegFile},
BranchTargetALU=${BranchTargetALU},
WritebackStage=${WritebackStage},
ICache=${ICache},
ICacheECC=${ICacheECC},
ICacheScramble=${ICacheScramble},
BranchPredictor=${BranchPredictor},
DbgTriggerEn=${DbgTriggerEn},
SecureIbex=${SecureIbex},
PMPEnable=${PMPEnable},
PMPGranularity=${PMPGranularity},
PMPNumRegions=${PMPNumRegions},
MHPMCounterNum=${MHPMCounterNum},
MHPMCounterWidth=${MHPMCounterWidth}"

# ------------------------------------------------------------------------------- #
#  Elaborate, Clocks & Delays                                                     #
# ------------------------------------------------------------------------------- #
elaborate $TOPLEVEL -work work -parameters $PARAMETERS
link
uniquify
check_design 

set CLOCK_SPEED 2
create_clock  [get_ports clk_i] -period $CLOCK_SPEED -name REF_CLK

set core_outputs [all_outputs]
set core_inputs  [remove_from_collection [all_inputs] [get_ports clk_i]]
set core_inputs  [remove_from_collection $core_inputs [get_ports rst_ni]]

set INPUT_DELAY  [expr 0.4*$CLOCK_SPEED]
set OUTPUT_DELAY [expr 0.4*$CLOCK_SPEED]

set_input_delay  $INPUT_DELAY  $core_inputs  -clock [get_clock]
set_output_delay $OUTPUT_DELAY [all_outputs] -clock [get_clock]

set_operating_conditions $OPER_COND

# ------------------------------------------------------------------------------- #
#  Compile and Export                                                             #
# ------------------------------------------------------------------------------- #
compile_ultra -gate_clock -no_autoungroup

change_names -hierarchy -rules verilog
write -hierarchy -format verilog -output "${GATE_PATH}/${TOPLEVEL}.v"
write_sdf -version 3.0 "${GATE_PATH}/${TOPLEVEL}.sdf"
write -hierarchy -format ddc -output "${GATE_PATH}/${TOPLEVEL}.ddc"
write_sdc "${GATE_PATH}/${TOPLEVEL}.sdc"
write_test_protocol -output "${GATE_PATH}/${TOPLEVEL}.spf"
write_tmax_library -path "${GATE_PATH}"

quit 