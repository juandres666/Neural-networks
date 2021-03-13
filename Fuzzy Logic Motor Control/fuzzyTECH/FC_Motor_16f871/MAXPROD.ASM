*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
*-------------------------- fuzzyTECH 320-DSK V4.0 ---------------------------*
*- (c) 1995 Inform Software Corporation, 1840 Oak Avenue, Evanston, IL 60201 -*
*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
*-----------------------------------------------------------------------------*
*-------------- routine inference maximum with Degree of Support -------------*
*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*

maxprod:
	CLRC	SXM
    	LAR	AR3,fuzptr
    	LAR	AR4,rtptr
    	MAR	*,AR4
	LACL	*+
	ADD	*+, 8
	SUB	#1
	SAMM	brcr
	RPTB	rule_loop
	LACL	*+
	SACL	incount
	SACL	offsetr
	LACL	*+
	SACL	outcount
    	SAR	AR4,saverptr
	LACL	#0
	SACB
in_loop:
    	LACC	*+,0,AR3
    	ADD	fuzptr
    	SAMM	AR3
	NOP
	NOP
    	LACC	*,0,AR4
	CRGT
    	SUB	#0FFFFh,0
	BCND	pointtoout,EQ
	LACL	incount
	SUB	#1
	BCND	comp,EQ
	SACL	incount
	B	in_loop
pointtoout:
	LACL	saverptr
	ADD	offsetr
    	SAMM	AR4
comp:
	LACB
	SACL	pcf
comp_maxp:
     	BCND	comp_maxp_ff,NEQ
	BD	comp_end_ff
	MAR	*+
     	MAR	*+
comp_maxp_ff:
     	LACL	*+
     	SACL	dos
     	SUB	#MAXDOS
     	BCND	dos_ff,EQ
     	LACB
     	SAMM	treg0
     	MPYU	dos
     	LTP	dos
     	BSAR	DOSSHIFT
     	SACB
dos_ff:
    	LACC	*+,0,AR3
    	ADD	fuzptr
    	SAMM	AR3
	NOP
	NOP
	LACL	*
	CRGT
	BCND	comp_end,C
	SACL	*
comp_end:
    	MAR	*,AR4
comp_end_ff:
	LACL	outcount
	SUB	#1
	SACL	outcount
     	BCNDD	comp_maxp,NEQ
	LACL	pcf
	SACB
rule_loop:
	NOP
	RET
