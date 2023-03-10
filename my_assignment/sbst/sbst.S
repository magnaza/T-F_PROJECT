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

##################################
##### TESTING REGISTER FILE ######
##################################

#store all the values that are for default set to 0, then set all the registers to all '1'
#and store again all the values
    li      x2, 0x0
store:
    la      x31, test_result
    sw      x0, 0(x31)
    sw      x2, 0(x31)
    sw      x1, 0(x31)
    sw      x3, 0(x31)
    sw      x4, 0(x31)
    sw      x5, 0(x31)
    sw      x6, 0(x31)
    sw      x7, 0(x31)
    sw      x8, 0(x31)
    sw      x9, 0(x31)
    sw      x10, 0(x31)
    sw      x11, 0(x31)
    sw      x11, 0(x31)
    sw      x13, 0(x31)
    sw      x14, 0(x31)
    sw      x15, 0(x31)
    sw      x16, 0(x31)
    sw      x17, 0(x31)
    sw      x18, 0(x31)
    sw      x19, 0(x31)
    sw      x20, 0(x31)
    sw      x21, 0(x31)
    sw      x22, 0(x31)
    sw      x23, 0(x31)
    sw      x24, 0(x31)
    sw      x25, 0(x31)
    sw      x26, 0(x31)
    sw      x27, 0(x31)
    sw      x28, 0(x31)
    sw      x29, 0(x31)
    sw      x30, 0(x31)
    la      t0, test_result
    c.mv    x31, x8
    sw      x31, 0(t0)

c.bnez      x8, end_RG

    li x1,  0xFFFFFFFF
    li x2,  0xFFFFFFFF
    li x3,  0xFFFFFFFF
    li x4,  0xFFFFFFFF
    li x5,  0xFFFFFFFF
    li x6,  0xFFFFFFFF
    li x7,  0xFFFFFFFF
    li x8,  0xFFFFFFFF
    li x9,  0xFFFFFFFF
    li x10, 0xFFFFFFFF
    li x11, 0xFFFFFFFF
    li x12, 0xFFFFFFFF
    li x13, 0xFFFFFFFF
    li x14, 0xFFFFFFFF
    li x15, 0xFFFFFFFF
    li x16, 0xFFFFFFFF
    li x17, 0xFFFFFFFF
    li x18, 0xFFFFFFFF
    li x19, 0xFFFFFFFF
    li x20, 0xFFFFFFFF
    li x21, 0xFFFFFFFF 
    li x22, 0xFFFFFFFF 
    li x23, 0xFFFFFFFF 
    li x24, 0xFFFFFFFF 
    li x25, 0xFFFFFFFF 
    li x26, 0xFFFFFFFF 
    li x27, 0xFFFFFFFF 
    li x28, 0xFFFFFFFF 
    li x29, 0xFFFFFFFF 
    li x30, 0xFFFFFFFF

    j store 
     
 end_RG:
 
    la      x31, my_patterns
    lw      x0, 5*4(x31)
    lw      x1, 5*4(x31)
    lw      x2, 5*4(x31)
    lw      x3, 5*4(x31)
    lw      x4, 5*4(x31)
    lw      x5, 5*4(x31)
    lw      x6, 5*4(x31)
    lw      x7, 5*4(x31)
    lw      x8, 5*4(x31)
    lw      x9, 5*4(x31)
    lw      x10, 5*4(x31)
    lw      x11, 5*4(x31)
    lw      x12, 5*4(x31)
    lw      x13, 5*4(x31)
    lw      x14, 5*4(x31)
    lw      x15, 5*4(x31)
    lw      x16, 5*4(x31)
    lw      x17, 5*4(x31)
    lw      x18, 5*4(x31)
    lw      x19, 5*4(x31)
    lw      x20, 5*4(x31)
    lw      x21, 5*4(x31)
    lw      x22, 5*4(x31)
    lw      x23, 5*4(x31)
    lw      x24, 5*4(x31)
    lw      x25, 5*4(x31)
    lw      x26, 5*4(x31)
    lw      x27, 5*4(x31)
    lw      x28, 5*4(x31)
    lw      x29, 5*4(x31)
    lw      x30, 5*4(x31)
    la      x1, my_patterns
    lw      x31, 5*4(x1)
    
    lw      x2, 6*4(x1)
    lw      x3, 6*4(x1)
    lw      x4, 6*4(x1)
    lw      x5, 6*4(x1)
    lw      x6, 6*4(x1)

# THE FOLLOWING INSTRUCTIONS GENERATE ERRORS, I DONT KNOW WHY #
   
    lw      x6, 6*4(x1)
    lw      x8, 6*4(x1)    
    lw      x9, 6*4(x1)
    lw      x10, 6*4(x1)
    lw      x11, 6*4(x1)
    lw      x12, 6*4(x1)
    lw      x13, 6*4(x1)
    lw      x14, 6*4(x1)
    lw      x15, 6*4(x1)
    lw      x16, 6*4(x1)
    lw      x17, 6*4(x1)
    lw      x18, 6*4(x1)
    lw      x19, 6*4(x1)
    lw      x20, 6*4(x1)
    lw      x21, 6*4(x1)
    lw      x22, 6*4(x1)
    lw      x23, 6*4(x1)
    lw      x24, 6*4(x1)
    lw      x25, 6*4(x1)
    lw      x26, 6*4(x1)
    lw      x27, 6*4(x1)
    lw      x28, 6*4(x1)
    lw      x29, 6*4(x1)
    lw      x30, 6*4(x1)
    lw      x31, 6*4(x1)
 
    la      x31, my_patterns
    lw      x1, 6*4(x31)

    li x1,  0x0
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
    la sp, _sp

################################
####### CS - REGISTER ##########
################################

li          t2, 0xFFFFFFFF
li          t3, 0x00000000

csrrw       t0, mstatus, t2
csrrw       t4, mstatus, t3
csrrw       t4, mstatus, t0
csrrs       t4, mstatus, x0
csrrc       t4, mstatus, x0
csrrwi      t4, mstatus, 0x4
csrrsi      t4, mstatus, 0x4
csrrci      t4, mstatus, 0x4

csrrw       t0, misa, t2
csrrw       t4, misa, t3
csrrw       t4, misa, t0

csrrw       t0, mie, t2
csrrw       t4, mie, t3
csrrw       t4, mie, t0

csrrw       t0, mtvec, t2
csrrw       t4, mtvec, t3
csrrw       t4, mtvec, t0


csrrw       t0, mhpmevent3, t2
csrrw       t4, mhpmevent3, t3
csrrw       t4, mhpmevent3, t0

csrrw       t0, mhpmevent31, t2
csrrw       t4, mhpmevent31, t3
csrrw       t4, mhpmevent31, t0

csrrw       t0, mscratch, t2
csrrw       t4, mscratch, t3
csrrw       t4, mscratch, t0

csrrw       t0, mepc, t2
csrrw       t4, mepc, t3
csrrw       t4, mepc, t0

csrrw       t0, mcause, t2
csrrw       t4, mcause, t3
csrrw       t4, mcause, t0

csrrw       t0, mip, t2
csrrw       t4, mip, t3
csrrw       t4, mip, t0


csrrs       t0, mvendorid, x0

csrrs       t0, marchid, x0

csrrs       t0, mimpid, x0

csrrs       t0, mhartid, x0



################################
####### MUL - DIV ##############
################################



    # TEST 1 -> T2 = 0xFFFFFFFF T3 = 0x0 T1 = 0 #
    la      t0, test_result
    li      t2, 0xFFFFFFFF
    mul     t1, t2, t3
    sw      t1, 0(t0)
    mulh    t1, t2, t3
    sw      t1, 0(t0)
    div     t1, t3, t2
    sw      t1, 0(t0)
    divu    t1, t3, t2
    sw      t1, 0(t0)
    rem     t1, t3, t2
    sw      t1, 0(t0)
    remu    t1, t3, t2
    sw      t1, 0(t0)
    


    # TEST 2 -> T2 = 0xFFFFFFFF T3 = 0x1 T1 = 0xFFFFFFFF # 

    li      t3, 0x1
    mul     t1, t2, t3
    sw      t1, 0(t0)
    mulh    t1, t2, t3
    sw      t1, 0(t0)
    div     t1, t2, t3
    sw      t1, 0(t0)
    divu    t1, t2, t3
    sw      t1, 0(t0)

    # PROBLEM FOR REMINDER: HOW TO MAKE ALL THE BITS OF THE RESULT REMINDER 1?

    # TEST 3 -> T2 = 0x0 T3 = 0xFFFFFFFF T1 = 0x0 #

    li      t2, 0x0
    li      t3, 0xFFFFFFFF
    mul     t1, t2, t3
    sw      t1, 0(t0)
    mulh    t1, t2, t3
    sw      t1, 0(t0)
    div     t1, t2, t3
    sw      t1, 0(t0)
    divu    t1, t2, t3
    sw      t1, 0(t0)
    rem     t1, t2, t3
    sw      t1, 0(t0)
    remu    t1, t2, t3
    sw      t1, 0(t0)

    # TEST 4:EXCEPTION -> N/0 T2 = 0x0 T3 = 0xFFFFFFFF T1 = ? #
    
    div     t1, t3, t2
    sw      t1, 0(t0)
    divu    t1, t3, t2
    sw      t1, 0(t0)

    # TEST 5: REMINDER -> T2 = 0x80000000 T3 = 0xFFFFFFFF T1 = 0x01111111

    li      t2, 0x80000000
    rem     t1, t3, t2
    sw      t1, 0(t0)
    remu    t1, t3, t2
    sw      t1, 0(t0)
  
    # THEY ARE NOT RECOGNIZE BY THE COMPILER??? update: NOW YES!
    
    li      t2, 0x0    
    mulhsu  t1, t2, t3
    sw      t1, 0(t0)
    mulhu   t1, t2 ,t3
    sw      t1, 0(t0)
    li      t2, 0xFFFFFFFF
    mulhsu  t1, t2, t3
    sw      t1, 0(t0)
    mulhu   t1, t2 ,t3
    sw      t1, 0(t0)
    
  
    # RESTORE INITIAL VALUES #

    li      t1, 0x0
    li      t1, 0x0
    li      t2, 0x0
    li      t3, 0x0
    


############################
##### C. INSTRUCTIONS ######
############################


    la      t3, my_patterns
    la      t4, test_result
    #c.swsp  x8, 0(sp)
    #c.lwsp  x8, 0(sp)
    la      x9, test_result
    la      x8, my_patterns
    c.lw    x10, 2*4(x8)
    c.sw    x10, 2*4(x9)

    c.j     jump1
jump1:
    c.jal   jump2
jump2:
    la      t5, jump3
    c.jr    t5
jump3:
    la      t5, jump4
    c.jalr  t5
jump4:      
    li      x8, 0x0
    c.beqz  x8, jump5
jump5:
    li      x8, 0x1
    c.bnez  x8, jump6
jump6:
    #c.addi16sp  sp, 0x4
    #c.addi4spn  x8, sp, 0x4


    c.li    t1, 0x0 
    sw      t1, 0(t0)
    c.lui   t2, 0xF
    sw      t2, 0(t0)
    c.addi  t1, 0x4
    sw      t1, 0(t0)

    c.slli  t1, 0x4
    sw      t1, 0(t0)
    c.srli  x8, 0x4
    sw      x8, 0(t0)
    c.srai  x8, 0x4
    sw      x8, 0(t0)
    c.andi  x8, 0xF
    sw      x8, 0(t0)
    li      t2, 0xFFFFFFFF
    li      t1, 0x00000000
    c.mv    x8, t2
    sw      x8, 0(t0)
    c.mv    x9, t1
    sw      x9, 0(t0)
    c.add   t1, t2
    sw      t1, 0(t0)
    c.and   x8, x9
    sw      x8, 0(t0)
    c.or    x8, x9
    sw      x8, 0(t0)
    c.xor   x8, x9
    sw      x8, 0(t0)
    c.sub   x8, x9
    sw      x8, 0(t0)
    c.nop

davideB_part:


davideF_part:

###############################
##### RV32I INSTRUCTIONS ######
###############################

	la		t0, test_result

## R TYPE ##
#Arithmetic and Logic Operations
    li      t2, 0xFFFFFFFF
    sw      t2, 0(t0)
    li      t4, 0x00000002
    sw      t4, 0(t0)
    add     t1, t2, t3
    sw      t1, 0(t0)
    sub     t1, t2, t3
    sw      t1, 0(t0)
    xor     t1, t2, t3
    sw      t1, 0(t0)
    or      t1, t2, t3
    sw      t1, 0(t0)
    and     t1, t2, t3
    sw      t1, 0(t0)

#Shift
    sll     t1, t2, t4
    sw      t1, 0(t0)
    srl     t1, t2, t4
    sw      t1, 0(t0)
    sra     t1, t2, t4
    sw      t1, 0(t0)

#Set-Less-Then 
#False   
    slt     t1, t2, t3
    sw      t1, 0(t0)
    sltu    t1, t2, t3
    sw      t1, 0(t0)
#True
    slt     t1, t3, t2
    sw      t1, 0(t0)
    sltu    t1, t3, t2
    sw      t1, 0(t0)

## I TYPE ##
#Arithmetic and Logic Operations
    addi     t1, t2, 0x4
    sw      t1, 0(t0)
    xori     t1, t2, 0xAA
    sw      t1, 0(t0)
    ori      t1, t2, 0xAA
    sw      t1, 0(t0)
    andi     t1, t2, 0xAA
    sw      t1, 0(t0)

#Shift
    slli    t1, t2, 0x4
    sw      t1, 0(t0)
    srli    t1, t2, 0x4
    sw      t1, 0(t0)
    srai    t1, t2, 0x4
    sw      t1, 0(t0)

#Set-Less-Then 
#SLTUI NOT RECOGNIZED!!
#False   
    slti    t1, t2, 0x1
    sw      t1, 0(t0)
#    sltui   t1, t2, 0x1 
#True
    slti    t1, t3, 0x1
    sw      t1, 0(t0)
#    sltui   t1, t3, 0x1 

#Load 
	la		t1, my_patterns
	lb		t2,	0*4(t1)
    sw      t2, 0(t0)  	
	lh		t3,	1*4(t1)
    sw      t3, 0(t0)
	lw		t4, 2*4(t1)
    sw      t4, 0(t0)
	lbu	    t5,	3*4(t1)
    sw      t5, 0(t0)  	
	lhu 	t5,	4*4(t1)
    sw      t5, 0(t0)

## S TYPE ##
#Store
    sb      t2, 0(t0)
    sh      t3, 0(t0)
    sw      t4, 0(t0)
  
## B TYPE ##
#Branch not taken
    li      t2, 0x00000004
    li      t4, 0x00000002
    beq     t2, t4, branch_1
    bne     t2, t2, branch_1
    blt     t2, t4, branch_1
    bge     t4, t2, branch_1
    bltu    t2, t4, branch_1
    bgeu    t4, t2, branch_1 
#Branch taken
    beq     t2, t2, branch_1
branch_1:
    bne     t4, t2, branch_2
branch_2:
    blt     t4, t2, branch_3
branch_3:
    bge     t2, t4, branch_4
branch_4:
    bltu    t4, t2, branch_5
branch_5:
    bgeu    t2, t4, branch_6
branch_6:

## J TYPE ##
#Jump
    li      t2, 0xFFFFFFFF
    li      t4, 0x00000002
    jal jump_1
jump_1:
    la      t1, jump_2
    jalr    t1
jump_2:

## U TYPE ##
    lui     t1, 0x00001111
    sw      t1, 0(t0)
    auipc   t1, 0x00000010
    sw      t1, 0(t0)


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

my_patterns:
	
	.long 0xdeadface
	.long 0x01020304
	.long 0xab34d314
    .long 0x8
    .long 0x9
    .long 0x00000000
    .long 0xFFFFFFFF
    .long 0x00030080

/* TEST_DATA where to store data if necessary */
.section ".TEST_DATA", "aw"
.global test_result

test_result:
    .space 4
