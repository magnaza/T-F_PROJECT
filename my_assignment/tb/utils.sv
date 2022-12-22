`ifndef _UTILS_SV_
`define _UTILS_SV_

// -------------------------------
//  LOGGING MACROS  
// -------------------------------
`define INFO(MSG) \
    $display("[ \033[0;36m INFO \033[0m ]: \" %s \" (@ %0t)", MSG, $time);

`define WARN(MSG) \
    $display("[ \033[1;33m WARN \033[0m ]: \" %s \" (@ %0t)", MSG, $time);

`define MDBG(MSG) \
    $display("[ \033[1;33m DEBUG\033[0m ]: \" %s \" (@ %0t)", MSG, $time);

`define ERROR(MSG) \
    $display("[ \33[0;31m ERROR\033[0m ]: \" %s \" (@ %0t)", MSG, $time);

`define SUCCESS(MSG) \
    $display("[\033[0;32m SUCCESS\033[0m]: \" %s \" (@ %0t)", MSG, $time);

// -------------------------------
//      32 "HEX" TO STRING  
// -------------------------------
function string hex32_to_string(input logic [31:0] _hex_ );
	automatic string _str_;
	_str_.hextoa(_hex_);
	return _str_;
endfunction

// -------------------------------
// UNPACKED DYNAMIC ARR TO STRING  
// -------------------------------
function string bin_to_string (input logic _bin_ [] );

    automatic string _str_;
	
	_str_ = "";
	for (int i = 0 ; i < _bin_.size(); i++) begin 

		automatic string bit_to_str;

		bit_to_str.bintoa(_bin_[i]);

		_str_ = {_str_, bit_to_str};

	end 

	return _str_;
endfunction : bin_to_string


// -------------------------------
// INT TYPE TO STRING   
// -------------------------------
function string int_to_string (input int _int_);
    automatic string _str_;
    _str_.itoa(_int_);
    return _str_;
endfunction : int_to_string



`endif
