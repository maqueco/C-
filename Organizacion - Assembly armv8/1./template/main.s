/*
	main.s
*/
.text
.org 0x0000

.equ PERIPHERAL_BASE, 0x3F000000 // Peripheral Base Address
.equ GPIO_BASE, 0x200000 	// GPIO Base Address
.equ GPIO_GPFSEL1, 0x4 		// GPIO Function Select 1
.equ GPIO_GPSET0, 0x1C 		// GPIO Pin Output Set 0
.equ GPIO_GPCLR0, 0x28 		// GPIO Pin Output Clear 0
.equ GPIO_FSEL8_OUT, 0x1000000 	// GPIO Function Select: GPIO Pin X8 Is An Output
.equ GPIO_18, 0x40000 		// GPIO Pin 0: 18


	// Set Cores 1..3 To Infinite Loop
	mrs X0, MPIDR_EL1 	// X0 = Multiprocessor Affinity Register (MPIDR)
	ands X0,X0,3 		// X0 = CPU ID (Bits 0..1)
	b.ne CoreLoop 		// IF (CPU ID != 0) Branch To Infinite Loop (Core ID 1..3)

	// Load in W0 the GPIO base address
	ldr X0,=(PERIPHERAL_BASE + GPIO_BASE)

	// Config GPIO18 as output
	mov W1,GPIO_FSEL8_OUT
	str W1,[X0,GPIO_GPFSEL1]

	// reg W1 contains the mask for set/clear the gpios
	mov W1,GPIO_18

.equ seg, 0x884
.equ C, 0x25c6
.equ D, 0x21aa
.equ E, 0x1dff
.equ F, 0x1c4f
.equ G, 0x193a
.equ A, 0x167b
.equ B, 0x1406

	//------------------ CODE HERE ------------------------------------------------------
	NOP
infloop:
	mov X9, #8
 
DO:
	mov X10, C
	mov X11, seg
	sub X11, X11, #1000
	bl make_sound

RE:
	mov X10, D
	mov X11, seg
	sub X11, X11, #800
	bl make_sound

MI:
	mov X10, E
	mov X11, seg
	sub X11, X11, #725
	bl make_sound

FA:
	mov X10, F
	mov X11, seg
	sub X11, X11, #500
	bl make_sound

SOL:
	mov X10, G
	mov X11, seg
	bl make_sound

LA:
	mov X10, A
	mov X11, seg
	bl make_sound
	
	NOP
	NOP

SI:
	mov X10, B
	mov X11, seg
	bl make_sound

b infloop
	
make_sound:
	mov X4,X11, lsl 0
make_sound2:
	str W1,[X0,GPIO_GPSET0]	// Set GPIO18
	mov X3,X10,lsl 0
label_sound1:
	SUB X3,X3,#1
	CBNZ X3,label_sound1
	
        str W1,[X0,GPIO_GPCLR0]	// Clear GPIO18
	mov X3,X10,lsl 0
label_sound2:
	SUB X3,X3,#1
	CBNZ X3,label_sound2

	SUB X4,X4,#1
	CBNZ X4,make_sound2
	RET	
	

	//----------------------------------------------------------------------------------

CoreLoop:       // Infinite Loop For Core 1..3
  b CoreLoop

