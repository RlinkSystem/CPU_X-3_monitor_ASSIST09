***********************************************************************
*
*             CC-flags Definitions for MC6809
*
* 2021. Roger Landen                                    { ccflags.asm }
***********************************************************************

*--- Condition Code flags ---

CC_E	EQU	%10000000	; Entire Flag
CC_F	EQU	%01000000	; FIRQ Mask 
CC_H	EQU	%00100000	; Half Carry
CC_I	EQU	%00010000	; IRQ Mask
CC_N	EQU	%00001000	; Negative
CC_Z	EQU	%00000100	; Zero
CC_O	EQU	%00000010	; Overflow
CC_C	EQU	%00000001	; Carry

CC_EntireFlag	EQU	CC_E
CC_FIRQmask	EQU	CC_F
CC_HalfCarry	EQU	CC_H
CC_IRQmask	EQU	CC_I
CC_Negative	EQU	CC_N
CC_Zero		EQU	CC_Z
CC_Overflow	EQU	CC_O
CC_Carry	EQU	CC_C

SET_EntireFlag	EQU	CC_E		; $80
SET_FIRQmask	EQU	CC_F		; $40
SET_HalfCarry	EQU	CC_H		; $20
SET_IRQmask	EQU	CC_I		; $10
SET_Negative	EQU	CC_N		; $08
SET_Zero	EQU	CC_Z		; $04
SET_Overflow	EQU	CC_O		; $02
SET_Carry	EQU	CC_C		; $01

CLR_EntireFlag	EQU	~CC_E		; $7F
CLR_FIRQmask	EQU	~CC_F		; $BF
CLR_HalfCarry	EQU	~CC_H		; $DF
CLR_IRQmask	EQU	~CC_I		; $EF
CLR_Negative	EQU	~CC_N		; $F7
CLR_Zero	EQU	~CC_Z		; $FB
CLR_Overflow	EQU	~CC_O		; $FD
CLR_Carry	EQU	~CC_C		; $FE

*-----------------------------
