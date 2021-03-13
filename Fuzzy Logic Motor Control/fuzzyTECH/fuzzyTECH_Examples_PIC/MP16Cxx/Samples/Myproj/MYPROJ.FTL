PROJECT {
  NAME       = MYPROJ.FTL;
  TITLE      =MYPROJ;
  AUTHOR     = INFORM;
  DATEFORMAT = YYYY.DD.MM;
  LASTCHANGE = 2009.29.11;
  CREATED    = 1990.21.11;
  SHELL      = MCU_MP;
  SHELLOPTIONS {
    ONLINE_REFRESHTIME  = 55;
    ONLINE_TIMEOUTCOUNT = 0;
    ONLINE_CODE         = OFF;
    ONLINE_TRACE_BUFFER = (OFF, PAR(306));
    COMMENTS            = ON;
    FTL_BUFFER          = (OFF, PAR(1));
    PASSWORD            = OFF;
    PUBLIC_IO           = ON;
    FAST_CMBF           = ON;
    FAST_COA            = OFF;
    BTYPE               = 8_BIT;
    C_TYPE              = ANSI;
  } /* SHELLOPTIONS */
  MODEL {
    VARIABLE_SECTION {
      LVAR {
        NAME       = Input_1;
        BASEVAR    = in1;
        LVRANGE    = MIN(-100.0), MAX(100.0),
                     MINDEF(0), MAXDEF(255),
                     DEFAULT_OUTPUT(0.0);
        RESOLUTION = XGRID(1.0), YGRID(1.0),
                     SHOWGRID (OFF), SNAPTOGRID(ON);
        COLOR      = RED (255), GREEN (0), BLUE (0);
        INPUT      = FCMBF;
        POS        = -215, -150;
        TERM {
          TERMNAME = term1;
          POINTS   = (-100.0, 0.0),
                     (1.4210854715202e-014, 0.0),
                     (67.0, 1.0),
                     (100.0, 1.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term2;
          POINTS   = (-100.0, 0.0),
                     (-60.0, 0.0),
                     (7.0, 1.0),
                     (73.0, 0.0),
                     (100.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term3;
          POINTS   = (-100.0, 1.0),
                     (-60.0, 1.0),
                     (7.0, 0.0),
                     (100.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
      LVAR {
        NAME       = Input_2;
        BASEVAR    = in2;
        LVRANGE    = MIN(-100.0), MAX(100.0),
                     MINDEF(0), MAXDEF(255),
                     DEFAULT_OUTPUT(0.0);
        RESOLUTION = XGRID(1.0), YGRID(1.0),
                     SHOWGRID (OFF), SNAPTOGRID(ON);
        COLOR      = RED (0), GREEN (255), BLUE (0);
        INPUT      = FCMBF;
        POS        = -215, -100;
        TERM {
          TERMNAME = term4;
          POINTS   = (-100.0, 1.0),
                     (1.4210854715202e-014, 0.0),
                     (100.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term5;
          POINTS   = (-100.0, 0.0),
                     (1.4210854715202e-014, 1.0),
                     (100.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term6;
          POINTS   = (-100.0, 0.0),
                     (1.4210854715202e-014, 0.0),
                     (100.0, 1.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
      LVAR {
        NAME       = Output;
        BASEVAR    = out1;
        LVRANGE    = MIN(-100.0), MAX(100.0),
                     MINDEF(0), MAXDEF(255),
                     DEFAULT_OUTPUT(0.0);
        RESOLUTION = XGRID(1.0), YGRID(1.0),
                     SHOWGRID (OFF), SNAPTOGRID(ON);
        COLOR      = RED (0), GREEN (0), BLUE (255);
        OUTPUT     = COM;
        POS        = 75, -120;
        TERM {
          TERMNAME = term11;
          POINTS   = (-100.0, 0.0),
                     (-90.0, 0.0),
                     (-65.0, 1.0),
                     (-15.0, 0.0),
                     (100.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term13;
          POINTS   = (-100.0, 0.0),
                     (-20.0, 0.0),
                     (1.4210854715202e-014, 1.0),
                     (20.0, 0.0),
                     (100.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = term15;
          POINTS   = (-100.0, 0.0),
                     (20.0, 0.0),
                     (70.0, 1.0),
                     (95.0, 0.0),
                     (100.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
    }  /* VARIABLE_SECTION */

    OBJECT_SECTION {
      REMARK {
        TEXT = 1 Output (3 Terms); 
        POS = -95, -5; 
        FONTSPEC = 28, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (0), GREEN (0), BLUE (128); 
      }
      REMARK {
        TEXT = (c) 1992 by Inform Software Corporation and Intel Corporation; 
        POS = -200, 75; 
        FONTSPEC = 16, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (0), GREEN (96), BLUE (0); 
      }
      REMARK {
        TEXT = 2 Input (3 Terms); 
        POS = -90, -45; 
        FONTSPEC = 28, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (0), GREEN (0), BLUE (96); 
      }
      RULEBLOCK {
        NAME        = RB1;
        INPUT       = Input_1, Input_2; 
        OUTPUT      = Output; 
        AGGREGATION = (MIN_MAX, PAR (0.0));
        RESULT_AGGR = MAX;
        POS         = -65, -150;
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
      }  /* RULEBLOCK */
      REMARK {
        TEXT = MyProj.FTL; 
        POS = -85, -220; 
        FONTSPEC = 36, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (160), GREEN (0), BLUE (0); 
      }
      REMARK {
        TEXT = 7 Rules; 
        POS = -60, 35; 
        FONTSPEC = 28, 0, 0, 0, 0, 16, 0; 
        FONTNAME =Times New Roman; 
        COLOR = RED (0), GREEN (0), BLUE (96); 
      }
    }  /* OBJECT_SECTION */
  }  /* MODEL */
}  /* PROJECT */ 
/* fuzzyTECH 5.52f MCU-MP Demo */


NEUROFUZZY {
  LEARNRULE     =RandomMethod;
  STEPWIDTHDOS  = 0.101563;
  STEPWIDTHTERM = 1.000000;
  MAXDEVIATION  = (50.000000, 1.000000, 0.750000);
  AVGDEVIATION  = 0.100000;
  MAXSTEPS      = 100;
  NEURONS       = 1;
  DATASEQUENCE  = RANDOM;
  UPDATEDBGWIN  = OFF;
}  /* NEUROFUZZY */