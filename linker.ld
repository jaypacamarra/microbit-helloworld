/*
 * minimal linker script for the bbc microbit v1.5
 */

ENTRY(Reset_Handler)

MEMORY
{
        FLASH (rx)      : ORIGIN = 0x00000000, LENGTH = 256K
        RAM (rwx)       : ORIGIN = 0x20000000, LENGTH = 16K
}

OUTPUT_FORMAT ("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")

SECTIONS
{
        .text :
        {
                . = ALIGN(4);
                _stext = .;
                KEEP(*(.isr_vector))
                *(.text*)
                *(.rodata*)
                . = ALIGN(4);
                _etext = .;
        } > FLASH

        .data : AT(_etext)
        {
                . = ALIGN(8);
                _sdata = .;
                *(.data*)
                _edata = .;
                . = ALIGN(8);
        } > RAM


        _sidata = LOADADDR(.data);

        .bss :
        {
                . = ALIGN(8);
                _sbss = .;
                *(.bss*)
                *(common)
                . = ALIGN(8);
                _ebss = .;
        } > RAM

        _estack = ORIGIN(RAM) + LENGTH(RAM);
}

