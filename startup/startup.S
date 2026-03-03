.syntax unified
.cpu cortex-m0
.thumb

/* Vector table */
.section .isr_vector, "a", %progbits
.global __isr_vector
.type __isr_vector, %object

__isr_vector:
        .word  _estack
        .word  Reset_Handler

        .word  NMI_Handler
        .word  HardFault_Handler
        .word  MemManage_Handler
        .word  BusFault_Handler
        .word  UsageFault_Handler
        .word  0
        .word  0
        .word  0
        .word  0
        .word  SVC_Handler
        .word  DebugMon_Handler
        .word  0
        .word  PendSV_Handler
        .word  SysTick_Handler

        /* too lazy to define other external exceptions */

/* Reset handler */
.section .text.Reset_Handler,"ax",%progbits
.global Reset_Handler
.type Reset_Handler, %function

Reset_Handler: 
        bl bss_zero
        bl data_copy
        bl main

bss_zero:
        ldr r0, = _sbss /* bss start */
        ldr r1, = _ebss /* bss end */
        ldr r2, = #0
        b bss_zero_loop

bss_zero_loop:
        cmp r0, r1
        bcs return_bss_zero
        str r2, [r0]
        adds r0, #4
        b bss_zero_loop
return_bss_zero:
        bx lr

data_copy:
        ldr r0, = _sidata       /* source in flash */
        ldr r1, = _sdata        /* destination start in RAM */
        ldr r2, = _edata        /* destination end in RAM */
        b data_copy_loop

data_copy_loop:
        cmp r1, r2
        bcs return_data_copy
        ldr r3, [r0]
        str r3, [r1]
        adds r0, #4
        adds r1, #4
        b data_copy_loop
return_data_copy:
        bx lr

/**
 * @brief  This is the code that gets called when the processor receives an
 *         unexpected interrupt.  This simply enters an infinite loop, preserving
 *         the system state for examination by a debugger.
 * @param  None
 * @retval None
*/
.section  .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
        b  Infinite_Loop


/*******************************************************************************
*
* Provide weak aliases for each Exception handler to the Default_Handler.
* As they are weak aliases, any function with the same name will override
* this definition.
*
*******************************************************************************/
        .weak      NMI_Handler
        .thumb_set NMI_Handler,Default_Handler

        .weak      HardFault_Handler
        .thumb_set HardFault_Handler,Default_Handler

        .weak      MemManage_Handler
        .thumb_set MemManage_Handler,Default_Handler

        .weak      BusFault_Handler
        .thumb_set BusFault_Handler,Default_Handler

        .weak      UsageFault_Handler
        .thumb_set UsageFault_Handler,Default_Handler

        .weak      SVC_Handler
        .thumb_set SVC_Handler,Default_Handler

        .weak      DebugMon_Handler
        .thumb_set DebugMon_Handler,Default_Handler

        .weak      PendSV_Handler
        .thumb_set PendSV_Handler,Default_Handler

        .weak      SysTick_Handler
        .thumb_set SysTick_Handler,Default_Handler

