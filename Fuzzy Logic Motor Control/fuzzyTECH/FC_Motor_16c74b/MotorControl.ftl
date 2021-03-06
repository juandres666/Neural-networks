PROJECT {
  NAME       = MotorControl.ftl;
  TITLE      =MotorControl;
  AUTHOR     = Juan Andr?s;
  DATEFORMAT = YYYY.DD.MM;
  LASTCHANGE = 2009.29.11;
  CREATED    = 2009.27.11;
  SHELL      = MCU_MP;
  SHELLOPTIONS {
    ONLINE_REFRESHTIME  = 55;
    ONLINE_TIMEOUTCOUNT = 1100;
    ONLINE_CODE         = OFF;
    ONLINE_TRACE_BUFFER = (OFF, PAR(0));
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
        NAME       = DatoError;
        BASEVAR    = Units;
        LVRANGE    = MIN(-255.0), MAX(255.0),
                     MINDEF(0), MAXDEF(255),
                     DEFAULT_OUTPUT(0.0);
        RESOLUTION = XGRID(2.5), YGRID(1.0),
                     SHOWGRID (ON), SNAPTOGRID(ON);
        COLOR      = RED (0), GREEN (128), BLUE (0);
        INPUT      = FCMBF;
        POS        = -290, -225;
        TERM {
          TERMNAME = negative;
          POINTS   = (-255.0, 1.0),
                     (-10.0, 1.0),
                     (0.0, 0.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (255), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = zero;
          POINTS   = (-255.0, 0.0),
                     (-5.0, 0.0),
                     (0.0, 1.0),
                     (5.0, 0.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (128), BLUE (0);
        }
        TERM {
          TERMNAME = positive;
          POINTS   = (-255.0, 0.0),
                     (0.0, 0.0),
                     (10.0, 1.0),
                     (255.0, 1.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (255);
        }
      }  /* LVAR */
      LVAR {
        NAME       = DatoReferencia;
        BASEVAR    = Units;
        LVRANGE    = MIN(0.0), MAX(255.0),
                     MINDEF(0), MAXDEF(255),
                     DEFAULT_OUTPUT(0.0);
        RESOLUTION = XGRID(1.0), YGRID(1.0),
                     SHOWGRID (ON), SNAPTOGRID(ON);
        COLOR      = RED (255), GREEN (0), BLUE (0);
        INPUT      = FCMBF;
        POS        = -287, -167;
        TERM {
          TERMNAME = very_low;
          POINTS   = (0.0, 1.0),
                     (65.0, 0.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (255), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = low;
          POINTS   = (0.0, 0.0),
                     (65.0, 1.0),
                     (127.0, 0.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (128), BLUE (0);
        }
        TERM {
          TERMNAME = medium;
          POINTS   = (0.0, 0.0),
                     (65.0, 0.0),
                     (127.0, 1.0),
                     (193.0, 0.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (255);
        }
        TERM {
          TERMNAME = high;
          POINTS   = (0.0, 0.0),
                     (127.0, 0.0),
                     (193.0, 1.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (128), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = very_high;
          POINTS   = (0.0, 0.0),
                     (193.0, 0.0),
                     (255.0, 1.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (128), BLUE (128);
        }
      }  /* LVAR */
      LVAR {
        NAME       = DatoMotor;
        BASEVAR    = Units;
        LVRANGE    = MIN(0.0), MAX(255.0),
                     MINDEF(0), MAXDEF(255),
                     DEFAULT_OUTPUT(1.0);
        RESOLUTION = XGRID(1.0), YGRID(1.0),
                     SHOWGRID (ON), SNAPTOGRID(ON);
        COLOR      = RED (0), GREEN (0), BLUE (255);
        OUTPUT     = COM;
        POS        = 77, -198;
        TERM {
          TERMNAME = very_low;
          POINTS   = (0.0, 0.0),
                     (42.0, 1.0),
                     (86.0, 0.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (255), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = low;
          POINTS   = (0.0, 0.0),
                     (42.0, 0.0),
                     (86.0, 1.0),
                     (128.0, 0.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (128), BLUE (0);
        }
        TERM {
          TERMNAME = medium;
          POINTS   = (0.0, 0.0),
                     (86.0, 0.0),
                     (128.0, 1.0),
                     (169.0, 0.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (0), BLUE (255);
        }
        TERM {
          TERMNAME = high;
          POINTS   = (0.0, 0.0),
                     (128.0, 0.0),
                     (169.0, 1.0),
                     (213.0, 0.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (128), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = very_high;
          POINTS   = (0.0, 0.0),
                     (169.0, 0.0),
                     (213.0, 1.0),
                     (255.0, 0.0);
          SHAPE    = LINEAR;
          COLOR    = RED (0), GREEN (128), BLUE (128);
        }
      }  /* LVAR */
    }  /* VARIABLE_SECTION */

    OBJECT_SECTION {
      RULEBLOCK {
        NAME        = ControlMotor;
        INPUT       = DatoError, DatoReferencia; 
        OUTPUT      = DatoMotor; 
        AGGREGATION = (MIN_MAX, PAR (0.0));
        RESULT_AGGR = MAX;
        POS         = -142, -218;
        RULES {
          IF    DatoError = negative
            AND DatoReferencia = very_low
          THEN  DatoMotor = very_low   WITH 1.000;
          IF    DatoError = negative
            AND DatoReferencia = low
          THEN  DatoMotor = very_low   WITH 1.000;
          IF    DatoError = negative
            AND DatoReferencia = medium
          THEN  DatoMotor = low   WITH 1.000;
          IF    DatoError = negative
            AND DatoReferencia = high
          THEN  DatoMotor = medium   WITH 1.000;
          IF    DatoError = negative
            AND DatoReferencia = very_high
          THEN  DatoMotor = high   WITH 1.000;
          IF    DatoError = zero
            AND DatoReferencia = very_low
          THEN  DatoMotor = very_low   WITH 1.000;
          IF    DatoError = zero
            AND DatoReferencia = low
          THEN  DatoMotor = medium   WITH 1.000;
          IF    DatoError = zero
            AND DatoReferencia = medium
          THEN  DatoMotor = high   WITH 1.000;
          IF    DatoError = zero
            AND DatoReferencia = high
          THEN  DatoMotor = very_high   WITH 1.000;
          IF    DatoError = zero
            AND DatoReferencia = very_high
          THEN  DatoMotor = very_high   WITH 1.000;
          IF    DatoError = positive
            AND DatoReferencia = very_low
          THEN  DatoMotor = low   WITH 1.000;
          IF    DatoError = positive
            AND DatoReferencia = low
          THEN  DatoMotor = medium   WITH 1.000;
          IF    DatoError = positive
            AND DatoReferencia = medium
          THEN  DatoMotor = high   WITH 1.000;
          IF    DatoError = positive
            AND DatoReferencia = high
          THEN  DatoMotor = very_high   WITH 1.000;
          IF    DatoError = positive
            AND DatoReferencia = very_high
          THEN  DatoMotor = very_high   WITH 1.000;
        }  /* RULES */
      }  /* RULEBLOCK */
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