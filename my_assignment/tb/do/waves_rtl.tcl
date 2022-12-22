set NoQuitOnFinish 1
set TOP_LEVEL /tb_top

set I_MEMORY [concat [find signals sim:$TOP_LEVEL/ram/instr*_i] [find signals sim:$TOP_LEVEL/ram/instr*_o]]
set D_MEMORY [concat [find signals sim:$TOP_LEVEL/ram/data*_i] [find signals sim:$TOP_LEVEL/ram/data*_o]]
set TRACER   [concat [find signals sim:$TOP_LEVEL/tracer/*]]
set IF       [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/if_stage_i/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/if_stage_i/*_o]]
set IF_CDEC  [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/if_stage_i/compressed_decoder_i/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/if_stage_i/compressed_decoder_i/*_o]]
set IF_PREF  [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/if_stage_i/gen_prefetch_buffer/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/if_stage_i/gen_prefetch_buffer/*_o]]
set ID       [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/id_stage_i/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/id_stage_i/*_o]]
set ID_DEC   [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/id_stage_i/decoder_i/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/id_stage_i/decoder_i/*_o]]
set ID_CONTR [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/id_stage_i/controller_i/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/id_stage_i/controller_i/*_o]]
set ID_STALL [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/id_stage_i/gen_stall_mem/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/id_stage_i/gen_stall_mem/*_o]]
set EX       [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/ex_block_i/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/ex_block_i/*_o]]
set EX_ALU   [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/ex_block_i/alu_i/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/ex_block_i/alu_i/*_o]]
set LSU      [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/load_store_unit_i/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/load_store_unit_i/*_o]]
set WB       [concat [find signals sim:$TOP_LEVEL/dut/u_ibex_core/wb_stage_i/*_i] [find signals sim:$TOP_LEVEL/dut/u_ibex_core/wb_stage_i/*_o]]

###################### PIPELINE CONTROL #######################

add wave -group PIPELINE\ CONTROL -label CLOCK   -color green $TOP_LEVEL/clk
add wave -group PIPELINE\ CONTROL -label RESET_N -color green $TOP_LEVEL/reset_n
add wave -group PIPELINE\ CONTROL -label EXIT_OK -color green $TOP_LEVEL/exit_success
add wave -group PIPELINE\ CONTROL -label IF_PC   -color green $TOP_LEVEL/dut/u_ibex_core/if_stage_i/pc_if_o
add wave -group PIPELINE\ CONTROL -label ID_PC   -color green $TOP_LEVEL/dut/u_ibex_core/if_stage_i/pc_id_o

###################### TRACER #######################
add wave -divider TRACER 
foreach sig $TRACER {
    add wave -group TRACER -label [file tail $sig] -color magenta $sig
}

###################### REGISTER FILE #######################
add wave -divider REGISTER\ FILE 
add wave -group REGISTER\ FILE -color cyan -label \[r1\]\ ra\ Return\ Address\ Reg {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[1]/*}
add wave -group REGISTER\ FILE -color cyan -label \[r2\]\ sp\ Stack\ Pointer\ Reg  {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[2]/*}
add wave -group REGISTER\ FILE -color cyan -label \[r3\]\ gp\ Global\ Pointer\ Reg {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[3]/*}
add wave -group REGISTER\ FILE -color cyan -label \[r4\]\ tp\ Thread\ Pointer\ Reg {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[4]/*}
add wave -group REGISTER\ FILE -group TEMP\ REGS -color cyan -label \[r5\]\ t0\ Temp\ Reg\ 0 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[5]/*}
add wave -group REGISTER\ FILE -group TEMP\ REGS -color cyan -label \[r6\]\ t1\ Temp\ Reg\ 1 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[6]/*}
add wave -group REGISTER\ FILE -group TEMP\ REGS -color cyan -label \[r7\]\ t2\ Temp\ Reg\ 2 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[7]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r8\]\ s0\ Saved\ Reg\ 1 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[8]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r9\]\ s1\ Saved\ Reg\ 2 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[9]/*}
add wave -group REGISTER\ FILE -group ARG\ REGS -color cyan -label \[r10\]\ a0\ Arg\ Reg\ 0 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[10]/*}
add wave -group REGISTER\ FILE -group ARG\ REGS -color cyan -label \[r11\]\ a1\ Arg\ Reg\ 1 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[11]/*}
add wave -group REGISTER\ FILE -group ARG\ REGS -color cyan -label \[r12\]\ a2\ Arg\ Reg\ 2 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[12]/*}
add wave -group REGISTER\ FILE -group ARG\ REGS -color cyan -label \[r13\]\ a3\ Arg\ Reg\ 3 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[13]/*}
add wave -group REGISTER\ FILE -group ARG\ REGS -color cyan -label \[r14\]\ a4\ Arg\ Reg\ 4 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[14]/*}
add wave -group REGISTER\ FILE -group ARG\ REGS -color cyan -label \[r15\]\ a5\ Arg\ Reg\ 5 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[15]/*}
add wave -group REGISTER\ FILE -group ARG\ REGS -color cyan -label \[r16\]\ a6\ Arg\ Reg\ 6 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[16]/*}
add wave -group REGISTER\ FILE -group ARG\ REGS -color cyan -label \[r17\]\ a7\ Arg\ Reg\ 7 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[17]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r18\]\ s2\ Saved\ Reg\ 2  {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[18]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r19\]\ s3\ Saved\ Reg\ 3 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[19]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r20\]\ s4\ Saved\ Reg\ 4 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[20]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r21\]\ s5\ Saved\ Reg\ 5 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[21]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r22\]\ s6\ Saved\ Reg\ 6 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[22]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r23\]\ s7\ Saved\ Reg\ 7 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[23]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r24\]\ s8\ Saved\ Reg\ 8 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[24]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r25\]\ s9\ Saved\ Reg\ 9 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[25]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r26\]\ s10\ Saved\ Reg\ 10  {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[26]/*}
add wave -group REGISTER\ FILE -group SAVED\ REGS -color cyan -label \[r27\]\ s11\ Saved\ Reg\ 11 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[27]/*}
add wave -group REGISTER\ FILE -group TEMP\ REGS -color cyan -label \[r28\]\ t3\ Temp\ Reg\ 3 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[28]/*}
add wave -group REGISTER\ FILE -group TEMP\ REGS -color cyan -label \[r29\]\ t4\ Temp\ Reg\ 4 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[29]/*}
add wave -group REGISTER\ FILE -group TEMP\ REGS -color cyan -label \[r30\]\ t5\ Temp\ Reg\ 5 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[30]/*}
add wave -group REGISTER\ FILE -group TEMP\ REGS -color cyan -label \[r31\]\ t6\ Temp\ Reg\ 6 {sim:/tb_top/dut/gen_regfile_ff/register_file_i/g_rf_flops[31]/*}

add wave -divider RAM
foreach sig $I_MEMORY {
    add wave -group RAM -group i_ram -label [file tail $sig] -color yellow $sig
}

foreach sig $D_MEMORY {
    add wave -group RAM -group d_ram -label [file tail $sig] -color orange $sig
}

###################### CORE #######################
add wave -divider IBEX\ CORE
   
    ###################### IF #######################

    foreach sig $IF {
        add wave -group IBEX -group IF -label [file tail $sig] -color green $sig 
    }

    foreach sig $IF_PREF {
        add wave -group IBEX -group IF -group PREFETCH\ BUFFER -label [file tail $sig] -color green $sig 
    }
    
    foreach sig $IF_CDEC {
        add wave -group IBEX -group IF -group COMPRESSED\ DECODER -label [file tail $sig] -color green $sig 
    }

    ###################### ID #######################

    foreach sig $ID {
        add wave -group IBEX -group ID -label [file tail $sig] -color green $sig 
    }

    foreach sig $ID_DEC {
        add wave -group IBEX -group ID -group DECODER -label [file tail $sig] -color green $sig 
    }

    foreach sig $ID_CONTR {
        add wave -group IBEX -group ID -group CONTROLLER -label [file tail $sig] -color green $sig 
    }

    foreach sig $ID_STALL {
        add wave -group IBEX -group ID -group STALLS -label [file tail $sig] -color green $sig 
    }

    ###################### EX #######################

    foreach sig $EX {
        add wave -group IBEX -group EX -label [file tail $sig] -color green $sig 
    }

    foreach sig $EX_ALU {
        add wave -group IBEX -group EX -group ALU -label [file tail $sig] -color green $sig 
    }

    ###################### LSU #######################

    foreach sig $LSU {
        add wave -group IBEX -group LSU -label [file tail $sig] -color green $sig 
    }

    ###################### WB #######################

    foreach sig $WB {
        add wave -group IBEX -group WB -label [file tail $sig] -color green $sig 

    }   