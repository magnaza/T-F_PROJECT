ROOT_PATH = $(shell pwd)
FIRMWARE  = 0
VCD       = 0
MEMDEBUG  = "+no_memory_debug"

help::

	@printf "\033[1mTestbench Compilation\033[0m\n"
	@printf "\033[31m\tcompile/questa/rtl\033[39m Compiles the RTL testbench of ibex core for QuestaSIM (with tracer) \n"
	@printf "\033[31m\tcompile/questa/gate\033[39m Compiles the Gate-Level testbench of ibex core for QuestaSIM (without tracer)\n"
	@printf "\033[31m\tcompile/zoix\033[39m Compiles the Gate-Level of ibex core along with the strobe module for Z01X fault simulation\n"
	@printf "\033[1mCross Compilation\033[0m\n"
	@printf "\033[31m\txcompile\033[39m Cross-compiles all the .S files under the $(CURDIR)/sbst directory.\n"
	@printf "\033[1mLogic Simulation\033[0m\n"
	@printf "\033[31m\tlsim/rtl/nogui FIRMWARE=... [MEMDEBUG=\"+memory_debug\"]\033[39m Invokes QuestaSIM for a RTL simulation for the .hex FIRMWARE in shell mode. Can optionally enable memory debug. \n"
	@printf "\033[31m\tlsim/rtl/gui FIRMWARE=... [MEMDEBUG=\"+memory_debug\"]\033[39m Invokes QuestaSIM for a RTL simulation for the .hex FIRMWARE in gui mode. Can optionally enable memory debug. \n"
	@printf "\033[31m\tlsim/gate/nogui FIRMWARE=... [MEMDEBUG=\"+memory_debug\"]\033[39m Invokes QuestaSIM for a Gate-Level simulation for the .hex FIRMWARE in shell mode. Can optionally enable memory debug. \n"
	@printf "\033[31m\tlsim/gate/gui FIRMWARE=... [MEMDEBUG=\"+memory_debug\"]\033[39m Invokes QuestaSIM for a Gate-Level simulation for the .hex FIRMWARE in gui mode. Can optionally enable memory debug. \n"
	@printf "\033[1mFault Simulation\033[0m\n"
	@printf "\033[31m\tfsim/zoix/fgen\033[39m Invokes the Z01X fault manager to generate the Stuck-At fault list for the whole core\n"
	@printf "\033[31m\tfsim/zoix/lsim VCD=...\033[39m Invokes the Z01X logic simulator to validate the VCD file that will be used as stimulus\n"
	@printf "\033[31m\tfsim/zoix/fsim VCD=...\033[39m Invokes the Z01X fault simulator for the Stuck-At fault model using VCD as test stimulus\n"	
	@printf "\033[1mSynthesis\033[0m\n"
	@printf "\033[31m\tsynthesis/nangate45\033[39m Invokes Synopsys Design Compiler to synthesize the ibex core (ibex_top.sv) using NanGate45nm technology library\n"
	@printf "\033[1mMisc\033[0m\n"
	@printf "\033[31m\thelp\033[39m Display this message and exit\n"
	@printf "\033[31m\tclean\033[39m Clean synthesis, simulation and cross-compilation directories\n"
	@printf "\033[31m\ttarball\033[39m Create a tarball of the current archive on the parental directory\n"
	@printf "\n"


compile/questa/rtl:

	mkdir -p $(ROOT_PATH)/run && \
    cd $(ROOT_PATH)/run && \
    rm -rf work_rtl 2>/dev/null && \
    vlib work_rtl &&\
    vlog \
    -work work_rtl -sv -incr -suppress 2583 -cover t \
    +acc=rnbpc \
	+incdir+$(ROOT_PATH)/tb \
    +incdir+$(ROOT_PATH)/rtl \
    +incdir+$(ROOT_PATH)/vendor/lowrisc_ip/ip/prim/rtl \
    +incdir+$(ROOT_PATH)/vendor/lowrisc_ip/ip/prim_generic/rtl \
    +incdir+$(ROOT_PATH)/vendor/lowrisc_ip/dv/sv/dv_utils/ \
    +incdir+$(ROOT_PATH)/dv/uvm/core_ibex/common/prim \
    +define+QUESTASIM \
    +define+RVFI \
    $(ROOT_PATH)/rtl/ibex_pkg.sv \
    $(ROOT_PATH)/rtl/ibex_alu.sv \
    $(ROOT_PATH)/rtl/ibex_compressed_decoder.sv \
    $(ROOT_PATH)/rtl/ibex_controller.sv \
    $(ROOT_PATH)/rtl/ibex_counter.sv \
    $(ROOT_PATH)/rtl/ibex_csr.sv \
    $(ROOT_PATH)/rtl/ibex_cs_registers.sv \
    $(ROOT_PATH)/rtl/ibex_decoder.sv \
    $(ROOT_PATH)/rtl/ibex_ex_block.sv \
    $(ROOT_PATH)/rtl/ibex_id_stage.sv \
    $(ROOT_PATH)/rtl/ibex_if_stage.sv \
    $(ROOT_PATH)/rtl/ibex_wb_stage.sv \
    $(ROOT_PATH)/rtl/ibex_load_store_unit.sv \
    $(ROOT_PATH)/rtl/ibex_multdiv_slow.sv \
    $(ROOT_PATH)/rtl/ibex_multdiv_fast.sv \
    $(ROOT_PATH)/rtl/ibex_prefetch_buffer.sv \
    $(ROOT_PATH)/rtl/ibex_fetch_fifo.sv \
    $(ROOT_PATH)/rtl/ibex_register_file_ff.sv \
    $(ROOT_PATH)/rtl/ibex_core.sv \
    $(ROOT_PATH)/rtl/ibex_top.sv \
    $(ROOT_PATH)/rtl/ibex_tracer.sv \
    $(ROOT_PATH)/tb/tb_ram.sv \
    $(ROOT_PATH)/tb/tb_top.sv && \
    vopt -work work_rtl -debugdb -fsmdebug "+acc=rnbpc" tb_top -o tb_rtl_top_vopt

compile/questa/gate:

	mkdir -p $(ROOT_PATH)/run && \
    cd $(ROOT_PATH)/run && \
    rm -rf work_gate 2>/dev/null && \
    vlib work_gate &&\
	vlog -work work_gate +define+functional $(ROOT_PATH)/syn/dc/techlib/NangateOpenCellLibrary.v && \
    vlog \
    -work work_gate -sv -incr -suppress 2583 -cover t \
    +acc=rnbpc \
    +incdir+{$root_dir}/rtl \
    +incdir+$(ROOT_PATH)/vendor/lowrisc_ip/ip/prim/rtl \
    +incdir+$(ROOT_PATH)/vendor/lowrisc_ip/ip/prim_generic/rtl \
    +incdir+$(ROOT_PATH)/vendor/lowrisc_ip/dv/sv/dv_utils/ \
    +incdir+$(ROOT_PATH)/dv/uvm/core_ibex/common/prim \
    +define+QUESTASIM \
    $(ROOT_PATH)/syn/dc/standalone/ibex_top.v \
    $(ROOT_PATH)/tb/tb_ram.sv \
    $(ROOT_PATH)/tb/tb_top.sv && \
    vopt -work work_gate -debugdb -fsmdebug "+acc=rnbpc" tb_top -o tb_gate_top_vopt

compile/zoix:

	mkdir -p $(ROOT_PATH)/run/zoix_fsim && \
	cd $(ROOT_PATH)/run/zoix_fsim && \
	export ROOT_DIR=$(ROOT_PATH) && \
	zoix \
	+sv +define+functional \
	+top+ibex_top+strobe \
	-l z_compile.log \
	-portfaults \
	-f $(ROOT_PATH)/zoix/zoix_read_design.f \
	$(ROOT_PATH)/zoix/strobe.sv

xcompile:

	make --directory $(ROOT_PATH)/sbst 

lsim/rtl/nogui: 

ifeq ($(FIRMWARE),0)
	@printf "\033[31mYou must define a firmware (.hex) file! Usage: make sim/rtl/nogui FIRMWARE=sbst/your_file.hex\033[39m\n"
	@exit 1
endif 

	cd $(ROOT_PATH)/run && \
	vsim -c \
	-quiet -suppress 3839 -work work_rtl \
	"+verbose" \
	$(MEMDEBUG) \
	"+firmware=$(ROOT_PATH)/$(FIRMWARE)" \
	"+vcd=$(ROOT_PATH)/run/rtl_tb_top_vcd.vcd" \
	"+ibex_tracer_enable" \
	tb_rtl_top_vopt \
	-do "run -all"

lsim/rtl/gui:

ifeq ($(FIRMWARE),0)
	@printf "\033[31mYou must define a firmware (.hex) file! Usage: make sim/rtl/gui FIRMWARE=sbst/your_file.hex\033[39m\n"
	@exit 1
endif 

	cd $(ROOT_PATH)/run && \
	vsim -gui \
	-quiet -suppress 3839 -work work_rtl \
	"+verbose" \
	$(MEMDEBUG) \
	"+firmware=$(ROOT_PATH)/$(FIRMWARE)" \
	"+vcd=$(ROOT_PATH)/run/rtl_tb_top_vcd.vcd" \
	"+ibex_tracer_enable" \
	tb_rtl_top_vopt \
	-do "do $(ROOT_PATH)/tb/do/waves_rtl.tcl; run -all"


lsim/gate/nogui: 

ifeq ($(FIRMWARE),0)
	@printf "\033[31mYou must define a firmware (.hex) file! Usage: make sim/gate/nogui FIRMWARE=sbst/your_file.hex\033[39m\n"
	@exit 1
endif 

	cd $(ROOT_PATH)/run && \
	vsim -c \
	-quiet -suppress 3839 -work work_gate \
	"+verbose" \
	$(MEMDEBUG) \
	"+firmware=$(ROOT_PATH)/$(FIRMWARE)" \
	"+vcd=$(ROOT_PATH)/run/gate_tb_top_vcd.vcd" \
	tb_gate_top_vopt \
	-do "run -all"

lsim/gate/gui: 

ifeq ($(FIRMWARE),0)
	@printf "\033[31mYou must define a firmware (.hex) file! Usage: make sim/gate/gui FIRMWARE=sbst/your_file.hex\033[39m\n"
	@exit 1
endif 

	cd $(ROOT_PATH)/run && \
	vsim -gui \
	-quiet -suppress 3839 -work work_gate \
	"+verbose" \
	$(MEMDEBUG) \
	"+firmware=$(ROOT_PATH)/$(FIRMWARE)" \
	"+vcd=$(ROOT_PATH)/run/gate_tb_top_vcd.vcd" \
	tb_gate_top_vopt \
	-do "do $(ROOT_PATH)/tb/do/waves_gate.tcl; run -all"

synthesis/nangate45:
	cd $(ROOT_PATH)/syn/dc/bin && \
	bash run_synth.sh 

clean:	
	make --directory $(ROOT_PATH)/sbst clean
	rm $(ROOT_PATH)/run -rfv
	rm $(ROOT_PATH)/syn/dc/output/* $(ROOT_PATH)/syn/dc/run/* -rfv

tarball: clean 
	tar -zcvf ../ibex.tar.gz .

fsim/zoix/fgen:

	cd $(ROOT_PATH)/run/zoix_fsim && \
	fr2fdef \
	+format+standard +verbose +warnreturn+0 +nocollapse \
	+dut+ibex_top \
	-fr $(ROOT_PATH)/zoix/gen_stuck_at_ibex.sff \
	-l fgen_z.log && \
	fault_report -out fgen_z.rpt 

fsim/zoix/lsim:

ifeq ($(VCD),0)
	@printf "\033[31mYou must define a VCD (.vcd) file! Usage: make fsim/zoix/lsim VCD=run/your_gate_tb_top_vcd.vcd\033[39m\n"
	@exit 1
endif 

	cd $(ROOT_PATH)/run/zoix_fsim && \
	./zoix.sim \
	+vcd+file+"$(ROOT_PATH)/$(VCD)" \
	+vcd+dut+ibex_top+tb_top.dut \
	+vcd+verify \
	+vcd+verify_tolerance+116000 \
	+vcd+verbose \
	-l zoix_lsim.log 

fsim/zoix/fsim: 

ifeq ($(VCD),0)
	@printf "\033[31mYou must define a VCD (.vcd) file! Usage: make fsim/zoix/lsim VCD=run/your_gate_tb_top_vcd.vcd\033[39m\n"
	@exit 1
endif 

	cd $(ROOT_PATH)/run/zoix_fsim && \
	export ROOT_PATH=$(ROOT_PATH) && \
	export VCD=$(VCD) && \
	fmsh -load $(ROOT_PATH)/zoix/stuck_at_fsim_vcd.fmsh