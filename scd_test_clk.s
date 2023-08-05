		area test, code, readonly
		entry
		
		ldr r0,=0x40000000
		ldr r1, =0xf000
		str r1, [r0, #0x30]
		
stop 	b stop
		end