		area test, code, readonly
		entry
		;410440126HuangYiChieh
		
		
		ldr r0,=0x40000000
		;ldr r1, =0xf000
		
		;0xffff - 0xf000 = 0xfff = 4650
		;4650/3000 = 1.365sec
		
		ldr r1, =0xb9af
		;3kHz x 6(sec) = 18000 = 0x4650
		;0xffff - 0x4650 = 0xb9af
		
		str r1, [r0, #0x30]
		
stop 	b stop
		end