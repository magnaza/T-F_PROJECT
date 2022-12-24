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

fede_part:    
    la      t0, test_result
    

    # TEST 1 -> T2 = 0xFFFFFFFF T3 = 0x0 T1 = 0 #
    
    li      t2, 0xFFFFFFFF
    mul     t1, t2, t3
    mulh    t1, t2, t3
    /* THEY ARE NOT RECOGNIZE BUT THE COMPILER???
    mulsu   t1, t2, t3
    mulu    t1, t2 ,t3
    */
    div     t1, t3, t2
    divu    t1, t3, t2
    rem     t1, t3, t2
    remu    t1, t3, t2
    


    # TEST 2 -> T2 = 0xFFFFFFFF T3 = 0x1 T1 = 0xFFFFFFFF # 

    li      t3, 0x1
    mul     t1, t2, t3
    mulh    t1, t2, t3
    /*  THEY ARE NOT RECOGNIZE BY THE COMPILER???
    mulsu   t1, t2, t3
    mulu    t1, t2 ,t3
    */
    div     t1, t2, t3
    divu    t1, t2, t3

    /* PROBLEM FOR REMINDER: HOW TO MAKE ALL THE BITS OF THE RESULT REMINDER 1?*/

    # TEST 3 -> T2 = 0x0 T3 = 0xFFFFFFFF T1 = 0x0 #

    li      t2, 0x0
    li      t3, 0xFFFFFFFF
    mul     t1, t2, t3
    mulh    t1, t2, t3
    /* THEY ARE NOT RECOGNIZE BY THE COMPILER???(again)
    mulsu   t1, t2, t3
    mulu    t1, t2 ,t3
    */
    div     t1, t2, t3
    divu    t1, t2, t3
    rem     t1, t2, t3
    remu    t1, t2, t3

    # TEST 4:EXCEPTION -> N/0 T2 = 0x0 T3 = 0xFFFFFFFF T1 = ?#
    
    div     t1, t3, t2
    divu    t1, t3, t2

    # TEST 5: REMINDER -> T2 = 0x80000000 T3 = 0xFFFFFFFF T1 = 0x01111111

    li      t2, 0x80000000
    rem     t1, t3, t2
    remu    t1, t3, t2
    
    # RESTORE INITIAL VALUES #

    li      t2, 0x0
    li      t3, 0x0
    
davideB_part:


davideF_part:


/****** ////\\\\*******              
 *                 _  *
 *   ___ _ __   __| | *
 *  / _ \ '_ \ / _` | *
 * |  __/ | | | (_| | *
 *  \___|_| |_|\__,_| *
 *                    *
 **********************/     
             
    EXIT t1

/* TEST_RODATA where to retrieve data if necessary */
.section ".TEST_RODATA", "a" // Emit the section .TEST_RODATA and make it current. 

my_fancy_patterns:
	
	.long 0xdeadface
	.long 0x01020304
	.long 0xab34d314


/* TEST_DATA where to store data if necessary */
.section ".TEST_DATA", "aw"
.global test_result

test_result:
    .space 4