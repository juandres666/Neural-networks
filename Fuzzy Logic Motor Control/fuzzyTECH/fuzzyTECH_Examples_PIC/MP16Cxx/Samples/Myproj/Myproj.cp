#line 1 "D:/fuzzyTECH/MP16Cxx/Samples/Myproj/Myproj.c"
#line 1 "d:/fuzzytech/mp16cxx/samples/myproj/ftlibc.h"
#line 121 "d:/fuzzytech/mp16cxx/samples/myproj/ftlibc.h"
typedef unsigned char FTCRTU8;
typedef unsigned short FTCRTU16;
typedef unsigned long FTCRTU32;


typedef FTCRTU8 FUZZY;
typedef FTCRTU16 LFUZZY;



typedef FTCRTU8 FLAGS;
#line 181 "d:/fuzzytech/mp16cxx/samples/myproj/ftlibc.h"
typedef unsigned char BYTE;
typedef BYTE * PFTBYTE;
typedef FTCRTU16 FTUSHORT;
typedef FTUSHORT * PFTUSHORT;
typedef FTCRTU16 FRAT;
typedef FRAT * PFRAT;
typedef FUZZY * PFUZZY;
typedef FUZZY * PTRACE;

typedef struct tag_FPV {
 BYTE bTNum;
 FUZZY crisp;
 FLAGS invalidflags;
 PFRAT fratptr;
 PFUZZY tpptr;
 PFUZZY fuzptr;
#line 200 "d:/fuzzytech/mp16cxx/samples/myproj/ftlibc.h"
 PFUZZY xcomptr;
 PFUZZY defuzz;
 PFTBYTE rtptr;
#line 209 "d:/fuzzytech/mp16cxx/samples/myproj/ftlibc.h"
} FPV;
typedef FPV * PFPV;


extern   BYTE bTNum;
extern   FUZZY crisp;
extern   FLAGS invalidflags;
extern   PFRAT fratptr;
extern   PFUZZY tpptr;
extern   PFUZZY fuzptr;
#line 222 "d:/fuzzytech/mp16cxx/samples/myproj/ftlibc.h"
extern   PFUZZY xcomptr;
extern   PFUZZY defuzz;
extern   PFTBYTE rtptr;
#line 236 "d:/fuzzytech/mp16cxx/samples/myproj/ftlibc.h"
 void    PushFuzzyPubVars(PFPV pFPV);
 void    PopFuzzyPubVars (PFPV pFPV);
#line 244 "d:/fuzzytech/mp16cxx/samples/myproj/ftlibc.h"
 void    flmss( void );

 void    flms( void );
 void    iMMin( void );
 void    iMMax( void );
 void    iMFMin( void );
 void    iMFMax( void );
 void    com( void );
 void    mom( void );
#line 1 "d:/fuzzytech/mp16cxx/samples/myproj/myproj.h"
#line 34 "d:/fuzzytech/mp16cxx/samples/myproj/myproj.h"
extern FUZZY * const pcvmyproj;
#line 56 "d:/fuzzytech/mp16cxx/samples/myproj/myproj.h"
void initmyproj(void);


FLAGS myproj(void);
#line 21 "D:/fuzzyTECH/MP16Cxx/Samples/Myproj/Myproj.c"
static FUZZY crispio[2+1];

static FUZZY fuzvals[6+3+0];

FUZZY * const pcvmyproj = crispio;

static const FUZZY tpts[24] = {
 0x80, 0x06, 0xFF, 0x00,
 0x33, 0x06, 0x88, 0x06,
 0x00, 0x00, 0x33, 0x06,
 0x00, 0x00, 0x00, 0x04,
 0x00, 0x04, 0x80, 0x04,
 0x80, 0x04, 0xFF, 0x00};

static const FUZZY xcom[3] = {
 0x2D, 0x80, 0xD9};

static const BYTE rt0[20] = {
 0x01, 0x01, 0x03, 0x06,
 0x01, 0x01, 0x05, 0x08,
 0x01, 0x01, 0x04, 0x06,
 0x01, 0x01, 0x05, 0x06,
 0x01, 0x01, 0x04, 0x07};

static const FRAT frat0[6] = {
 0x000C, 0x0000, 0x0004, 0x0001, 0x0004, 0x0002};

FLAGS myproj(void) {
 fuzptr = (PFUZZY) fuzvals;
 tpptr = (PFUZZY) tpts;

 crisp = crispio[0];
 bTNum = 3;
 flmss();

 crisp = crispio[1];
 bTNum = 3;
 flmss();

 fuzptr = (PFUZZY) fuzvals;

 bTNum = 3;
 fratptr = (PFRAT) frat0;
 rtptr = (PFTBYTE) rt0;
 iMMin();

 invalidflags = 0;
 fuzptr = &fuzvals[6];
 xcomptr = (PFUZZY) xcom;

 crispio[2] = 0x80;
 bTNum = 3;
 defuzz = &crispio[2];
 þ·—<mI q();

 return invalidflags;
}

void initmyproj(void) {
 for (fuzptr = &fuzvals[6];
 fuzptr <= &fuzvals[8];
 *fuzptr++ = 0);
}
