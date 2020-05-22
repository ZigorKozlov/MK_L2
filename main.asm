;Lab2 MK Main

#INCLUDE <P16F877A.INC>

;Rename of Registers
COUNT   	EQU 20h
COUNT1  	EQU 21h
COUNT2  	EQU 22h
ChoiceSpeed EQU 23h
;

		ORG 0

START:  BSF STATUS,RP0; Choice first page of memofy
		CLRF TRISD ; Register D is Data OutPut

		BCF TRISB, 6; OUTPUT 3 button - for inverse
		BCF TRISB, 5; OUTPUT 2 button - for SET FAST SPEED
		BCF TRISB, 4; OUTPUT 1 button - for SET SLOW SPEED


		BCF STATUS,RP0 ; Return at zero page
		CLRF PORTD ; Zeroing port D: 0000 0000

		MOVLW 0x5 ;5 - fast by default (15 - slow)
		MOVWF ChoiceSpeed

	RUN:
		; 6 BIT - INVERSE, 4 - SET FAST SPEED, 5 - SET SLOW SPEED
		BSF PORTB, 6; bit = 1 
		BTFSS PORTB, 6;if 6 bit = 0 then execution Mig
		CALL MigINV
		
		BSF PORTB, 6; bit = 1 
		BTFSC PORTB, 6;if 6 bit = 1 then execution MigINV
		CALL Mig
adad
		GOTO RUN
		

Mig:	;3,4
		BSF PORTD,3 ; Set 1 in 3 bit 0000 1000
		BSF PORTD,4 ; Set 1 in 4 bit 0001 1000

	CALL DELAY

		BCF PORTD,3 ; Set 0 in 3 bit 0001 0000
		BCF PORTD,4 ; Set 0 in 4 bit 0001 0000

	;2,5
	CALL DELAY

		BSF PORTD,2 ; Set 1 in 2 bit 0000 0100
		BSF PORTD,5 ; Set 1 in 5 bit 0010 0100

	CALL DELAY

		BCF PORTD,2 ; Set 0 in 2 bit 0010 0000
		BCF PORTD,5 ; Set 0 in 5 bit 0000 0000

	CALL DELAY

	;1,6
		BSF PORTD,1 ; Set 1 in 1 bit 0000 0010
		BSF PORTD,6 ; Set 1 in 6 bit 0100 0010

	CALL DELAY
	
		BCF PORTD,1 ; Set 0 in 1 bit 0100 0000
		BCF PORTD,6 ; Set 0 in 6 bit 0000 0000

	CALL DELAY

	;0,7
		BSF PORTD,0 ; Set 1 in 0 bit 0000 0001
		BSF PORTD,7 ; Set 1 in 7 bit 1000 0001

	CALL DELAY

		BCF PORTD,0 ; Set 0 in 0 bit 1000 0000
		BCF PORTD,7 ; Set 1 in 7 bit 0000 0000

	CALL DELAY

RETURN


MigINV: ;0,7
		BSF PORTD,0 ; Set 1 in 0 bit 0000 0001
		BSF PORTD,7 ; Set 1 in 7 bit 1000 0001

	CALL DELAY

		BCF PORTD,0 ; Set 0 in 0 bit 1000 0000
		BCF PORTD,7 ; Set 1 in 7 bit 0000 0000

	CALL DELAY

		;1,6
		BSF PORTD,1 ; Set 1 in 1 bit 0000 0010
		BSF PORTD,6 ; Set 1 in 6 bit 0100 0010

	CALL DELAY

		BCF PORTD,1 ; Set 0 in 1 bit 0100 0000
		BCF PORTD,6 ; Set 0 in 6 bit 0000 0000

	CALL DELAY

		;2, 5
		BSF PORTD,2 ; Set 1 in 2 bit 0000 0100
		BSF PORTD,5 ; Set 1 in 5 bit 0010 0100

	CALL DELAY

		BCF PORTD,2 ; Set 0 in 2 bit 0010 0000
		BCF PORTD,5 ; Set 0 in 5 bit 0000 0000

	CALL DELAY

		;3,4
		BSF PORTD,3 ; Set 1 in 3 bit 0000 1000
		BSF PORTD,4 ; Set 1 in 4 bit 0001 1000

	CALL DELAY

		BCF PORTD,3 ; Set 0 in 3 bit 0001 0000
		BCF PORTD,4 ; Set 0 in 4 bit 0001 0000

	CALL DELAY

RETURN

;DElAYS

DELAY:  
		 BSF PORTB, 4; bit = 1 
		BTFSS PORTB, 4 ; change to FAST
		CALL FAST
		
	        BSF PORTB, 5; bit = 1 
		BTFSS PORTB, 5 ; change to SLOW
		CALL SLOW
		
		MOVFW ChoiceSpeed
		MOVWF COUNT	

	LOOP:	CALL DELAY1
			DECFSZ COUNT, F
	GOTO LOOP

RETURN

DELAY1: MOVLW 0xFF
		MOVWF COUNT1

	LOOP1: CALL DELAY2
		DECFSZ COUNT1, F
	GOTO LOOP1

RETURN

DELAY2: MOVLW 0xFF
		MOVWF COUNT2

	LOOP2: NOP
		DECFSZ COUNT2, F
	GOTO LOOP2

RETURN
;

choiceSPEED
FAST:	MOVLW 0x5 ;5 - fast by befault (15 - slow)
		MOVWF ChoiceSpeed
RETURN


SLOW:	MOVLW 0xF ;5 - fast by befault (15 - slow)
		MOVWF ChoiceSpeed
RETURN

;
END