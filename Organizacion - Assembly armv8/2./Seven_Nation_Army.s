/*********************************************************************************************
*	main.s
*
**********************************************************************************************/
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
.equ B3, 0x280a
    //------------------ CODE HERE ------------------------------------------------------
	
	mov X12, 4 // registro para entrar o no al estribillo
	mov X14, 2 // registo para resetear la cancion

infloop:

    ESTROFA:
	mov X13, 4 //repeticion de estrofa

    MI:
 	sub X13, X13, #1 // reduce la cantidad de estrofas
        mov X10, E
        mov X11, seg
        sub X11, X11, #1935 //0,75
        bl make_sound

	NOP
	NOP
  
    Mute:
        mov x10, 0x64
        mov X11, seg
        sub X11, X11, #900
        bl make_sound

    MI1:
        mov X10, E
        mov X11, seg
        sub X11, X11, #2101 // 0,25
        bl make_sound

    SOL:
        mov X10, G
        mov X11, seg
        sub X11, X11, #2033 // 0,375
        bl make_sound

	NOP
	NOP
	NOP
	NOP
    MI2:
        mov X10, E
        mov X11, seg
        sub X11, X11, #2061 // 0,375
        bl make_sound

	CBZ X12, Estribillo // si es cero entra al estribillo

     RE:
    	mov X10, D
    	mov X11, seg
    	sub X11, X11, #2105 // 0,25
        bl make_sound
        
     DO:
        mov X10, C
        mov X11, seg
        sub X11, X11, #1914 // 1
        bl make_sound
        
	CBNZ X12, SI // si no es cero sigue el riff

	NOP
	NOP

Estribillo:

    EST_RE:
        mov X10, D
        mov X11, seg
        sub X11, X11, #2095 // 0,25
        bl make_sound
          
    EST_DO:
        mov X10, C
        mov X11, seg
        sub X11, X11, #2085 // 1 2110 2105
        bl make_sound

    EST_RE2:
	add X12, X12, #2 // para intercalar el riff y estribillo y se cumpla los condicionales
        mov X10, D
        mov X11, seg
        sub X11, X11, #2095 // 0,25
        bl make_sound
        
	NOP
	NOP
	NOP

    EST_DO2:
        mov X10, C
        mov X11, seg
        sub X11, X11, #2085 // 1
        bl make_sound

     SI:
        mov X10, B3
        mov X11, seg
        sub X11, X11, #1934 // 0,5
        bl make_sound
	sub X12, X12, #1 // diminuye la cantidad de repeticiones de la estrofa
        CBNZ X13, MI // vuelve a la primera nota (repite el riff o estribillo)

Puente:
        SOL_puente:
            mov X10, G
            mov X11, seg
            sub X11, X11, #1399
            bl make_sound
	
	NOP
	NOP

        LA_puente:
            mov X10, A
            mov X11, seg
            sub X11, X11, #1300
	    mov X12, 1 // asigna para poder entrar al estribillo
            sub X14, X14, #1 // para ejecutar 2 veces riff y estribillo 
            bl make_sound 
            CBZ X14, RESET // vuelve a comerzar todo riff + estribillo

	b infloop

	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

make_sound:
    	mov X4,X11, lsl 0
make_sound2:
    	str W1,[X0,GPIO_GPSET0]    // Set GPIO18
    	mov X3,X10,lsl 0
label_sound1:
    	SUB X3,X3,#1
    	CBNZ X3,label_sound1
        str W1,[X0,GPIO_GPCLR0]    // Clear GPIO18
    	mov X3,X10,lsl 0
	
label_sound2:
    	SUB X3,X3,#1
    	CBNZ X3,label_sound2
	SUB X4,X4,#1
    	CBNZ X4,make_sound2
    	RET

RESET:
	mov X12, 4 //para que vuelva empezar desde el comienzo
	mov x14, 2 //registo para resetear la cancion
	b infloop
	NOP

	//----------------------------------------------------------------------------------

CoreLoop:       // Infinite Loop For Core 1..3
  b CoreLoop

