***********************************************************************
*
*		CXCMD, CPU X-3 Command Monitor
*
*		Constant Definitions for CPU X-3	Version 3.02
*
* (c) Copyright 1987,1995,2025. Roger Landen		{ MPXDEF.ASM }
***********************************************************************

*=============  Address in CPUX3  ===============
RAM		EQU	$0000			; Start of RAM area
CLRRAM		EQU	$DF00			; Start of Monitor system RAM area To CLEAR
SYSMEMend	EQU	$DFFF			; The end of Monitor System Memory
SYSMEMlen	EQU	$0BFF			; Total Size 3K, 0-3071
SYSMEMbeg	EQU	SYSMEMend-SYSMEMlen	; Start Address of Monitor System Memory
SYSRAM		EQU	SYSMEMend & $FF00	; Start of Monitor SYStem [DP] RAM area
CXCMD_DP	EQU	SYSRAM>>8		; CXCMD [DP] {zero} page # in RAM
RESET_STACK	EQU	SYSRAM			; Stack pointer for RESET until memtest is done
SYSSTACK	EQU	SYSMEMbeg+$0400		; Stack pointer in System Memory (reservd size of 1K)
MAXRAM		EQU	$BFFF			; The Designed max Memory address
EPROM_X		EQU	$C000			; Start of Extra EPROM area
EPROM		EQU	$E000			; Start of EPROM area
EPROM_2		EQU	$E800			; Start of EPROM area 2K #2
EPROM_3		EQU	$F000			; Start of EPROM area 2K #3
EPROM_4		EQU	$F800			; Start of EPROM area 2K #4
						; UTILS Function JUMP Tabel
EPROM_firq	EQU	EPROM+$80		; Start of EPROM FIRQ code area
EPROM_irq	EQU	EPROM+$100		; Start of EPROM IRQ code area
EPROM_nmi	EQU	EPROM+$180		; Start of EPROM NMI code area
EPROM_code	EQU	EPROM+$200		; Start of EPROM CODE area

CODEINT		EQU	$FF00			; [Interupt] Jump Table
CODEVECTOR	EQU	$FFF0			; CPU HW [Interupt] Vector list

*=============  IO-devices CPUX3  ===============

*-------------  TIMER PTM01  --------------------
TIMER		EQU	$D028			; Timer, Baud rate generators. Rev 3
TimerControl31	EQU	TIMER			; Timer control register 3 or 1
TimerControl2	EQU	TIMER+1			; Timer control register 2
Timer_1		EQU	TIMER+2			; Timer #1 High Byte
Timer_1L	EQU	TIMER+3			; Timer #1 Low  Byte
Timer_2		EQU	TIMER+4			; Timer #2 High Byte
Timer_2L	EQU	TIMER+5			; Timer #2 Low  Byte
Timer_3		EQU	TIMER+6			; Timer #3 High Byte
Timer_3L	EQU	TIMER+7			; Timer #3 Low  Byte

*-------------  ACIA MC6850 Status flags  -------
RDRFm		EQU	%00000001		; Receive Data Register Full	MC6850
TDREm		EQU	%00000010		; Transmit Data Register Empty	MC6850
FERRm		EQU	%00010000		; Framing Error			MC6850

*------------------------------------------------

* Rev 3
*-------------  Serial ACIA1  -------------------
ACIA01_Status	EQU	$D006			; Status register ACIA 01
ACIA01_Data	EQU	$D007			; Data   register ACIA 01
*
*-------------  Serial ACIA2  -------------------
ACIA02_Status	EQU	$D016			; Status register ACIA 02
ACIA02_Data	EQU	$D017			; Data   register ACIA 02
*
*-------------  ACIA R6551 Status flags---------
RDRFr		EQU	%00001000		; Receive Data Register Full	R6551
TDREr		EQU	%00010000		; Transmit Data Register Empty	R6551
FERRr		EQU	%00000010		; Framing Error			R6551
*
*-------------  Serial R6551  -------------------
R6551		EQU	$D034			; Rockwell ACIA 6551	Rev 3
R6551data	EQU	R6551			; Transmit / Receiver Data Register
R6551status	EQU	R6551+1			; Prog Reset / Status Register
R6551cmd	EQU	R6551+2			; Command Register
R6551ctrl	EQU	R6551+3			; Control Register

*------------------------------------------------

* Rev 3
* PIAs registers
* RS0 => A0
* RS1 => A1
*-------------  Peripheral PIA01  ---------------
PIA01_DataA	EQU	$D04C			; PIA 01 Data register A
PIA01_CtrlA	EQU	$D04D			; PIA 01 Control register A
PIA01_DataB	EQU	$D04E			; PIA 01 Data register B
PIA01_CtrlB	EQU	$D04F			; PIA 01 Control register B
* PIA01_DataDir	EQU	$D04C			; PIA 01 Data direction register A/B(+1)
* PIA01_Control	EQU	$D04E			; PIA 01 Control register A/B(+1)

*-------------  Peripheral PIA02  ---------------
PIA02_DataA	EQU	$D05C			; PIA 02 Data register A
PIA02_CtrlA	EQU	$D05D			; PIA 02 Control register A
PIA02_DataB	EQU	$D05E			; PIA 02 Data register B
PIA02_CtrlB	EQU	$D05F			; PIA 02 Control register B
* PIA02_DataDir	EQU	$D05C			; PIA 02 Data direction register A/B(+1)
* PIA02_Control	EQU	$D05E			; PIA 02 Control register A/B(+1)

*-------------  Peripheral PIA03  ---------------
PIA03_DataA	EQU	$D06C			; PIA 03 Data register A
PIA03_CtrlA	EQU	$D06D			; PIA 03 Control register A
PIA03_DataB	EQU	$D06E			; PIA 03 Data register B
PIA03_CtrlB	EQU	$D06F			; PIA 03 Control register B
* PIA03_DataDir	EQU	$D06C			; PIA 03 Data direction register A/B(+1)
* PIA03_Control	EQU	$D06E			; PIA 03 Control register A/B(+1)

*------------------------------------------------
