OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv",
	      "elf32-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
	instrram (rxai) : ORIGIN = 0x00000080, LENGTH = 0x30000
	dataram  (rwai) : ORIGIN = 0x00030080, LENGTH = 0x10000
}

SECTIONS
{
  
  __stack_size = DEFINED(__stack_size) ? __stack_size : 0x400;
  PROVIDE(__stack_size = __stack_size);

  /* the bulk of the program: main, libc, functions etc. */
  .text :
  {
    *(.text  .text.* )
  } >instrram

  /* read-only sections */
  .rodata :
  {
    *(.rodata .rodata.*)
  } >instrram

  /* data sections for initalized data */
  .data :
  {
    *(.data .data.*)
  } >dataram

  .sdata :
  {
    *(.srodata .srodata.*)
    *(.sdata .sdata.* )
  } >dataram

  /* zero initialized sections */
  .sbss :
  {
    *(.sbss .sbss.*)
  } >dataram

  .bss :
  {
    PROVIDE(__bss_start = .);
   *(.bss .bss.* )
    PROVIDE(__bss_end = .);
  } >dataram

  .stack : ALIGN(16) /* this is a requirement of the ABI(?) */
  {
   PROVIDE(__stack_start = .);
   . = __stack_size;
   PROVIDE(_sp = .);
   PROVIDE(__stack_end = .);
  } >dataram

}
