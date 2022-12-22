ROOT_DIR=..

(
    cd ../run
    dc_shell -f ${ROOT_DIR}/bin/syn_nangate.tcl | tee ${ROOT_DIR}/output/syn.log  
)
