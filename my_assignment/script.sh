rm -r run/*
make xcompile
make compile/questa/rtl
make compile/questa/gate
make compile/zoix

make lsim/rtl/nogui  FIRMWARE=sbst/sbst.hex
#make lsim/rtl/nogui  FIRMWARE=sbst/sbst.hex MEMDEBUG="+memory_debug"
#make lsim/gate/nogui FIRMWARE=sbst/sbst.hex MEMDEBUG="+memory_debug"
make lsim/gate/nogui FIRMWARE=sbst/sbst.hex

make fsim/zoix/fgen
make fsim/zoix/lsim VCD=run/gate_tb_top_vcd.vcd
make fsim/zoix/fsim VCD=run/gate_tb_top_vcd.vcd