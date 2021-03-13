*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*
*-------------------------- fuzzyTECH 320-DSK V4.0 ---------------------------*
*- (c) 1995 Inform Software Corporation, 1840 Oak Avenue, Evanston, IL 60201 -*
*------------ (c) 1995 Inform GmbH, Pascalstr. 23, 52076 Aachen --------------*
*-----------------------------------------------------------------------------*
*-------------- routine inference minimum with Degree of Support -------------*
*-----------------------------------------------------------------------------*
*-----------------------------------------------------------------------------*

minprod:
	CLRC	SXM
    	LAR	AR3,fuzptr
    	LAR	AR4,rtptr
    	LAR	AR5,fratptr
    	LACL	pfuzvals
    	SACL	fuzptr
    	MAR	*,AR5
    	LAMM	AR4
    	ADD	*+,0,AR3
    	SAMM	AR4
        LACL    bTNum
	SAMM	brcr
        RPTB    bTNum_end
    	LACC	*+,0,AR5
	BCND	agg_zero,EQ
	SACL	pcfbak
	LACL	*
	BCND	agg_zero,EQ
    	MAR	*,AR4
    	SAR	AR4,marker
	ADD	marker
	SACL	marker
start_rule:
	LACL	*+
	SACL	incount
     	LACL	*
	SACL	outcount
     	LACC	*+, 1
	ADD	incount
	SACL	offsetr
    	SAR	AR4,saverptr
	LACL	pcfbak
	SACB
in_loop:
	LACL	incount
	BCND	comp,EQ
	SUB	#1
	SACL	incount
    	LACC	*+,0,AR6
    	ADD	fuzptr
    	SAMM	AR6
	NOP
	NOP
    	LACC	*,0,AR4
	CRLT
	BCND	donextrule,EQ
	B	in_loop
comp:
	LACB
	SACL	pcf
comp_minp:
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
    	LACC	*+,0,AR6
    	ADD	fuzptr
    	SAMM	AR6
	NOP
	NOP
	LACL	*
	CRGT
	BCND	comp_end,C
	SACL	*
comp_end:
    	MAR	*,AR4
	LACL	outcount
	SUB	#1
	SACL	outcount
     	BCNDD	comp_minp,NEQ
	LACL	pcf
	SACB
	B	test_marker
donextrule:
	LACL	saverptr
	ADD	offsetr
    	SAMM	AR4
test_marker:
    	LAMM	AR4
	SUB	marker
    	MAR	*,AR4
	BCND	start_rule,NEQ
    	MAR	*,AR5
        B       bTNum_end
agg_zero:
    	LAMM	AR4
	ADD	*
    	SAMM	AR4
bTNum_end:
    	MAR	*+,AR3
	RET
