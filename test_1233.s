		area hw_preemption, code, readonly
		entry
		
		ldr sp, =0x4000008c
		ldr r0, =0xe000ed0c
		ldr r1, =0xe000e484
		ldr r12, =0x6 ;width, r2 is the group num = 3
		ldr r11, =0xE5 ;0b11100101 -> 0b1110|01 00(width 6, grp 3)
		str r11, [r1]
		bl grp_num
		bl read_num
		bl preemption_pri
stop	b stop
		;pri->0xE0   sub->0xE4
grp_num
		stmdb sp!, {r1, r2, r3, lr}
		ldr r1, [r0]
		ldr r2, =0x700
		bic r1, r2
		ldr r3, =0x300 ;group3
		orr r1, r3
		str r1, [r0]
		ldmia sp!, {r1, r2, r3, pc}

read_num
		stmia sp!, {r5, r6, lr}
		ldr r2, [r0] 
		lsr r2, #8
		ldr r6, =0x7
		and r2, r6
		ldmdb sp!, {r5, r6, pc}

preemption_pri
		stmib sp!, {r5, r6, lr}
		ldr r3, [r1]
		ldr r5, =0xFF
		and r3, r5
		;--------------pre-emption priority
		add r5, r2, #1
		mov r4, r3
		lsr r4, r5
		lsl r4, r5 ;r4=pre-emption priority
		;----------------------sub priority
		ldr r6, =8
		mov r7, r3
		sub r6, r12
		lsr r7, r6
		lsl r7, r6 ;r7=sub priority
		ldmda sp!, {r5, r6, pc}

		end



