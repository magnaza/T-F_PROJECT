RISCV            ?= ~/.riscv
RISCV_EXE_PREFIX  = $(RISCV)/bin/riscv32-unknown-elf-
LINKER_SCRIPT 	  = link.ld
CC 		          = gcc
LFLAGS 		      = -lc -lm -lgcc -nostdlib 
ABI_STRING        = rv32imc

.PRECIOUS: %.elf %.S

all: $(patsubst %.S,%.hex,$(wildcard *.S))

%.hex: %.elf
	@printf "\t\t\t\tBIN2HEX $(<) |-> $(@) \n"
	@$(RISCV_EXE_PREFIX)objcopy \
		--output-target=verilog $< $@

%.elf: %.o 
	@printf "\t\t\tLINKING $(<) |-> $(@) \n"
	@$(RISCV_EXE_PREFIX)$(CC) \
		-march=$(ABI_STRING) \
		-T $(LINKER_SCRIPT) \
		-static \
		-I $(RISCV)/riscv32-unknown-elf/include \
		-L $(RISCV)riscv32-unknown-elf/lib \
		$(LFLAGS) \
		-g -w \
		-o $@ \
		$< 

	@rm -rf $<

%.o : %.S
	@printf "\t\tX-COMPILING $(<)|-> $(@) \n"
	@$(RISCV_EXE_PREFIX)$(CC) \
		-march=$(ABI_STRING) \
		-c $< \
		-g -w -Os \
		-o $@
.PHONY:
clean: 
	@printf "\t\t@@@@@@@@ CLEAN @@@@@@@@ \n"
	@rm -rf *.elf *.hex



