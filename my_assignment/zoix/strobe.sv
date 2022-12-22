`timescale 1ns/1ps 
`define TOP ibex_top 

module strobe; 

    initial begin 
        $fs_delete;
        $fs_add(`TOP);
    end 

    initial begin 

        #1000; // reset period

        forever begin 

            // STROBE POINTS 

            // PRIMARY OUTPUTS 
            $fs_strobe(`TOP.instr_req_o           ); 
            $fs_strobe(`TOP.instr_addr_o          ); 
            $fs_strobe(`TOP.data_req_o            );           
            $fs_strobe(`TOP.data_we_o             ); 
            $fs_strobe(`TOP.data_be_o             ); 
            $fs_strobe(`TOP.data_addr_o           ); 
            $fs_strobe(`TOP.data_wdata_o          ); 
            $fs_strobe(`TOP.data_wdata_intg_o     ); 
            $fs_strobe(`TOP.scramble_req_o        ); 
            $fs_strobe(`TOP.crash_dump_o          ); 
            $fs_strobe(`TOP.double_fault_seen_o   ); 
            $fs_strobe(`TOP.alert_minor_o         ); 
            $fs_strobe(`TOP.alert_major_internal_o); 
            $fs_strobe(`TOP.alert_major_bus_o     ); 
            $fs_strobe(`TOP.core_sleep_o          );    

            #10; // Strobe Period
        end 

    end 

endmodule 