.macro EXIT reg
    li \reg, 0x00ff2000
    sw zero, 0x0(\reg)
    nop # Mandatory to exit success checks.
    nop # Otherwise pipeline fetches Xs
    nop # and triggers assertions.
.endm

.section .text.start
.global _start
.type _start, @function

_start:

/* initialize registers */
    li x1,  0x0
    li x2,  0x0
    li x3,  0x0
    li x4,  0x0
    li x5,  0x0
    li x6,  0x0
    li x7,  0x0
    li x8,  0x0
    li x9,  0x0
    li x10, 0x0
    li x11, 0x0
    li x12, 0x0
    li x13, 0x0
    li x14, 0x0
    li x15, 0x0
    li x16, 0x0
    li x17, 0x0
    li x18, 0x0
    li x19, 0x0
    li x20, 0x0
    li x21, 0x0 
    li x22, 0x0 
    li x23, 0x0 
    li x24, 0x0 
    li x25, 0x0 
    li x26, 0x0 
    li x27, 0x0 
    li x28, 0x0 
    li x29, 0x0 
    li x30, 0x0
    li x31, 0x0 

/* initialize stack pointer */
    la sp, _sp

/***************************
 *   __ _             _    *
 *  / _\ |_ __ _ _ __| |_  *
 *  \ \| __/ _` | '__| __| *
 *  _\ \ || (_| | |  | |_  *
 *  \__/\__\__,_|_|   \__| *
 *                         *
 ****** \\\\////************/
  
    # YOUR ASSEMBLY CODE #
    
    la  x5, test_result
    mul x28, x29, x30
    sw  x28, 0(x5)
    li  x29, 0x1
    div x28, x29, x30
    sw  x28, 0(x5)

/****** ////\\\\*******              
 *                 _  *
 *   ___ _ __   __| | *
 *  / _ \ '_ \ / _` | *
 * |  __/ | | | (_| | *
 *  \___|_| |_|\__,_| *
 *                    *
 **********************/     
             
    EXIT t1

.section ".TEST_RODATA", "a" // Emit the section .TEST_RODATA and make it current. 

my_fancy_patterns:
	
	.long 0xdeadface
	.long 0x01020304
	.long 0xab34d314

.section ".TEST_DATA", "aw"
.global test_result

test_result:
    .space 4