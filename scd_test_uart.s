		 area	prachw, code, readonly 
pinsel0 equ	 0xE002C000
U0Start equ	 0xE000C000
LCR0	equ	 0xC
LSR0	equ  0x14
Ramstart equ 0x40000000
		entry
start
		ldr sp, =Ramstart
		bl UARTConfig
		ldr r0, =CharData
		;ldr r0, =CharData
		;add r0, #31
		;mov r2, #29 
;Loop2	
		;ldrb r1, [r0], #-1
		;blne transmit
		;subs r2, #1
		;bne Loop2
		;add r0, #1	
			
		ldr r12, =0
		ldr r0, =CharData
		add r0, #52
		;410440126HuangYiChieh
Loop1	
		ldrb r1, [r0], #1; error-free
		cmp r12, #5
		beq out1
		cmp r1, #0
		blne transmit
		add r12, #1
		bne Loop1
out1


		ldr r12, =0
		ldr r0, =CharData
		add r0, #41
Loop2	
		ldrb r1, [r0], #1; error-free
		cmp r12, #10
		beq out2
		cmp r1, #0
		blne transmit
		add r12, #1
		bne Loop2
out2

		
		ldr r12, =0
		ldr r0, =CharData
		add r0, #37
Loop3	
		ldrb r1, [r0], #1; error-free
		cmp r12, #3
		beq out3
		cmp r1, #0
		blne transmit
		add r12, #1
		bne Loop3
out3


		ldr r12, =0
		ldr r0, =CharData
		add r0, #34
Loop4	
		ldrb r1, [r0], #1; error-free
		cmp r12, #2
		beq out4
		cmp r1, #0
		blne transmit
		add r12, #1
		bne Loop4
out4


		ldr r12, =0
		ldr r0, =CharData
		add r0, #29
Loop5	
		ldrb r1, [r0], #1; error-free
		cmp r12, #4
		beq out5
		cmp r1, #0
		blne transmit
		add r12, #1
		bne Loop5
out5


		ldr r12, =0
		ldr r0, =CharData
		add r0, #25
Loop6	
		ldrb r1, [r0], #1; error-free
		cmp r12, #3
		beq out6
		cmp r1, #0
		blne transmit
		add r12, #1
		bne Loop6
out6


		ldr r12, =0
		ldr r0, =CharData
		add r0, #11
Loop7	
		ldrb r1, [r0], #1; error-free
		cmp r12, #12
		beq out7
		cmp r1, #0
		blne transmit
		add r12, #1
		bne Loop7
out7


		ldr r12, =0
		ldr r0, =CharData
		add r0, #1
Loop8	
		ldrb r1, [r0], #1; error-free
		cmp r12, #9
		beq out8
		cmp r1, #0
		blne transmit
		add r12, #1
		bne Loop8
out8


		
		
		
		mov	r9, #20
Loopr
		bl receive
		strb r1, [r0], #1
		subs r9, r9, #1
		bne Loopr
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
		ldr r6, =0x8b
		strb r6, [r5, #LCR0]
		ldr r6, =0xb4
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
		strb r1, [r5]
		ldmdb sp!, {r5, r6, pc}
;410440126HuangYiChieh
receive
		stmia sp!, {r5, r6, lr}
		ldr r5, =U0Start
wait1	
		ldrb r6, [r5, #LSR0]
		tst r6, #1
		beq wait1
		ldrb r1, [r5] ;error-free
		tst r6, #0xe ;error-free
		bne wait1
		ldmdb sp!, {r5, r6, pc}
		
;410440126HuangYiChieh
;IntDefaultHandler
;		ldr r5, =0xe000c000
;		ldrb r6, [r5, #0x14]
;		tst r6, #1
;		ldrbne r3, [r5]
;		
;		tst r6, #0xe
;		movne r3, #0
;		
;		tst r6, #0x20
;		strbne r12, [r5]
;		
;		bx lr
;done 	b done
;		align

CharData
		dcb	"(410440126-HuangYiChieh)-2nd test in the spring2023 class!", 0
		end




