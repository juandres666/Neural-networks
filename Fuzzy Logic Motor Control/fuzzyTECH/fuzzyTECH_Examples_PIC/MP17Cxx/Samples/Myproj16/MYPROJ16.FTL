PROJECT {
  NAME = MYPROJ16.FTL;
  TITLE =MYPROJ16;
  AUTHOR = INFORM;
  DATEFORMAT = DD.MM.YY;
  LASTCHANGE = 19.12.97;
  CREATED    = 21.11.90;
  SHELL = MP;
  SHELLOPTIONS {
    ONLINE_REFRESHTIME = 55;
    ONLINE_TIMEOUTCOUNT = 0;
    ONLINE_CODE = OFF;
    ONLINE_TRACE_BUFFER = (OFF, PAR(612));
    COMMENTS    = ON;
    FTL_BUFFER = (OFF, PAR(1));
    PASSWORD   = OFF;
    PUBLIC_IO = ON;
    FAST_CMBF = ON;
    FAST_COA  = OFF;
    FILE_CODE = OFF;
    BTYPE = 16_BIT;
  } /* SHELLOPTIONS */
  MODEL {
    VARIABLE_SECTION {
      LVAR {
        NAME    = Input_1;
        BASEVAR = in1;
        LVRANGE = MIN(-100.000000), MAX(100.000000),
                  MINDEF(0), MAXDEF(65535),
                  DEFAULT_OUTPUT(0.000000);
        RESOLUTION = XGRID(0.005000), YGRID(1.000000),
                     SHOWGRID (OFF), SNAPTOGRID(ON);
        COLOR = RED (255), GREEN (0), BLUE (0);
        TERM {
          TERMNAME = term1;
          POINTS = (-100.000000, 0.000000),
                   (0.390000, 0.000000),
                   (67.060000, 1.000000),
                   (100.000000, 1.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term2;
          POINTS = (-100.000000, 0.000000),
                   (-60.000000, 0.000000),
                   (6.665000, 1.000000),
                   (73.335000, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term3;
          POINTS = (-100.000000, 1.000000),
                   (-60.000000, 1.000000),
                   (6.665000, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
      LVAR {
        NAME    = Input_2;
        BASEVAR = in2;
        LVRANGE = MIN(-100.000000), MAX(100.000000),
                  MINDEF(0), MAXDEF(65535),
                  DEFAULT_OUTPUT(0.000000);
        RESOLUTION = XGRID(0.005000), YGRID(1.000000),
                     SHOWGRID (OFF), SNAPTOGRID(ON);
        COLOR = RED (0), GREEN (255), BLUE (0);
        TERM {
          TERMNAME = term4;
          POINTS = (-100.000000, 1.000000),
                   (0.000000, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term5;
          POINTS = (-100.000000, 0.000000),
                   (0.000000, 1.000000),
                   (0.390000, 1.000000),
                   (80.390000, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term6;
          POINTS = (-100.000000, 0.000000),
                   (0.390000, 0.000000),
                   (100.000000, 1.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
      LVAR {
        NAME    = Output;
        BASEVAR = out1;
        LVRANGE = MIN(-100.000000), MAX(100.000000),
                  MINDEF(0), MAXDEF(65535),
                  DEFAULT_OUTPUT(0.000000);
        RESOLUTION = XGRID(0.005000), YGRID(1.000000),
                     SHOWGRID (OFF), SNAPTOGRID(ON);
        COLOR = RED (0), GREEN (0), BLUE (255);
        TERM {
          TERMNAME = term11;
          POINTS = (-100.000000, 0.000000),
                   (-89.805000, 0.000000),
                   (-64.805000, 1.000000),
                   (-64.705000, 1.000000),
                   (-14.705000, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term13;
          POINTS = (-100.000000, 0.000000),
                   (-20.000000, 0.000000),
                   (0.000000, 1.000000),
                   (0.390000, 1.000000),
                   (20.390000, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term15;
          POINTS = (-100.000000, 0.000000),
                   (20.000000, 0.000000),
                   (70.000000, 1.000000),
                   (70.195000, 1.000000),
                   (95.195000, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
    }  /* VARIABLE_SECTION */

    OBJECT_SECTION {
      REMARK {
        TEXT = 1 Output (3 Terms); 
        POS = -110, 15; 
        FONTSPEC = 28, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (0), GREEN (0), BLUE (128); 
      }
      REMARK {
        TEXT = (c) 1992 by Inform Software Corporation and Intel Corporation; 
        POS = -200, 85; 
        FONTSPEC = 16, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (0), GREEN (96), BLUE (0); 
      }
      REMARK {
        TEXT = 2 Input (3 Terms); 
        POS = -95, -20; 
        FONTSPEC = 28, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (0), GREEN (0), BLUE (96); 
      }
      RULEBLOCK {
        NAME = RB1;
        INPUT = Input_1, Input_2; 
        OUTPUT = Output; 
        AGGREGATION = (MIN_MAX, PAR (0.000000));
        RESULT_AGGR = MAX;
        POS = -65, -120;
        RULES {
          IF    Input_1 = term1
            AND Input_2 = term4
          THEN  Output = term11   WITH 1.000;
          IF    Input_1 = term2
            AND Input_2 = term6
          THEN  Output = term11   WITH 1.000;
          IF    Input_1 = term3
            AND Input_2 = term5
          THEN  Output = term13   WITH 1.000;
          IF    Input_1 = term1
            AND Input_2 = term6
          THEN  Output = term15   WITH 1.000;
          IF    Input_1 = term1
            AND Input_2 = term5
          THEN  Output = term11   WITH 1.000;
        }  /* RULES */
      }
      INTERFACE {
        INPUT = (Input_1, FCMBF);
        PARAMSTR = (SHOW,);
        POS = -225, -120;
      }
      INTERFACE {
        INPUT = (Input_2, FCMBF);
        PARAMSTR = (SHOW,);
        POS = -225, -75;
      }
      INTERFACE {
        OUTPUT = (Output, COM);
        PARAMSTR = (SHOW,);
        POS = 90, -95;
      }
      REMARK {
        TEXT = MyProj16.FTL; 
        POS = -105, -225; 
        FONTSPEC = 36, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (160), GREEN (0), BLUE (0); 
      }
      REMARK {
        TEXT = 7 Rules; 
        POS = -65, 45; 
        FONTSPEC = 28, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (0), GREEN (0), BLUE (96); 
      }
      REMARK {
        TEXT = 16 Bit; 
        POS = -50, -170; 
        FONTSPEC = 36, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (0), GREEN (0), BLUE (255); 
      }
    }  /* OBJECT_SECTION */
  }  /* MODEL */
}  /* PROJECT */ 

TERMINAL {
    BAUDRATE     = 19200;
    DATABITS     = 8;
    PARITY       = 0;
    STOPBITS     = 1;
    PROTOCOL     = NO;
    CONNECTION   = PORT2;
    INPUTBUFFER  = 1024;
    OUTPUTBUFFER = 1024;
}  /* TERMINAL */


NEUROFUZZY {
  LEARNRULE     =RandomMethod;
  STEPWIDTHDOS  = 0.100000;
  STEPWIDTHTERM = 1.000000;
  MAXDEVIATION  = (50.000000, 1.000000, 0.750000);
  AVGDEVIATION  = 0.100000;
  MAXSTEPS      = 100;
  NEURONS       = 1;
  DATASEQUENCE  = RANDOM;
  UPDATEDBGWIN  = OFF;
}  /* NEUROFUZZY */