/*------------------------------------------------------------*/
/* fuzzyTECH 5.4 C Runtime Library: Header File               */
/* (c) 2000 INFORM GmbH, Pascalstr. 23, 52076 Aachen, Germany */
/*------------------------------------------------------------*/

#ifndef __INC_FTLIBC

#ifdef FTRUN
#ifndef ONLINE
#define ONLINE
#endif
#ifndef FTLIBC16
#define FTLIBC16
#endif
#endif

#ifndef FTLIB99C
#ifndef FTLIBC8
#ifndef FTLIBC16
#error Use -DFTLIBC16 or -DFTLIBC8 or -DFTLIB99C as compiler command line switch
#endif
#endif
#endif

/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
/* !!!		  Please don't change the following lines                 !!! */
/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */

#ifndef __VOIDCONST_DEFINED
#ifndef FT_KRC
#define VOID	    void
#define CONST	    const
#define FTCALL
#else
#define VOID
#define CONST
#define FTCALL
#endif
#define __VOIDCONST_DEFINED
#endif

#define FTSTORAGECLASS

#define __TRC_STATUS     (TrcBuf[0])
#define __TRC_MAXSTEP    (TrcBuf[1])
#define __TRC_STEPWIDTH  (TrcBuf[2])
#define __TRC_ON         (TrcBuf[3])
#define __TRC_STP_CNTDWN (TrcBuf[4])
#define __TRC_SW_CNTDWN  (TrcBuf[5])

#define TRC_STOP	 0x0000
#define TRC_STARTING	 0x0001
#define TRC_TRACING	 0x0002
#define TRC_INITWAIT	 0x0004
#define TRC_WAITING	 0x0008
#define TRC_EXT_TRIGGER  0x0010
#define TRC_FULL	 0x0020


#ifdef ONLINE
#define PRECOMPILER

#define TT_PRJID      0
#define TT_TRCBUF     1
#define TT_MONITOR    2
#define TT_4PMBF      3
#define TT_XCOM       4
#define TT_TABOFS     5
#define TT_KBM        5 /* TT_TABOFS alias */
#define TT_IONAMES    6
#define TT_IODEFAULTS 7
#define TT_FTLZIP     8
#define TT_BVRSHELL   9
#define TT_BVRCODE   10
#define TT_MBF       11
#define TT_WEIGHTS   12
#define TT_STATE     13
#define TT_ICL       14
#define TT_FRAT      15
#define TT_DEFUZ     16
#define TT_SHAPES    17
#define TT_INFTYPES  18
#define TT_RT        19
#define TT_IO        20
#define TT_FUZZYS    21
#define TT_PTRCBUF   22
#define TT_SIZE      23

#define FTS_HG    0x0001
#define FTS_WR    0x0002
#define FTS_CY    0x0003
#define FTS_CG	  0x0004
#define FTS_WG    0x0005

#define FTS_MASK_ONLINE 0x8000
#define FTS_MASK_FTRREV 0x7F00
#define FTS_MASK_RT16_P 0x0010
#define FTS_MASK_DIRTY  0x0008
#define FTS_MASK_STATE  0x0007

#define FTS_STATE            0
#define FTS_NUMIN            1
#define FTS_DTIO             2
#define FTS_FTRSIZE          3
#define FTS_FTRUSED          4
#define FTS_RESERVED         5
#define FTS_FTLUSED          6
#define FTS_TRCSIZE          7
#define FTS_NUMOUT           8
#define FTS_SIZE             9


#ifndef __PTAB_DEFINED
typedef unsigned char * PTAB;
typedef PTAB *		PTABTAB;
#define __PTAB_DEFINED
#endif

#endif

typedef unsigned char  FTCRTU8;
typedef unsigned short FTCRTU16;
typedef unsigned long  FTCRTU32;

#ifdef FTLIBC8
typedef FTCRTU8  FUZZY;
typedef FTCRTU16 LFUZZY;
#ifdef PRECOMPILER
typedef FTCRTU32 FLAGS;
#else
typedef FTCRTU8  FLAGS;
#endif

#define MAXDOS	      0x80
#define DOSSHIFT	 7
#define MAXACPAR      0x80
#define ACSHIFT 	 7
#define MAXSHAPEPAR   0x80
#define SHAPESHIFT	 7
#define MAXFUZZY      0xFF
#define MAXFUZZYL     0x00FF
#define MAXBVRANGE    0x00FF
#endif



#ifdef FTLIBC16
typedef FTCRTU16 FUZZY;
typedef FTCRTU32 LFUZZY;
#ifdef PRECOMPILER
typedef FTCRTU32 FLAGS;
#else
typedef FTCRTU16 FLAGS;
#endif

#define MAXDOS	      0x80
#define DOSSHIFT	 7
#define MAXACPAR      0x80
#define ACSHIFT 	 7
#define MAXSHAPEPAR   0x80
#define SHAPESHIFT	 7
#define MAXFUZZY      0xFFFF
#define MAXFUZZYL     0x0000FFFF
#define MAXBVRANGE    0xFFFF
#endif



#ifdef FTLIB99C
typedef FTCRTU8  FUZZY;
typedef FTCRTU16 LFUZZY;
typedef FTCRTU32 FLAGS;

#define MAXFUZZY      0x3F
#define MAXFUZZYL     0x003F
#define MAXBVRANGE    0x00FF
#endif



typedef unsigned char   BYTE;
typedef BYTE *          PFTBYTE;
typedef FTCRTU16        FTUSHORT;
typedef FTUSHORT *	PFTUSHORT;
typedef FTCRTU16        FRAT;
typedef FRAT *		PFRAT;
typedef FUZZY * 	PFUZZY;
typedef FUZZY * 	PTRACE;

typedef struct tag_FPV {
       BYTE      bTNum;
       FUZZY     crisp;
       FLAGS     invalidflags;
       PFRAT     fratptr;
       PFUZZY    tpptr;
       PFUZZY    fuzptr;
#ifdef FTRUN
       PFUZZY    pfuzvals;
#endif
       PFUZZY    xcomptr;
       PFUZZY    defuzz;
       PFTBYTE   rtptr;
#ifdef PRECOMPILER
       FTCRTU16* prt;
       BYTE      bPar;
       PFUZZY    wptr;
       FTUSHORT  usNumber;
#endif
} FPV;
typedef FPV * PFPV;


extern FTSTORAGECLASS BYTE     bTNum;
extern FTSTORAGECLASS FUZZY    crisp;
extern FTSTORAGECLASS FLAGS    invalidflags;
extern FTSTORAGECLASS PFRAT    fratptr;
extern FTSTORAGECLASS PFUZZY   tpptr;
extern FTSTORAGECLASS PFUZZY   fuzptr;
#ifdef FTRUN
extern FTSTORAGECLASS PFUZZY   pfuzvals;
#endif
extern FTSTORAGECLASS PFUZZY   xcomptr;
extern FTSTORAGECLASS PFUZZY   defuzz;
extern FTSTORAGECLASS PFTBYTE  rtptr;

#ifdef PRECOMPILER
extern FTSTORAGECLASS FTCRTU16* prt;
extern FTSTORAGECLASS BYTE     bPar;
extern FTSTORAGECLASS PFUZZY   wptr;
extern FTSTORAGECLASS FTUSHORT usNumber;
#endif



#ifndef FT_KRC
VOID  FTCALL PushFuzzyPubVars(PFPV pFPV);
VOID  FTCALL PopFuzzyPubVars (PFPV pFPV);
#else
VOID  FTCALL PushFuzzyPubVars();
VOID  FTCALL PopFuzzyPubVars();
#endif

#ifndef PRECOMPILER
VOID FTCALL flmss(VOID);
#endif
VOID FTCALL flms(VOID);
VOID FTCALL iMMin(VOID);
VOID FTCALL iMMax(VOID);
VOID FTCALL iMFMin(VOID);
VOID FTCALL iMFMax(VOID);
VOID FTCALL com(VOID);
VOID FTCALL mom(VOID);

#ifdef FTLIB99C
VOID FTCALL iBMin(VOID);
VOID FTCALL cogmax(VOID);
VOID FTCALL cogbsum(VOID);
VOID FTCALL mommax(VOID);
VOID FTCALL mombsum(VOID);
#endif

#ifdef PRECOMPILER
VOID FTCALL fLinear(VOID);
VOID FTCALL fsShape(VOID);
VOID FTCALL fCat(VOID);
VOID FTCALL fMultiCat(VOID);
VOID FTCALL fMultiCat2(VOID);

#ifdef FTRUN
VOID FTCALL iMinProd(VOID);
#endif
VOID FTCALL iMP(VOID);

VOID FTCALL iMFMM(VOID);
VOID FTCALL iMFMax(VOID);
VOID FTCALL iMFMA(VOID);
VOID FTCALL iMFAvg(VOID);
VOID FTCALL iMFP(VOID);
VOID FTCALL iMFG(VOID);

VOID FTCALL iBMin(VOID);
VOID FTCALL iBMax(VOID);
VOID FTCALL iBP(VOID);

VOID FTCALL iBFMin(VOID);
VOID FTCALL iBFMM(VOID);
VOID FTCALL iBFMax(VOID);
VOID FTCALL iBFMA(VOID);
VOID FTCALL iBFAvg(VOID);
VOID FTCALL iBFP(VOID);
VOID FTCALL iBFG(VOID);

VOID FTCALL i2MFMin(VOID);
VOID FTCALL i2MFMM(VOID);
VOID FTCALL i2MFMax(VOID);
VOID FTCALL i2MFMA(VOID);
VOID FTCALL i2MFAvg(VOID);
VOID FTCALL i2MFP(VOID);
VOID FTCALL i2MFG(VOID);

VOID FTCALL i2BFMin(VOID);
VOID FTCALL i2BFMM(VOID);
VOID FTCALL i2BFMax(VOID);
VOID FTCALL i2BFMA(VOID);
VOID FTCALL i2BFAvg(VOID);
VOID FTCALL i2BFP(VOID);
VOID FTCALL i2BFG(VOID);

VOID FTCALL dHyperCoM(VOID);
VOID FTCALL dwCoXX(VOID);
VOID FTCALL dwMoM(VOID);

#ifndef FT_KRC
double FTCALL BVScaleCode2Shell(const FUZZY *cVals, const double *sVals, FUZZY value);
FUZZY  FTCALL BVScaleShell2Code(const FUZZY *cVals, const double *sVals, double value, int fClipToDefault, FUZZY cDefault);
FUZZY  FTCALL xpowy(FUZZY x, BYTE y);
#else
double FTCALL BVScaleCode2Shell();
FUZZY  FTCALL BVScaleShell2Code();
FUZZY  FTCALL xbpowy();
#endif




#endif

#ifdef ONLINE
#ifndef FT_KRC
FLAGS FTCALL fTRuntimeEngine(PTABTAB TabTab);
VOID  FTCALL InitfTRuntimeEngine(PTABTAB TabTab, PTAB pKbm, PTAB pTrcBuf, PTAB pMonBuf, PTAB pIOBuf);
VOID  FTCALL fTStartTrace(PTABTAB TabTab);
VOID  FTCALL fTStopTrace(PTABTAB TabTab);
FTUSHORT FTCALL fTSetState(PTABTAB TabTab, FTUSHORT NewState);
#else
FLAGS FTCALL fTRuntimeEngine();
VOID  FTCALL InitfTRuntimeEngine();
VOID  FTCALL fTStartTrace();
VOID  FTCALL fTStopTrace();
int   fTSetState(TabTab, NewState);
#endif
#endif

#define __INC_FTLIBC
#endif
