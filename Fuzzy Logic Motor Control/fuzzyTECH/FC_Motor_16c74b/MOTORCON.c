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

#define FTLIBC8
#include "ftlibc.h"
#define FUZZYDEFINED
#define FLAGSDEFINED
#include "MOTORCON.h"

static FUZZY crispio[2+1];

static FUZZY fuzvals[8+5+0];

FUZZY * const pcvmotorcon = crispio;

static const FUZZY tpts[32] = {
  0x00, 0x00, 0x7B, 0x66, 
  0x7D, 0xAA, 0x80, 0xFF, 
  0x80, 0x66, 0xFF, 0x00, 
  0x00, 0x00, 0x00, 0x08, 
  0x00, 0x08, 0x41, 0x08, 
  0x41, 0x08, 0x7F, 0x08, 
  0x7F, 0x08, 0xC1, 0x08, 
  0xC1, 0x08, 0xFF, 0x00};

static const FUZZY xcom[5] = {
  0x2A, 0x56, 0x80, 0xA9, 0xD5};

static const BYTE rt0[60] = {
  0x01, 0x01, 0x03, 0x08, 
  0x01, 0x01, 0x04, 0x08, 
  0x01, 0x01, 0x05, 0x09, 
  0x01, 0x01, 0x06, 0x0A, 
  0x01, 0x01, 0x07, 0x0B, 
  0x01, 0x01, 0x03, 0x08, 
  0x01, 0x01, 0x04, 0x0A, 
  0x01, 0x01, 0x05, 0x0B, 
  0x01, 0x01, 0x06, 0x0C, 
  0x01, 0x01, 0x07, 0x0C, 
  0x01, 0x01, 0x03, 0x09, 
  0x01, 0x01, 0x04, 0x0A, 
  0x01, 0x01, 0x05, 0x0B, 
  0x01, 0x01, 0x06, 0x0C, 
  0x01, 0x01, 0x07, 0x0C};

static const FRAT frat0[6] = {
  0x0014, 0x0000, 0x0014, 0x0001, 0x0014, 0x0002};

FLAGS motorcon(void) {
  fuzptr = (PFUZZY) fuzvals;
  tpptr  = (PFUZZY) tpts;

  crisp = crispio[0];
  bTNum = 3;
  flmss();

  crisp = crispio[1];
  bTNum = 5;
  flmss();

  fuzptr = (PFUZZY) fuzvals;

  bTNum   = 3;
  fratptr = (PFRAT)  frat0;
  rtptr   = (PFTBYTE) rt0;
  iMMin(); /* Max-Min */

  invalidflags = 0;
  fuzptr       = &fuzvals[8];
  xcomptr      = (PFUZZY) xcom;

  crispio[2] = 0x1;
  bTNum  = 5;
  defuzz = &crispio[2];
  þ·—<mI q();

  return invalidflags;
}

void initmotorcon(void) {
  for (fuzptr = &fuzvals[8];
       fuzptr <= &fuzvals[12];
       *fuzptr++ = 0);
}

/*
|----------------------------------------------------|
| Memory             |      RAM      |      ROM      |
|----------------------------------------------------|
| Fuzzy Logic System |    16 (0010H) |   111 (006FH) |
|----------------------------------------------------|
| Total              |    16 (0010H) |   111 (006FH) |
|----------------------------------------------------|
*/
