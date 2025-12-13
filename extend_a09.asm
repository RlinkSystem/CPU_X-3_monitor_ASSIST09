********************************************************************************
* 
* This is a extension to Assist09 ROM
*
* Made for CPU X-3, by Roger Landen 2025-12-06
*
********************************************************************************

		ORG	EPROM_3
		Anrop	/INITEXTA09/
		BRA	*			; Mark it as ASSIST09 rom extension
; Assist09 have not done this yet
		JSR	[VECTAB+_CION,PCR]	; READY CONSOLE INPUT
		JSR	[VECTAB+_COON,PCR]	; READY CONSOLE OUTPUT

		LEAX	HELLO,PCR		; Get address to EPROM HELLO
		SWI				; a09
		FCB	PDATA			; PRINT CR,LF STRING
		LEAX	EXTEND09,PCR		; Extended SIGNON EYE-CATCHER
		SWI				; a09
		FCB	PDATA1			; PRINT STRING

		BSR	CHK309			; Check if 6809 | 6309
		BEQ	lbl6809
		LEAX	HD6309,PCR		; cpu 63C09
		BRA	lblcpuprt
lbl6809
		LEAX	MC6809,PCR		; cpu 6809
lblcpuprt
		SWI				; a09
		FCB	PDATA1			; PRINT STRING

		LEAX	CMDTBLext,PCR		; Extend CMD Table, with lower caps
		LDA	#_CMDL1			; CMDTL #2
		SWI
		FCB	VCTRSW

; We have to replace Assist09 Reset routin
		LEAS	STACK,PCR		; SETUP INITIAL STACK, Restore/Clear the stack

		Anrop	/RESET3/
		CLRA				;
		TFR	A,DP			; Default to PAGE ZERO
		LDA	#$FF			; A#0 OMIT CONSOLE INIT AND STARTUP MESSAGE
		SWI				; Perform MONITOR fireup
		FCB	MONITR			; To enter COMMAND processing
		BRA	RESET3			; reenter MONITOR if 'CONTINUE'


* - - - - - - - - - - - - - - - - - - - - - - - -
* Determine whether processor is 6309 or 6809
* Returns Z clear if 6309, set if 6809
* - - - - - - - - - - - - - - - - - - - - - - - -
CHK309		PSHS	D			; Save Reg-D
		FDB	$1043			; 6309 COMD instruction (COMA on 6809)
		CMPB	1,S			; not equal if 6309
		PULS	D,PC			; exit, restoring D

* - - - - - - - - - - - - - - - - - - - - - - - -
;-Delay
;-		PSHS    A,B
;-		LDD     #$2000
;-Loop1		SUBD    #1
;-		BNE     Loop1
;-		PULS    A,B,PC


********************************************************************************
* 
* Extende ROM <CMD>
*
********************************************************************************

********************************************************************************
*		BASIC INIT in ASSIST09
*---------------======================----------

		Anrop	/BASICINIT/

* - - - - - - - - - - - - - - - - - - - - - - - -
*	--------------------------------
*		Simple Memory test
*		To find memory Size/End
*	--------------------------------
		LDX	#MemTst			; Get Memory Test text
		LBSR	PUTSTR			; Console write str [direct io]

		LDY	#RAM			; First Memadr to test
TestMem
		LDA	#$5A			; tst pattern 1
		STA	,Y			; Store it
		CMPA	,Y
		BNE	NoMem			; Not the same 

		LDA	#$A5			; tst pattern 2
		STA	,Y			; Store it
		CMPA	,Y
		BNE	NoMem			; Not the same 

		LDA	#'X			; Save some prt char
		STA	,Y+

		TFR	Y,D			; Get Tested Address 
		BITB	#$3F
		BNE	NoPrt

		LDA	#CR
		JSR	PUTCHR			; Jump back on line
		TFR	Y,D
		LBSR	WriteHexWord		; Write the Testaddress

;-		LDB	PIA02_DataA		; get privous Status....
;-		INCB				; toggel status bit...
;-		STB	PIA02_DataA		; Status light

NoPrt		STY	RAMSIZE			; Save current good size
		CMPD	#MAXRAM			; Max memory address
		BEQ	NoMem			; At end of memory
		BRA	TestMem			; Test next address
NoMem						; No More MEM
		LDA	#CR
		JSR	PUTCHR			; Jump back on line
		TFR	Y,D
		LBSR	WriteHexWord		; Write the Testaddress
		LDX	#MemEnd			; Print that we ended the mem test
		LBSR	PUTSTR			; Console write str [direct io]


		LDA	#_ECHO		; Change the ECHO flag
		LDX	#$FF00		; No local echo on input
		SWI			; call assist09
		FCB	VCTRSW		; Change vectro value

		LBRA	BASIC		; Jump to BASIC now

MemTst		FCB	LF,CR,"0000 Memory",EOT
MemEnd		FCB	CR,LF,"OK!",CR,LF,EOT

***********************************************************************
*
*		WriteNibel
*		==========
*
*  Write out a nibel in Hex
*
*  Input:
*	A-acc the nibel
*
*  Destroy:
***********************************************************************

		Anrop	/WriteNibel/
		PSHS	A
		ANDA	#$0F		; Mask out the nibel
		ADDA	#$90		; Convert it to ascii char
		DAA
		ADCA	#$40
		DAA
		LBSR	PUTCHR		; Write it on the console
		PULS	A,PC

***********************************************************************
*
*		WriteHexByte
*		============
*
*  Write out a byte in Hex
*
*  Input:
*	A-acc the byte
*
*  Destroy:
***********************************************************************

		Anrop	/WriteHexByte/
		PSHS	CC,A
		PSHS	A
		LSRA			; Shift
		LSRA			;   down
		LSRA			;     high
		LSRA			;       nibel
		BSR	WriteNibel	; Write High Nibel
		PULS	A
		BSR	WriteNibel	; Write low Nibel
		PULS	CC,A,PC

***********************************************************************
*
*		WriteHexWord
*		============
*
*  Write out a Word in Hex
*
*  Input:
*	D-acc the word
*
*  Destroy:
***********************************************************************

		Anrop	/WriteHexWord/
		PSHS	CC,A,B
		LBSR	WriteHexByte		; Write High Byte
		TFR	B,A
		LBSR	WriteHexByte		; Write Low Byte
		PULS	CC,A,B,PC

*===============================================================================
* 		Data area
*===============================================================================
EXTEND09	FCC     /, With ROM Extension on /
                FCB     EOT,NUL		; SIGNON EYE-CATCHER
MC6809		FCB	"MC6809",EOT
HD6309		FCB	"HD63C09",EOT

* THIS IS a fix of DEFAULT COMMAND LIST ENTRY. Added lower caps fix

CMDTBLext	EQU	*		; MONITOR extended COMMAND TABLE
		FCB	4
		FCC	/b/		; 'BREAKPOINT' COMMAND
		FDB	CBKPT-*
		FCB	4
		FCC	/B/		; 'BREAKPOINT' COMMAND
		FDB	CBKPT-*
		FCB	4
		FCC	/c/		; 'CALL' COMMAND
		FDB	CCALL-*
		FCB	4
		FCC	/C/		; 'CALL' COMMAND
		FDB	CCALL-*
		FCB	4
		FCC	/d/		; 'DISPLAY' COMMAND
		FDB	CDISP-*
		FCB	4
		FCC	/D/		; 'DISPLAY' COMMAND
		FDB	CDISP-*
		FCB	4
		FCC	/e/		; 'ENCODE' COMMAND
		FDB	CENCDE-*
		FCB	4
		FCC	/E/		; 'ENCODE' COMMAND
		FDB	CENCDE-*
		FCB	4
		FCC	/g/		; 'GO' COMMAND
		FDB	CGO-*
		FCB	4
		FCC	/G/		; 'GO' COMMAND
		FDB	CGO-*
		FCB	4
		FCC	/l/		; 'LOAD' COMMAND
		FDB	CLOAD-*
		FCB	4
		FCC	/L/		; 'LOAD' COMMAND
		FDB	CLOAD-*
		FCB	4
		FCC	/m/		; 'MEMORY' COMMAND
		FDB	CMEM-*
		FCB	4
		FCC	/M/		; 'MEMORY' COMMAND
		FDB	CMEM-*
		FCB	4
		FCC	/n/		; 'NULLS' COMMAND
		FDB	CNULLS-*
		FCB	4
		FCC	/N/		; 'NULLS' COMMAND
		FDB	CNULLS-*
		FCB	4
		FCC	/o/		; 'OFFSET' COMMAND
		FDB	COFFS-*
		FCB	4
		FCC	/O/		; 'OFFSET' COMMAND
		FDB	COFFS-*
		FCB	4
		FCC	/p/		; 'PUNCH' COMMAND
		FDB	CPUNCH-*
		FCB	4
		FCC	/P/		; 'PUNCH' COMMAND
		FDB	CPUNCH-*
		FCB	4
		FCC	/r/		; 'REGISTERS' COMMAND
		FDB	CREG-*
		FCB	4
		FCC	/R/		; 'REGISTERS' COMMAND
		FDB	CREG-*
		FCB	4
		FCC	/s/		; 'STLEVEL' COMMAND
		FDB	CSTLEV-*
		FCB	4
		FCC	/S/		; 'STLEVEL' COMMAND
		FDB	CSTLEV-*
		FCB	4
		FCC	/t/		; 'TRACE' COMMAND
		FDB	CTRACE-*
		FCB	4
		FCC	/T/		; 'TRACE' COMMAND
		FDB	CTRACE-*
		FCB	4
		FCC	/v/		; 'VERIFY' COMMAND
		FDB	CVER-*
		FCB	4
		FCC	/V/		; 'VERIFY' COMMAND
		FDB	CVER-*
		FCB	4
		FCC	/w/		; 'WINDOW' COMMAND
		FDB	CWINDO-*
		FCB	4
		FCC	/W/		; 'WINDOW' COMMAND
		FDB	CWINDO-*
		FCB	8
		FCC	/basic/		; Init and jump to Tiny Basic
		FDB	BASICINIT-*
		FCB	8
		FCC	/BASIC/		; Init and jump to Tiny Basic
		FDB	BASICINIT-*
		FCB	-1		; END, CONTINUE WITH THE SECOND
