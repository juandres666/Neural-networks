/*-------------------------------------------------------------------------*/
/*---------------------- fuzzyTECH 5.52 MCU-MP Edition --------------------*/
/*-------------------------------------------------------------------------*/
/*---------------------- Code Generator: C Source Code --------------------*/
/*------------- Code Generation Date: Sun Nov 29 13:36:34 2009 ------------*/
/*---------------------- Fuzzy Logic System: MOTORCON ---------------------*/
/*-------------------------------------------------------------------------*/
/*-------- (c) 1991-2001 INFORM GmbH, Pascalstr. 23, D-52076 Aachen -------*/
/*------ Inform Software Corp., 2001 Midwest Rd., Oak Brook, IL 60523 -----*/
/*-------------------------------------------------------------------------*/


/*-------------------------------------------------------------------------*/
/*------------------ export interface of project MOTORCON -----------------*/
/*-------------------------------------------------------------------------*/


/*-------------------------------------------------------------------------*/
/*-------------------------------- typedefs -------------------------------*/
/*-------------------------------------------------------------------------*/
#ifndef FUZZYDEFINED
/*----------- type of data for computation of fuzzy logic system ----------*/
typedef unsigned char FUZZY;
#define FUZZYDEFINED
#endif

#ifndef FLAGSDEFINED
/*--------------- type of return value of fuzzy logic system --------------*/
typedef unsigned char FLAGS;
#define FLAGSDEFINED
#endif

/*----------------------- data only used by fuzzyTECH ---------------------*/
extern FUZZY * const pcvmotorcon;


/*-------------------------------------------------------------------------*/
/*---- use the following #defines to set the inputs of the fuzzy system ---*/
/*-------------------------------------------------------------------------*/
#define DatoError_motorcon                         (*(pcvmotorcon+  0)) /* 0000H .. 00FFH */
#define DatoReferencia_motorcon                    (*(pcvmotorcon+  1)) /* 0000H .. 00FFH */


/*-------------------------------------------------------------------------*/
/*---- use the following #defines to get the outputs of the fuzzy system --*/
/*-------------------------------------------------------------------------*/
#define DatoMotor_motorcon                         (*(pcvmotorcon+  2)) /* 0000H .. 00FFH */



/*-------------------------------------------------------------------------*/
/*--------------------------- function prototypes -------------------------*/
/*-------------------------------------------------------------------------*/

/*------- for starting up the generated fuzzy logic system, call once -----*/
void initmotorcon(void);

/*-------------- for calling the generated fuzzy logic system -------------*/
FLAGS motorcon(void);
