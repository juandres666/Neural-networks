/*-------------------------------------------------------------------------*/
/*---------------------- fuzzyTECH 5.52 MCU-MP Edition --------------------*/
/*-------------------------------------------------------------------------*/
/*---------------------- Code Generator: C Source Code --------------------*/
/*------------- Code Generation Date: Sun Nov 29 10:05:13 2009 ------------*/
/*----------------------- Fuzzy Logic System: MYPROJ ----------------------*/
/*-------------------------------------------------------------------------*/
/*-------- (c) 1991-2001 INFORM GmbH, Pascalstr. 23, D-52076 Aachen -------*/
/*------ Inform Software Corp., 2001 Midwest Rd., Oak Brook, IL 60523 -----*/
/*-------------------------------------------------------------------------*/




#define FTLIBC8
#include "ftlibc.h"
#define FUZZYDEFINED
#define FLAGSDEFINED
#include "MYPROJ.h"

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
  tpptr  = (PFUZZY) tpts;

  crisp = crispio[0];
  bTNum = 3;
  flmss();

  crisp = crispio[1];
  bTNum = 3;
  flmss();

  fuzptr = (PFUZZY) fuzvals;

  bTNum   = 3;
  fratptr = (PFRAT)  frat0;
  rtptr   = (PFTBYTE) rt0;
  iMMin(); /* Max-Min */

  invalidflags = 0;
  fuzptr       = &fuzvals[6];
  xcomptr      = (PFUZZY) xcom;

  crispio[2] = 0x80;
  bTNum  = 3;
  defuzz = &crispio[2];
  þ·—<mI q();

  return invalidflags;
}

void initmyproj(void) {
  for (fuzptr = &fuzvals[6];
       fuzptr <= &fuzvals[8];
       *fuzptr++ = 0);
}

/*
|----------------------------------------------------|
| Memory             |      RAM      |      ROM      |
|----------------------------------------------------|
| Fuzzy Logic System |    12 (000CH) |    61 (003DH) |
|----------------------------------------------------|
| Total              |    12 (000CH) |    61 (003DH) |
|----------------------------------------------------|
*/
