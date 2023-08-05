		 area	prachw, code, readonly 
pinsel0 equ	 0xE002C000
U0Start equ	 0xE000C000
LCR0	equ	 0xC
LSR0	equ  0x14
Ramstart equ 0x40000000
		entry
start
 		ldr r7, =0x40000080
		ldr sp, =0x40000030
		bl UARTConfig
		ldr r1, =MyData
		add r1, #5
		mov r2, #22

Loop	
		ldrb r0, [r1], #1
		cmp r0, #0
		blne transmit
		bne Loop
		
		mov	r9, #15
Loop1
		bl receive
		strb r1, [r2], #1
		subs r9, r9, #1
		bne Loop1
		
stop	b stop
;410440126HuangYiChieh
UARTConfig
		stmia sp!, {r5, r6, lr}
		ldr r5, =pinsel0
		ldr r6, [r5]
		bic r6, #0xf
		orr r6, #0x5
		str r6, [r5]
		ldr r5, =U0Start
		ldr r6, =0x83
		strb r6, [r5, #LCR0]
		ldr r6, =0x61
		strb r6, [r5]
		ldr r6, =0x3
		strb r6, [r5, #LCR0]
		ldmdb sp!, {r5, r6, pc}
		
transmit
		stmia sp!, {r5, r6, lr}
		ldr r5, =U0Start
		
wait
		ldr r6, [r5, #LSR0]
		tst r6, #0x20
		beq wait
		strb r0, [r5]
		strb r0, [r7], #1
		
		ldmdb sp!, {r5, r6, pc}
;410440126HuangYiChieh
receive
		stmia sp!, {r5, r6, r7, lr}
		ldr r5, =U0Start
wait1	
		ldrb r6, [r5, #LSR0]
		tst r6, #1
		beq wait1
		strb r1, [r5]
		
		ldmdb sp!, {r5, r6, r7, pc}
MyData
		dcb	"410440126-HuangYiChieh-ECE-TKU!", 0
		end



