
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _rx_wr_index=R5
	.DEF _rx_rd_index=R4
	.DEF _rx_counter=R7
	.DEF _tx_wr_index=R6
	.DEF _tx_rd_index=R9
	.DEF _tx_counter=R8
	.DEF __lcd_x=R11
	.DEF __lcd_y=R10
	.DEF __lcd_maxx=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  _usart_tx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G103:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G103:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x20003:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_0x20021:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0
_0x20000:
	.DB  0x70,0x61,0x72,0x74,0x20,0x32,0x20,0x69
	.DB  0x73,0x20,0x72,0x75,0x6E,0x6E,0x69,0x6E
	.DB  0x67,0x21,0xD,0x0,0xD,0x54,0x78,0x3A
	.DB  0x0,0xD,0x52,0x78,0x3A,0x20,0x44,0x61
	.DB  0x74,0x61,0x3D,0x25,0x64,0x20,0x61,0x6E
	.DB  0x64,0x20,0x31,0x30,0x2A,0x44,0x61,0x74
	.DB  0x61,0x3D,0x25,0x64,0x20,0xD,0x0,0x54
	.DB  0x78,0x3A,0x20,0x25,0x64,0x0,0x52,0x78
	.DB  0x3A,0x20,0x44,0x61,0x74,0x61,0x3D,0x25
	.DB  0x64,0x20,0x61,0x6E,0x64,0x20,0x31,0x30
	.DB  0x2A,0x44,0x61,0x74,0x61,0x3D,0x25,0x64
	.DB  0x0,0x4C,0x43,0x44,0x20,0x64,0x65,0x6C
	.DB  0x65,0x74,0x65,0x0,0xD,0x4C,0x43,0x44
	.DB  0x20,0x64,0x65,0x6C,0x65,0x74,0x65,0xD
	.DB  0x0,0xD,0x54,0x68,0x69,0x73,0x20,0x69
	.DB  0x73,0x20,0x41,0x5A,0x37,0x20,0x6F,0x66
	.DB  0x20,0x4D,0x69,0x63,0x72,0x6F,0x70,0x72
	.DB  0x6F,0x63,0x65,0x73,0x73,0x6F,0x72,0x20
	.DB  0x4C,0x61,0x62,0x20,0x61,0x74,0x20,0x49
	.DB  0x55,0x54,0xD,0x0,0x54,0x68,0x69,0x73
	.DB  0x20,0x69,0x73,0x20,0x41,0x5A,0x37,0x20
	.DB  0x6F,0x66,0x20,0x4D,0x69,0x63,0x72,0x6F
	.DB  0x70,0x72,0x6F,0x63,0x65,0x73,0x73,0x6F
	.DB  0x72,0x20,0x4C,0x61,0x62,0x20,0x61,0x74
	.DB  0x20,0x49,0x55,0x54,0x0,0xD,0x52,0x78
	.DB  0x3A,0x20,0x45,0x4E,0x44,0x20,0x6F,0x66
	.DB  0x20,0x74,0x68,0x69,0x73,0x20,0x70,0x61
	.DB  0x72,0x74,0xD,0x0,0x52,0x78,0x3A,0x20
	.DB  0x45,0x4E,0x44,0x20,0x6F,0x66,0x20,0x74
	.DB  0x68,0x69,0x73,0x20,0x70,0x61,0x72,0x74
	.DB  0x0,0xD,0x52,0x78,0x3A,0x20,0x69,0x6E
	.DB  0x70,0x75,0x74,0x20,0x6C,0x65,0x74,0x74
	.DB  0x65,0x72,0x20,0x69,0x73,0x20,0x0,0x54
	.DB  0x78,0x3A,0x20,0x25,0x63,0x0,0x52,0x78
	.DB  0x3A,0x20,0x69,0x6E,0x70,0x75,0x74,0x20
	.DB  0x6C,0x65,0x74,0x74,0x65,0x72,0x20,0x69
	.DB  0x73,0x20,0x22,0x25,0x63,0x22,0x20,0x0
	.DB  0xD,0x50,0x61,0x72,0x74,0x20,0x32,0x20
	.DB  0x69,0x73,0x20,0x65,0x6E,0x64,0x69,0x6E
	.DB  0x67,0x21,0xD,0x0,0x70,0x61,0x72,0x74
	.DB  0x20,0x33,0x20,0x69,0x73,0x20,0x72,0x75
	.DB  0x6E,0x6E,0x69,0x6E,0x67,0x21,0xD,0x0
	.DB  0xD,0x46,0x72,0x61,0x6D,0x65,0x20,0x6D
	.DB  0x75,0x73,0x74,0x20,0x62,0x65,0x20,0x35
	.DB  0x20,0x69,0x6E,0x74,0x65,0x67,0x65,0x72
	.DB  0xD,0x0,0x46,0x72,0x61,0x6D,0x65,0x20
	.DB  0x6D,0x75,0x73,0x74,0x20,0x62,0x65,0x20
	.DB  0x35,0x20,0x69,0x6E,0x74,0x65,0x67,0x65
	.DB  0x72,0x0,0xD,0x49,0x6E,0x63,0x6F,0x72
	.DB  0x72,0x65,0x63,0x74,0x20,0x66,0x72,0x61
	.DB  0x6D,0x65,0x20,0x73,0x69,0x7A,0x65,0x2E
	.DB  0xD,0x0,0x49,0x6E,0x63,0x6F,0x72,0x72
	.DB  0x65,0x63,0x74,0x20,0x66,0x72,0x61,0x6D
	.DB  0x65,0x20,0x73,0x69,0x7A,0x65,0x2E,0x0
	.DB  0xD,0x54,0x68,0x65,0x20,0x66,0x72,0x61
	.DB  0x6D,0x65,0x20,0x69,0x73,0x20,0x63,0x6F
	.DB  0x72,0x72,0x65,0x63,0x74,0xD,0x0,0x54
	.DB  0x68,0x65,0x20,0x66,0x72,0x61,0x6D,0x65
	.DB  0x20,0x69,0x73,0x20,0x63,0x6F,0x72,0x72
	.DB  0x65,0x63,0x74,0x0,0xD,0x50,0x61,0x72
	.DB  0x74,0x20,0x33,0x20,0x69,0x73,0x20,0x65
	.DB  0x6E,0x64,0x69,0x6E,0x67,0x21,0x0
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2040003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x06
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x14
	.DW  _0x20004
	.DW  _0x20000*2

	.DW  0x05
	.DW  _0x20004+20
	.DW  _0x20000*2+20

	.DW  0x0B
	.DW  _0x20004+25
	.DW  _0x20000*2+89

	.DW  0x0D
	.DW  _0x20004+36
	.DW  _0x20000*2+100

	.DW  0x2B
	.DW  _0x20004+49
	.DW  _0x20000*2+113

	.DW  0x29
	.DW  _0x20004+92
	.DW  _0x20000*2+156

	.DW  0x17
	.DW  _0x20004+133
	.DW  _0x20000*2+197

	.DW  0x15
	.DW  _0x20004+156
	.DW  _0x20000*2+220

	.DW  0x05
	.DW  _0x20004+177
	.DW  _0x20000*2+20

	.DW  0x16
	.DW  _0x20004+182
	.DW  _0x20000*2+241

	.DW  0x02
	.DW  _0x20004+204
	.DW  _0x20000*2+18

	.DW  0x14
	.DW  _0x20004+206
	.DW  _0x20000*2+296

	.DW  0x14
	.DW  _0x20022
	.DW  _0x20000*2+316

	.DW  0x05
	.DW  _0x20022+20
	.DW  _0x20000*2+20

	.DW  0x1A
	.DW  _0x20022+25
	.DW  _0x20000*2+336

	.DW  0x18
	.DW  _0x20022+51
	.DW  _0x20000*2+362

	.DW  0x05
	.DW  _0x20022+75
	.DW  _0x20000*2+20

	.DW  0x18
	.DW  _0x20022+80
	.DW  _0x20000*2+386

	.DW  0x04
	.DW  _0x20022+104
	.DW  _0x20000*2+21

	.DW  0x16
	.DW  _0x20022+108
	.DW  _0x20000*2+410

	.DW  0x05
	.DW  _0x20022+130
	.DW  _0x20000*2+20

	.DW  0x17
	.DW  _0x20022+135
	.DW  _0x20000*2+432

	.DW  0x04
	.DW  _0x20022+158
	.DW  _0x20000*2+21

	.DW  0x15
	.DW  _0x20022+162
	.DW  _0x20000*2+455

	.DW  0x13
	.DW  _0x20022+183
	.DW  _0x20000*2+476

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

	.DW  0x02
	.DW  __base_y_G102
	.DW  _0x2040003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;
;#include <header.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#define DATA_REGISTER_EMPTY (1 << UDRE)
;#define RX_COMPLETE (1 << RXC)
;#define FRAMING_ERROR (1 << FE)
;#define PARITY_ERROR (1 << UPE)
;#define DATA_OVERRUN (1 << DOR)
;
;#define RX_BUFFER_SIZE 8
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE <= 256
;unsigned char rx_wr_index = 0, rx_rd_index = 0;
;#else
;unsigned int rx_wr_index = 0, rx_rd_index = 0;
;#endif
;
;#if RX_BUFFER_SIZE < 256
;unsigned char rx_counter = 0;
;#else
;unsigned int rx_counter = 0;
;#endif
;
;bit rx_buffer_overflow;
;
;interrupt[USART_RXC] void usart_rx_isr(void)
; 0000 001B {

	.CSEG
_usart_rx_isr:
; .FSTART _usart_rx_isr
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 001C    char status, data;
; 0000 001D    status = UCSRA;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	IN   R17,11
; 0000 001E    data = UDR;
	IN   R16,12
; 0000 001F    if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN)) == 0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x3
; 0000 0020    {
; 0000 0021       rx_buffer[rx_wr_index++] = data;
	MOV  R30,R5
	INC  R5
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0000 0022 #if RX_BUFFER_SIZE == 256
; 0000 0023       if (++rx_counter == 0)
; 0000 0024          rx_buffer_overflow = 1;
; 0000 0025 #else
; 0000 0026       if (rx_wr_index == RX_BUFFER_SIZE)
	LDI  R30,LOW(8)
	CP   R30,R5
	BRNE _0x4
; 0000 0027          rx_wr_index = 0;
	CLR  R5
; 0000 0028       if (++rx_counter == RX_BUFFER_SIZE)
_0x4:
	INC  R7
	LDI  R30,LOW(8)
	CP   R30,R7
	BRNE _0x5
; 0000 0029       {
; 0000 002A          rx_counter = 0;
	CLR  R7
; 0000 002B          rx_buffer_overflow = 1;
	SET
	BLD  R2,0
; 0000 002C       }
; 0000 002D #endif
; 0000 002E    }
_0x5:
; 0000 002F }
_0x3:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0x18
; .FEND
;
;#ifndef _DEBUG_TERMINAL_IO_
;#pragma used +
;char getchar_nv(void)
; 0000 0034 {
_getchar_nv:
; .FSTART _getchar_nv
; 0000 0035    char data;
; 0000 0036    while (rx_counter == 0)
	ST   -Y,R17
;	data -> R17
_0x6:
	TST  R7
	BREQ _0x6
; 0000 0037       ;
; 0000 0038    data = rx_buffer[rx_rd_index++];
	MOV  R30,R4
	INC  R4
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	LD   R17,Z
; 0000 0039 #if RX_BUFFER_SIZE != 256
; 0000 003A    if (rx_rd_index == RX_BUFFER_SIZE)
	LDI  R30,LOW(8)
	CP   R30,R4
	BRNE _0x9
; 0000 003B       rx_rd_index = 0;
	CLR  R4
; 0000 003C #endif
; 0000 003D #asm("cli")
_0x9:
	cli
; 0000 003E    --rx_counter;
	DEC  R7
; 0000 003F #asm("sei")
	sei
; 0000 0040    return data;
	MOV  R30,R17
	LD   R17,Y+
	RET
; 0000 0041 }
; .FEND
;#pragma used -
;#endif
;
;#define TX_BUFFER_SIZE 8
;char tx_buffer[TX_BUFFER_SIZE];
;
;#if TX_BUFFER_SIZE <= 256
;unsigned char tx_wr_index = 0, tx_rd_index = 0;
;#else
;unsigned int tx_wr_index = 0, tx_rd_index = 0;
;#endif
;
;#if TX_BUFFER_SIZE < 256
;unsigned char tx_counter = 0;
;#else
;unsigned int tx_counter = 0;
;#endif
;
;interrupt[USART_TXC] void usart_tx_isr(void)
; 0000 0055 {
_usart_tx_isr:
; .FSTART _usart_tx_isr
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0056    if (tx_counter)
	TST  R8
	BREQ _0xA
; 0000 0057    {
; 0000 0058       --tx_counter;
	DEC  R8
; 0000 0059       UDR = tx_buffer[tx_rd_index++];
	MOV  R30,R9
	INC  R9
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R30,Z
	OUT  0xC,R30
; 0000 005A #if TX_BUFFER_SIZE != 256
; 0000 005B       if (tx_rd_index == TX_BUFFER_SIZE)
	LDI  R30,LOW(8)
	CP   R30,R9
	BRNE _0xB
; 0000 005C          tx_rd_index = 0;
	CLR  R9
; 0000 005D #endif
; 0000 005E    }
_0xB:
; 0000 005F }
_0xA:
_0x18:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;
;#ifndef _DEBUG_TERMINAL_IO_
;#pragma used +
;void putchar_nv(char c)
; 0000 0064 {
; 0000 0065    while (tx_counter == TX_BUFFER_SIZE)
;	c -> Y+0
; 0000 0066       ;
; 0000 0067 #asm("cli")
; 0000 0068    if (tx_counter || ((UCSRA & DATA_REGISTER_EMPTY) == 0))
; 0000 0069    {
; 0000 006A       tx_buffer[tx_wr_index++] = c;
; 0000 006B #if TX_BUFFER_SIZE != 256
; 0000 006C       if (tx_wr_index == TX_BUFFER_SIZE)
; 0000 006D          tx_wr_index = 0;
; 0000 006E #endif
; 0000 006F       ++tx_counter;
; 0000 0070    }
; 0000 0071    else
; 0000 0072       UDR = c;
; 0000 0073 #asm("sei")
; 0000 0074 }
;#pragma used -
;#endif
;
;void main(void)
; 0000 0079 {
_main:
; .FSTART _main
; 0000 007A    init();
	RCALL _init
; 0000 007B    q2();
	RCALL _q2
; 0000 007C    q3();
	RCALL _q3
; 0000 007D    while (1)
_0x14:
; 0000 007E    {
; 0000 007F    }
	RJMP _0x14
; 0000 0080 }
_0x17:
	RJMP _0x17
; .FEND
;#include <header.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;void q2()
; 0001 0004 {

	.CSEG
_q2:
; .FSTART _q2
; 0001 0005     unsigned char string[10] = "";
; 0001 0006     unsigned char gt ='';
; 0001 0007     int dig = 0;
; 0001 0008     puts("part 2 is running!\r");
	SBIW R28,10
	LDI  R24,10
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x20003*2)
	LDI  R31,HIGH(_0x20003*2)
	CALL __INITLOCB
	CALL __SAVELOCR4
;	string -> Y+4
;	gt -> R17
;	dig -> R18,R19
	LDI  R17,0
	__GETWRN 18,19,0
	__POINTW2MN _0x20004,0
	CALL _puts
; 0001 0009 
; 0001 000A     gt = getchar_nv();
	RCALL _getchar_nv
	MOV  R17,R30
; 0001 000B     if (gt == '0')
	CPI  R17,48
	BRNE _0x20005
; 0001 000C     {
; 0001 000D         dig = 0;
	__GETWRN 18,19,0
; 0001 000E     }
; 0001 000F     else if (gt == '1')
	RJMP _0x20006
_0x20005:
	CPI  R17,49
	BRNE _0x20007
; 0001 0010     {
; 0001 0011         dig = 1;
	__GETWRN 18,19,1
; 0001 0012     }
; 0001 0013     else if (gt == '2')
	RJMP _0x20008
_0x20007:
	CPI  R17,50
	BRNE _0x20009
; 0001 0014     {
; 0001 0015         dig = 2;
	__GETWRN 18,19,2
; 0001 0016     }
; 0001 0017     else if (gt == '3')
	RJMP _0x2000A
_0x20009:
	CPI  R17,51
	BRNE _0x2000B
; 0001 0018     {
; 0001 0019         dig = 3;
	__GETWRN 18,19,3
; 0001 001A     }
; 0001 001B     else if (gt == '4')
	RJMP _0x2000C
_0x2000B:
	CPI  R17,52
	BRNE _0x2000D
; 0001 001C     {
; 0001 001D         dig = 4;
	__GETWRN 18,19,4
; 0001 001E     }
; 0001 001F     else if (gt == '5')
	RJMP _0x2000E
_0x2000D:
	CPI  R17,53
	BRNE _0x2000F
; 0001 0020     {
; 0001 0021         dig = 5;
	__GETWRN 18,19,5
; 0001 0022     }
; 0001 0023     else if (gt == '6')
	RJMP _0x20010
_0x2000F:
	CPI  R17,54
	BRNE _0x20011
; 0001 0024     {
; 0001 0025         dig = 6;
	__GETWRN 18,19,6
; 0001 0026     }
; 0001 0027     else if (gt == '7')
	RJMP _0x20012
_0x20011:
	CPI  R17,55
	BRNE _0x20013
; 0001 0028     {
; 0001 0029         dig = 7;
	__GETWRN 18,19,7
; 0001 002A     }
; 0001 002B     else if (gt == '8')
	RJMP _0x20014
_0x20013:
	CPI  R17,56
	BRNE _0x20015
; 0001 002C     {
; 0001 002D         dig = 8;
	__GETWRN 18,19,8
; 0001 002E     }
; 0001 002F     else if (gt == '9')
	RJMP _0x20016
_0x20015:
	CPI  R17,57
	BRNE _0x20017
; 0001 0030     {
; 0001 0031         dig = 9;
	__GETWRN 18,19,9
; 0001 0032     }
; 0001 0033     else
	RJMP _0x20018
_0x20017:
; 0001 0034     {
; 0001 0035         dig = 11;
	__GETWRN 18,19,11
; 0001 0036     }
_0x20018:
_0x20016:
_0x20014:
_0x20012:
_0x20010:
_0x2000E:
_0x2000C:
_0x2000A:
_0x20008:
_0x20006:
; 0001 0037 
; 0001 0038     if (dig < 10)
	__CPWRN 18,19,10
	BRGE _0x20019
; 0001 0039     {
; 0001 003A         puts("\rTx:");
	__POINTW2MN _0x20004,20
	CALL _puts
; 0001 003B         putchar(gt);
	MOV  R26,R17
	CALL _putchar
; 0001 003C         sprintf(string, "\rRx: Data=%d and 10*Data=%d \r", dig, 10 * dig);
	CALL SUBOPT_0x0
	__POINTW1FN _0x20000,25
	CALL SUBOPT_0x1
	CALL SUBOPT_0x2
; 0001 003D 
; 0001 003E         puts(string);
	MOVW R26,R28
	ADIW R26,4
	CALL SUBOPT_0x3
; 0001 003F         lcd_clear();
; 0001 0040         sprintf(string, "Tx: %d", dig);
	CALL SUBOPT_0x0
	__POINTW1FN _0x20000,55
	CALL SUBOPT_0x1
	CALL SUBOPT_0x4
; 0001 0041         lcd_puts(string);
; 0001 0042         sprintf(string, "Rx: Data=%d and 10*Data=%d", dig, 10 * dig);
	__POINTW1FN _0x20000,62
	CALL SUBOPT_0x1
	CALL SUBOPT_0x2
; 0001 0043         lcd_gotoxy(0, 1);
	RJMP _0x20032
; 0001 0044         lcd_puts(string);
; 0001 0045     }
; 0001 0046 
; 0001 0047     else if (gt == 'D')
_0x20019:
	CPI  R17,68
	BRNE _0x2001B
; 0001 0048     {
; 0001 0049         lcd_clear();
	CALL _lcd_clear
; 0001 004A         lcd_puts("LCD delete");
	__POINTW2MN _0x20004,25
	CALL _lcd_puts
; 0001 004B         puts("\rLCD delete\r");
	__POINTW2MN _0x20004,36
	CALL _puts
; 0001 004C     }
; 0001 004D 
; 0001 004E     else if (gt == 'H')
	RJMP _0x2001C
_0x2001B:
	CPI  R17,72
	BRNE _0x2001D
; 0001 004F     {
; 0001 0050         puts("\rThis is AZ7 of Microprocessor Lab at IUT\r");
	__POINTW2MN _0x20004,49
	CALL SUBOPT_0x3
; 0001 0051         lcd_clear();
; 0001 0052         lcd_puts("This is AZ7 of Microprocessor Lab at IUT");
	__POINTW2MN _0x20004,92
	RJMP _0x20033
; 0001 0053     }
; 0001 0054 
; 0001 0055     else if (gt == 'E')
_0x2001D:
	CPI  R17,69
	BRNE _0x2001F
; 0001 0056     {
; 0001 0057         puts("\rRx: END of this part\r");
	__POINTW2MN _0x20004,133
	CALL SUBOPT_0x3
; 0001 0058         lcd_clear();
; 0001 0059         lcd_puts("Rx: END of this part");
	__POINTW2MN _0x20004,156
	CALL _lcd_puts
; 0001 005A         return;
	RJMP _0x20C0004
; 0001 005B     }
; 0001 005C     else
_0x2001F:
; 0001 005D     {
; 0001 005E         puts("\rTx:");
	__POINTW2MN _0x20004,177
	CALL _puts
; 0001 005F         putchar(gt);
	MOV  R26,R17
	CALL _putchar
; 0001 0060         puts("\rRx: input letter is ");
	__POINTW2MN _0x20004,182
	CALL _puts
; 0001 0061         putchar('\"');
	LDI  R26,LOW(34)
	CALL _putchar
; 0001 0062         putchar(gt);
	MOV  R26,R17
	CALL _putchar
; 0001 0063         putchar('\"');
	LDI  R26,LOW(34)
	CALL _putchar
; 0001 0064         puts("\r");
	__POINTW2MN _0x20004,204
	CALL SUBOPT_0x3
; 0001 0065         lcd_clear();
; 0001 0066         sprintf(string, "Tx: %c", gt);
	CALL SUBOPT_0x0
	__POINTW1FN _0x20000,263
	CALL SUBOPT_0x5
	CALL SUBOPT_0x4
; 0001 0067         lcd_puts(string);
; 0001 0068         sprintf(string, "Rx: input letter is \"%c\" ", gt);
	__POINTW1FN _0x20000,270
	CALL SUBOPT_0x5
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
; 0001 0069         lcd_gotoxy(0, 1);
_0x20032:
	LDI  R30,LOW(0)
	CALL SUBOPT_0x6
; 0001 006A         lcd_puts(string);
	MOVW R26,R28
	ADIW R26,4
_0x20033:
	CALL _lcd_puts
; 0001 006B     }
_0x2001C:
; 0001 006C     puts("\rPart 2 is ending!\r");
	__POINTW2MN _0x20004,206
	CALL _puts
; 0001 006D }
_0x20C0004:
	CALL __LOADLOCR4
	ADIW R28,14
	RET
; .FEND

	.DSEG
_0x20004:
	.BYTE 0xE2
;
;void q3()
; 0001 0070 {

	.CSEG
_q3:
; .FSTART _q3
; 0001 0071     unsigned char string[100] = "";
; 0001 0072     unsigned char gt ='';
; 0001 0073     int counter = 0;
; 0001 0074     int dig = 1;
; 0001 0075     int index = 0;
; 0001 0076     puts("part 3 is running!\r");
	SBIW R28,63
	SBIW R28,39
	LDI  R24,102
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x20021*2)
	LDI  R31,HIGH(_0x20021*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
;	string -> Y+8
;	gt -> R17
;	counter -> R18,R19
;	dig -> R20,R21
;	index -> Y+6
	LDI  R17,0
	__GETWRN 18,19,0
	__GETWRN 20,21,1
	__POINTW2MN _0x20022,0
	CALL _puts
; 0001 0077     gt = getchar_nv();
	CALL SUBOPT_0x7
; 0001 0078     putchar(gt);
; 0001 0079     while (gt != '\r')
_0x20023:
	CPI  R17,13
	BREQ _0x20025
; 0001 007A     {
; 0001 007B         string[counter] = gt;
	MOVW R30,R18
	MOVW R26,R28
	ADIW R26,8
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R17
; 0001 007C         gt = getchar_nv();
	CALL SUBOPT_0x7
; 0001 007D         putchar(gt);
; 0001 007E         counter++;
	__ADDWRN 18,19,1
; 0001 007F     }
	RJMP _0x20023
_0x20025:
; 0001 0080     lcd_clear();
	CALL _lcd_clear
; 0001 0081 
; 0001 0082     for (index = 2; string[index] != ')'; index++)
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x20027:
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x29)
	BREQ _0x20028
; 0001 0083     {
; 0001 0084         if (!((string[index] == '0') || (string[index] == '1') || (string[index] == '2') || (string[index] == '3') || (s ...
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x30)
	BREQ _0x2002A
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x31)
	BREQ _0x2002A
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x32)
	BREQ _0x2002A
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x33)
	BREQ _0x2002A
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x34)
	BREQ _0x2002A
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x35)
	BREQ _0x2002A
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x36)
	BREQ _0x2002A
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x37)
	BREQ _0x2002A
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x38)
	BREQ _0x2002A
	CALL SUBOPT_0x8
	CPI  R26,LOW(0x39)
	BRNE _0x2002B
_0x2002A:
	RJMP _0x20029
_0x2002B:
; 0001 0085             dig = 0;
	__GETWRN 20,21,0
; 0001 0086     }
_0x20029:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x20027
_0x20028:
; 0001 0087 
; 0001 0088     if (dig == 0)
	MOV  R0,R20
	OR   R0,R21
	BRNE _0x2002C
; 0001 0089     {
; 0001 008A         puts("\rTx:");
	__POINTW2MN _0x20022,20
	CALL SUBOPT_0x9
; 0001 008B         puts(string);
; 0001 008C         putchar('\r');
; 0001 008D         puts("\rFrame must be 5 integer\r");
	__POINTW2MN _0x20022,25
	CALL _puts
; 0001 008E         sprintf(string, "Tx: %d", dig);
	MOVW R30,R28
	ADIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x20000,55
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R20
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
; 0001 008F         lcd_clear();
	CALL _lcd_clear
; 0001 0090         lcd_puts(string);
	CALL SUBOPT_0xA
; 0001 0091         lcd_gotoxy(0, 1);
; 0001 0092         lcd_puts("Frame must be 5 integer");
	__POINTW2MN _0x20022,51
	RJMP _0x20034
; 0001 0093     }
; 0001 0094     else if (counter != 9)
_0x2002C:
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	CP   R30,R18
	CPC  R31,R19
	BREQ _0x2002E
; 0001 0095     {
; 0001 0096         puts("\rTx:");
	__POINTW2MN _0x20022,75
	CALL SUBOPT_0x9
; 0001 0097         puts(string);
; 0001 0098         putchar('\r');
; 0001 0099         puts("\rIncorrect frame size.\r");
	__POINTW2MN _0x20022,80
	CALL SUBOPT_0x3
; 0001 009A         lcd_clear();
; 0001 009B         lcd_puts("Tx:");
	__POINTW2MN _0x20022,104
	CALL _lcd_puts
; 0001 009C         lcd_puts(string);
	CALL SUBOPT_0xA
; 0001 009D 
; 0001 009E         lcd_gotoxy(0, 1);
; 0001 009F         lcd_puts("Incorrect frame size.");
	__POINTW2MN _0x20022,108
	RJMP _0x20034
; 0001 00A0     }
; 0001 00A1     else
_0x2002E:
; 0001 00A2     {
; 0001 00A3         puts("\rTx:");
	__POINTW2MN _0x20022,130
	CALL SUBOPT_0x9
; 0001 00A4         puts(string);
; 0001 00A5         putchar('\r');
; 0001 00A6         puts("\rThe frame is correct\r");
	__POINTW2MN _0x20022,135
	CALL SUBOPT_0x3
; 0001 00A7         lcd_clear();
; 0001 00A8         lcd_puts("Tx:");
	__POINTW2MN _0x20022,158
	CALL _lcd_puts
; 0001 00A9         lcd_puts(string);
	CALL SUBOPT_0xA
; 0001 00AA         lcd_gotoxy(0, 1);
; 0001 00AB         lcd_puts("The frame is correct");
	__POINTW2MN _0x20022,162
_0x20034:
	CALL _lcd_puts
; 0001 00AC     }
; 0001 00AD     puts("\rPart 3 is ending!");
	__POINTW2MN _0x20022,183
	CALL _puts
; 0001 00AE     putchar('\r');
	LDI  R26,LOW(13)
	CALL _putchar
; 0001 00AF     // getchar_nv();
; 0001 00B0 }
	CALL __LOADLOCR6
	ADIW R28,63
	ADIW R28,45
	RET
; .FEND

	.DSEG
_0x20022:
	.BYTE 0xCA
;
;void init(void)
; 0001 00B3 {

	.CSEG
_init:
; .FSTART _init
; 0001 00B4     float temp1 = 0;
; 0001 00B5     int temp2 = 0;
; 0001 00B6     DDRA = (0 << DDA7) | (0 << DDA6) | (0 << DDA5) | (0 << DDA4) | (0 << DDA3) | (0 << DDA2) | (0 << DDA1) | (0 << DDA0) ...
	SBIW R28,4
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	STD  Y+2,R30
	STD  Y+3,R30
	ST   -Y,R17
	ST   -Y,R16
;	temp1 -> Y+2
;	temp2 -> R16,R17
	__GETWRN 16,17,0
	OUT  0x1A,R30
; 0001 00B7     PORTA = (0 << PORTA7) | (0 << PORTA6) | (0 << PORTA5) | (0 << PORTA4) | (0 << PORTA3) | (0 << PORTA2) | (0 << PORTA1 ...
	OUT  0x1B,R30
; 0001 00B8     DDRB = (0 << DDB7) | (0 << DDB6) | (0 << DDB5) | (0 << DDB4) | (0 << DDB3) | (0 << DDB2) | (0 << DDB1) | (0 << DDB0) ...
	OUT  0x17,R30
; 0001 00B9     PORTB = (0 << PORTB7) | (0 << PORTB6) | (0 << PORTB5) | (0 << PORTB4) | (0 << PORTB3) | (0 << PORTB2) | (0 << PORTB1 ...
	OUT  0x18,R30
; 0001 00BA     DDRC = (1 << DDC7) | (1 << DDC6) | (1 << DDC5) | (1 << DDC4) | (1 << DDC3) | (1 << DDC2) | (1 << DDC1) | (1 << DDC0) ...
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0001 00BB     PORTC = (0 << PORTC7) | (0 << PORTC6) | (0 << PORTC5) | (0 << PORTC4) | (0 << PORTC3) | (0 << PORTC2) | (0 << PORTC1 ...
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0001 00BC     DDRD = (0 << DDD7) | (0 << DDD6) | (0 << DDD5) | (0 << DDD4) | (0 << DDD3) | (0 << DDD2) | (0 << DDD1) | (0 << DDD0) ...
	OUT  0x11,R30
; 0001 00BD     PORTD = (0 << PORTD7) | (0 << PORTD6) | (0 << PORTD5) | (0 << PORTD4) | (0 << PORTD3) | (0 << PORTD2) | (0 << PORTD1 ...
	OUT  0x12,R30
; 0001 00BE     TCCR0 = (0 << WGM00) | (0 << COM01) | (0 << COM00) | (0 << WGM01) | (0 << CS02) | (0 << CS01) | (0 << CS00);
	OUT  0x33,R30
; 0001 00BF     TCNT0 = 0x00;
	OUT  0x32,R30
; 0001 00C0     OCR0 = 0x00;
	OUT  0x3C,R30
; 0001 00C1     TCCR1A = (0 << COM1A1) | (0 << COM1A0) | (0 << COM1B1) | (0 << COM1B0) | (0 << WGM11) | (0 << WGM10);
	OUT  0x2F,R30
; 0001 00C2     TCCR1B = (0 << ICNC1) | (0 << ICES1) | (0 << WGM13) | (0 << WGM12) | (0 << CS12) | (0 << CS11) | (0 << CS10);
	OUT  0x2E,R30
; 0001 00C3     TCNT1H = 0x00;
	OUT  0x2D,R30
; 0001 00C4     TCNT1L = 0x00;
	OUT  0x2C,R30
; 0001 00C5     ICR1H = 0x00;
	OUT  0x27,R30
; 0001 00C6     ICR1L = 0x00;
	OUT  0x26,R30
; 0001 00C7     OCR1AH = 0x00;
	OUT  0x2B,R30
; 0001 00C8     OCR1AL = 0x00;
	OUT  0x2A,R30
; 0001 00C9     OCR1BH = 0x00;
	OUT  0x29,R30
; 0001 00CA     OCR1BL = 0x00;
	OUT  0x28,R30
; 0001 00CB     ASSR = 0 << AS2;
	OUT  0x22,R30
; 0001 00CC     TCCR2 = (0 << PWM2) | (0 << COM21) | (0 << COM20) | (0 << CTC2) | (0 << CS22) | (0 << CS21) | (0 << CS20);
	OUT  0x25,R30
; 0001 00CD     TCNT2 = 0x00;
	OUT  0x24,R30
; 0001 00CE     OCR2 = 0x00;
	OUT  0x23,R30
; 0001 00CF     TIMSK = (0 << OCIE2) | (0 << TOIE2) | (0 << TICIE1) | (0 << OCIE1A) | (0 << OCIE1B) | (0 << TOIE1) | (0 << OCIE0) |  ...
	OUT  0x39,R30
; 0001 00D0     MCUCR = (0 << ISC11) | (0 << ISC10) | (0 << ISC01) | (0 << ISC00);
	OUT  0x35,R30
; 0001 00D1     MCUCSR = (0 << ISC2);
	OUT  0x34,R30
; 0001 00D2 
; 0001 00D3     ACSR = (1 << ACD) | (0 << ACBG) | (0 << ACO) | (0 << ACI) | (0 << ACIE) | (0 << ACIC) | (0 << ACIS1) | (0 << ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0001 00D4     SFIOR = (0 << ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0001 00D5     ADCSRA = (0 << ADEN) | (0 << ADSC) | (0 << ADATE) | (0 << ADIF) | (0 << ADIE) | (0 << ADPS2) | (0 << ADPS1) | (0 <<  ...
	OUT  0x6,R30
; 0001 00D6     SPCR = (0 << SPIE) | (0 << SPE) | (0 << DORD) | (0 << MSTR) | (0 << CPOL) | (0 << CPHA) | (0 << SPR1) | (0 << SPR0);
	OUT  0xD,R30
; 0001 00D7     TWCR = (0 << TWEA) | (0 << TWSTA) | (0 << TWSTO) | (0 << TWEN) | (0 << TWIE);
	OUT  0x36,R30
; 0001 00D8     lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0001 00D9 
; 0001 00DA     UCSRA = (0 << RXC) | (0 << TXC) | (0 << UDRE) | (0 << FE) | (0 << DOR) | (0 << UPE) | (0 << U2X) | (0 << MPCM);
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0001 00DB     UCSRB = (1 << RXCIE) | (1 << TXCIE) | (0 << UDRIE) | (1 << RXEN) | (1 << TXEN) | (0 << UCSZ2) | (0 << RXB8) | (0 <<  ...
	LDI  R30,LOW(216)
	OUT  0xA,R30
; 0001 00DC     UCSRC = (1 << URSEL) | (0 << UMSEL) | (0 << UPM1) | (0 << UPM0) | (0 << USBS) | (1 << UCSZ1) | (1 << UCSZ0) | (0 <<  ...
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0001 00DD 
; 0001 00DE     temp1 = ((8 * 1000000) / (16 * 9600)) - 1;
	__GETD1N 0x424C0000
	__PUTD1S 2
; 0001 00DF     temp2 = (int)temp1;
	CALL __CFD1
	MOVW R16,R30
; 0001 00E0 
; 0001 00E1     if (temp2 < 0xFF)
	__CPWRN 16,17,255
	BRGE _0x20030
; 0001 00E2     {
; 0001 00E3         UBRRL = temp2;
	OUT  0x9,R16
; 0001 00E4     }
; 0001 00E5     else
	RJMP _0x20031
_0x20030:
; 0001 00E6     {
; 0001 00E7         UBRRL = temp2 % 0xFF;
	MOVW R26,R16
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	CALL __MODW21
	OUT  0x9,R30
; 0001 00E8         UBRRH = temp2 / 0xFF;
	MOVW R26,R16
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	CALL __DIVW21
	OUT  0x20,R30
; 0001 00E9     }
_0x20031:
; 0001 00EA #asm("sei")
	sei
; 0001 00EB }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G102:
; .FSTART __lcd_write_nibble_G102
	ST   -Y,R26
	IN   R30,0x15
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x15,R30
	__DELAY_USB 13
	SBI  0x15,2
	__DELAY_USB 13
	CBI  0x15,2
	__DELAY_USB 13
	JMP  _0x20C0003
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
	__DELAY_USB 133
	RJMP _0x20C0003
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G102)
	SBCI R31,HIGH(-__base_y_G102)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R11,Y+1
	LDD  R10,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0xB
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0xB
	LDI  R30,LOW(0)
	MOV  R10,R30
	MOV  R11,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2040005
	CP   R11,R13
	BRLO _0x2040004
_0x2040005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R10
	MOV  R26,R10
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2040007
	RJMP _0x20C0003
_0x2040007:
_0x2040004:
	INC  R11
	SBI  0x15,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x15,0
	RJMP _0x20C0003
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2040008:
	CALL SUBOPT_0xC
	BREQ _0x204000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2040008
_0x204000A:
	RJMP _0x20C0002
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x14
	ORI  R30,LOW(0xF0)
	OUT  0x14,R30
	SBI  0x14,2
	SBI  0x14,0
	SBI  0x14,1
	CBI  0x15,2
	CBI  0x15,0
	CBI  0x15,1
	LDD  R13,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G102,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G102,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0xD
	CALL SUBOPT_0xD
	CALL SUBOPT_0xD
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G102
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
	RJMP _0x20C0003
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_putchar:
; .FSTART _putchar
	ST   -Y,R26
putchar0:
     sbis usr,udre
     rjmp putchar0
     ld   r30,y
     out  udr,r30
_0x20C0003:
	ADIW R28,1
	RET
; .FEND
_puts:
; .FSTART _puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2060003:
	CALL SUBOPT_0xC
	BREQ _0x2060005
	MOV  R26,R17
	RCALL _putchar
	RJMP _0x2060003
_0x2060005:
	LDI  R26,LOW(10)
	RCALL _putchar
_0x20C0002:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_put_buff_G103:
; .FSTART _put_buff_G103
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2060010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2060012
	__CPWRN 16,17,2
	BRLO _0x2060013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2060012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2060013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2060014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2060014:
	RJMP _0x2060015
_0x2060010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2060015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
__print_G103:
; .FSTART __print_G103
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2060016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2060018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x206001C
	CPI  R18,37
	BRNE _0x206001D
	LDI  R17,LOW(1)
	RJMP _0x206001E
_0x206001D:
	CALL SUBOPT_0xE
_0x206001E:
	RJMP _0x206001B
_0x206001C:
	CPI  R30,LOW(0x1)
	BRNE _0x206001F
	CPI  R18,37
	BRNE _0x2060020
	CALL SUBOPT_0xE
	RJMP _0x20600CC
_0x2060020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2060021
	LDI  R16,LOW(1)
	RJMP _0x206001B
_0x2060021:
	CPI  R18,43
	BRNE _0x2060022
	LDI  R20,LOW(43)
	RJMP _0x206001B
_0x2060022:
	CPI  R18,32
	BRNE _0x2060023
	LDI  R20,LOW(32)
	RJMP _0x206001B
_0x2060023:
	RJMP _0x2060024
_0x206001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2060025
_0x2060024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2060026
	ORI  R16,LOW(128)
	RJMP _0x206001B
_0x2060026:
	RJMP _0x2060027
_0x2060025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x206001B
_0x2060027:
	CPI  R18,48
	BRLO _0x206002A
	CPI  R18,58
	BRLO _0x206002B
_0x206002A:
	RJMP _0x2060029
_0x206002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x206001B
_0x2060029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x206002F
	CALL SUBOPT_0xF
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x10
	RJMP _0x2060030
_0x206002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2060032
	CALL SUBOPT_0xF
	CALL SUBOPT_0x11
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2060033
_0x2060032:
	CPI  R30,LOW(0x70)
	BRNE _0x2060035
	CALL SUBOPT_0xF
	CALL SUBOPT_0x11
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2060033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2060036
_0x2060035:
	CPI  R30,LOW(0x64)
	BREQ _0x2060039
	CPI  R30,LOW(0x69)
	BRNE _0x206003A
_0x2060039:
	ORI  R16,LOW(4)
	RJMP _0x206003B
_0x206003A:
	CPI  R30,LOW(0x75)
	BRNE _0x206003C
_0x206003B:
	LDI  R30,LOW(_tbl10_G103*2)
	LDI  R31,HIGH(_tbl10_G103*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x206003D
_0x206003C:
	CPI  R30,LOW(0x58)
	BRNE _0x206003F
	ORI  R16,LOW(8)
	RJMP _0x2060040
_0x206003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2060071
_0x2060040:
	LDI  R30,LOW(_tbl16_G103*2)
	LDI  R31,HIGH(_tbl16_G103*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x206003D:
	SBRS R16,2
	RJMP _0x2060042
	CALL SUBOPT_0xF
	CALL SUBOPT_0x12
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2060043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2060043:
	CPI  R20,0
	BREQ _0x2060044
	SUBI R17,-LOW(1)
	RJMP _0x2060045
_0x2060044:
	ANDI R16,LOW(251)
_0x2060045:
	RJMP _0x2060046
_0x2060042:
	CALL SUBOPT_0xF
	CALL SUBOPT_0x12
_0x2060046:
_0x2060036:
	SBRC R16,0
	RJMP _0x2060047
_0x2060048:
	CP   R17,R21
	BRSH _0x206004A
	SBRS R16,7
	RJMP _0x206004B
	SBRS R16,2
	RJMP _0x206004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x206004D
_0x206004C:
	LDI  R18,LOW(48)
_0x206004D:
	RJMP _0x206004E
_0x206004B:
	LDI  R18,LOW(32)
_0x206004E:
	CALL SUBOPT_0xE
	SUBI R21,LOW(1)
	RJMP _0x2060048
_0x206004A:
_0x2060047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x206004F
_0x2060050:
	CPI  R19,0
	BREQ _0x2060052
	SBRS R16,3
	RJMP _0x2060053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2060054
_0x2060053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2060054:
	CALL SUBOPT_0xE
	CPI  R21,0
	BREQ _0x2060055
	SUBI R21,LOW(1)
_0x2060055:
	SUBI R19,LOW(1)
	RJMP _0x2060050
_0x2060052:
	RJMP _0x2060056
_0x206004F:
_0x2060058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x206005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x206005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x206005A
_0x206005C:
	CPI  R18,58
	BRLO _0x206005D
	SBRS R16,3
	RJMP _0x206005E
	SUBI R18,-LOW(7)
	RJMP _0x206005F
_0x206005E:
	SUBI R18,-LOW(39)
_0x206005F:
_0x206005D:
	SBRC R16,4
	RJMP _0x2060061
	CPI  R18,49
	BRSH _0x2060063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2060062
_0x2060063:
	RJMP _0x20600CD
_0x2060062:
	CP   R21,R19
	BRLO _0x2060067
	SBRS R16,0
	RJMP _0x2060068
_0x2060067:
	RJMP _0x2060066
_0x2060068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2060069
	LDI  R18,LOW(48)
_0x20600CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x206006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x206006B
	SUBI R21,LOW(1)
_0x206006B:
_0x206006A:
_0x2060069:
_0x2060061:
	CALL SUBOPT_0xE
	CPI  R21,0
	BREQ _0x206006C
	SUBI R21,LOW(1)
_0x206006C:
_0x2060066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2060059
	RJMP _0x2060058
_0x2060059:
_0x2060056:
	SBRS R16,0
	RJMP _0x206006D
_0x206006E:
	CPI  R21,0
	BREQ _0x2060070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x10
	RJMP _0x206006E
_0x2060070:
_0x206006D:
_0x2060071:
_0x2060030:
_0x20600CC:
	LDI  R17,LOW(0)
_0x206001B:
	RJMP _0x2060016
_0x2060018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x13
	SBIW R30,0
	BRNE _0x2060072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0001
_0x2060072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x13
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G103)
	LDI  R31,HIGH(_put_buff_G103)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G103
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20C0001:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.DSEG
_rx_buffer:
	.BYTE 0x8
_tx_buffer:
	.BYTE 0x8
__seed_G101:
	.BYTE 0x4
__base_y_G102:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x0:
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R18
	CALL __CWD1
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x2:
	MOVW R30,R18
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,8
	CALL _sprintf
	ADIW R28,12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3:
	CALL _puts
	JMP  _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	MOVW R26,R28
	ADIW R26,4
	CALL _lcd_puts
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R17
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	CALL _getchar_nv
	MOV  R17,R30
	MOV  R26,R17
	JMP  _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:47 WORDS
SUBOPT_0x8:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	MOVW R26,R28
	ADIW R26,8
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x9:
	CALL _puts
	MOVW R26,R28
	ADIW R26,8
	CALL _puts
	LDI  R26,LOW(13)
	JMP  _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xA:
	MOVW R26,R28
	ADIW R26,8
	CALL _lcd_puts
	LDI  R30,LOW(0)
	RJMP SUBOPT_0x6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xC:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xD:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G102
	__DELAY_USW 200
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xE:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xF:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x11:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x12:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
