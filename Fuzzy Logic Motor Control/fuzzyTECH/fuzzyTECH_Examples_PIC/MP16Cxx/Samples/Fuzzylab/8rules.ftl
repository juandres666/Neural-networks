PROJECT {
  NAME = 8RULES.FTL;
  DATEFORMAT = M.D.YY;
  LASTCHANGE = 5.30.94;
  CREATED    = 5.30.94;
  SHELLOPTIONS {
    ONLINE_REFRESHTIME = 55;
    ONLINE_TIMEOUTCOUNT = 0;
    ONLINE_CODE = OFF;
    TRACE_BUFFER = (OFF, PAR(10000));
    BSUM_AGGREGATION = OFF;
    PUBLIC_IO = ON;
    FAST_CMBF = ON;
    FAST_COA  = OFF;
    SCALE_MBF = OFF;
    FILE_CODE = OFF;
    BTYPE = 8_BIT;
  } /* SHELLOPTIONS */
  MODEL {
    VARIABLE_SECTION {
      LVAR {
        NAME    = DeltaTemp;
        BASEVAR = DeltaTemp;
        LVRANGE = MIN(-5.000000), MAX(20.000000),
                  MINDEF(0), MAXDEF(255),
                  DEFAULT_OUTPUT(1.000000);
        RESOLUTION = XGRID(0.000000), YGRID(1.000000),
                     SHOWGRID (ON), SNAPTOGRID(ON);
        TERM {
          TERMNAME = Hot;
          POINTS = (-5.000000, 1.000000),
                   (-4.803922, 1.000000),
                   (0.784314, 0.000000),
                   (20.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (255), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = JustRight;
          POINTS = (-5.000000, 0.000000),
                   (-2.843137, 0.000000),
                   (0.098039, 1.000000),
                   (5.098039, 0.000000),
                   (20.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (255), BLUE (0);
        }
        TERM {
          TERMNAME = cool;
          POINTS = (-5.000000, 0.000000),
                   (2.450980, 0.000000),
                   (7.450980, 1.000000),
                   (14.607843, 0.000000),
                   (20.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (255);
        }
        TERM {
          TERMNAME = frigid;
          POINTS = (-5.000000, 0.000000),
                   (10.000000, 0.000000),
                   (20.000000, 1.000000);
          SHAPE = LINEAR;
          COLOR = RED (128), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
      LVAR {
        NAME    = DutyCycle;
        BASEVAR = DutyCycle;
        LVRANGE = MIN(0.000000), MAX(100.000000),
                  MINDEF(0), MAXDEF(255),
                  DEFAULT_OUTPUT(1.000000);
        RESOLUTION = XGRID(0.000000), YGRID(1.000000),
                     SHOWGRID (ON), SNAPTOGRID(ON);
        TERM {
          TERMNAME = Zero;
          POINTS = (0.000000, 1.000000),
                   (0.392157, 1.000000),
                   (25.490196, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (255), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = Slow;
          POINTS = (0.000000, 0.000000),
                   (7.058824, 0.000000),
                   (18.039216, 1.000000),
                   (43.137255, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (255), BLUE (0);
        }
        TERM {
          TERMNAME = Medium;
          POINTS = (0.000000, 0.000000),
                   (35.294118, 0.000000),
                   (49.411765, 1.000000),
                   (49.803922, 1.000000),
                   (69.803922, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (255);
        }
        TERM {
          TERMNAME = Full;
          POINTS = (0.000000, 0.000000),
                   (60.000000, 0.000000),
                   (100.000000, 1.000000);
          SHAPE = LINEAR;
          COLOR = RED (128), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
      LVAR {
        NAME    = TempDiff;
        BASEVAR = TempDiff;
        LVRANGE = MIN(0.000000), MAX(25.000000),
                  MINDEF(0), MAXDEF(255),
                  DEFAULT_OUTPUT(0.500000);
        RESOLUTION = XGRID(0.000000), YGRID(1.000000),
                     SHOWGRID (ON), SNAPTOGRID(ON);
        TERM {
          TERMNAME = SlowRate;
          POINTS = (0.000000, 1.000000),
                   (0.392157, 1.000000),
                   (8.725490, 0.000000),
                   (25.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (255), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = MediumRate;
          POINTS = (0.000000, 0.000000),
                   (3.333333, 0.000000),
                   (11.666667, 1.000000),
                   (20.000000, 0.000000),
                   (25.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (255), BLUE (0);
        }
        TERM {
          TERMNAME = HighRate;
          POINTS = (0.000000, 0.000000),
                   (12.450980, 0.000000),
                   (24.901961, 1.000000),
                   (25.000000, 1.000000);
          SHAPE = LINEAR;
          COLOR = RED (128), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
    }  /* VARIABLE_SECTION */

    OBJECT_SECTION {
      INTERFACE {
        INPUT = (DeltaTemp, FCMBF);
        POS = -218, -156;
        RANGECHECK = ON;
      }
      INTERFACE {
        INPUT = (TempDiff, FCMBF);
        POS = -218, -8;
        RANGECHECK = ON;
      }
      INTERFACE {
        OUTPUT = (DutyCycle, COM);
        POS = 62, -81;
        RANGECHECK = ON;
      }
      RULEBLOCK {
        INPUT = DeltaTemp, TempDiff;
        OUTPUT = DutyCycle;
        AGGREGATION = (MIN_MAX, PAR (0.000000));
        COMPOSITION = (GAMMA, PAR (0.000000));
        POS = -78, -113;
        RULES {
          IF    DeltaTemp = Hot
          THEN  DutyCycle = Zero   WITH 1.000;
          IF    DeltaTemp = JustRight
            AND TempDiff = SlowRate
          THEN  DutyCycle = Medium   WITH 1.000;
          IF    DeltaTemp = JustRight
            AND TempDiff = MediumRate
          THEN  DutyCycle = Slow   WITH 1.000;
          IF    DeltaTemp = JustRight
            AND TempDiff = HighRate
          THEN  DutyCycle = Zero   WITH 1.000;
          IF    DeltaTemp = cool
            AND TempDiff = SlowRate
          THEN  DutyCycle = Full   WITH 1.000;
          IF    DeltaTemp = cool
            AND TempDiff = MediumRate
          THEN  DutyCycle = Medium   WITH 1.000;
          IF    DeltaTemp = cool
            AND TempDiff = HighRate
          THEN  DutyCycle = Slow   WITH 1.000;
          IF    DeltaTemp = frigid
          THEN  DutyCycle = Full   WITH 1.000;
        }  /* RULES */
      }
    }  /* OBJECT_SECTION */
  }  /* MODEL */
}  /* PROJECT */

TERMINAL {
    BAUDRATE     = 9600;
    STOPBITS     = 1;
    PROTOCOL     = NO;
    CONNECTION   = NOPORT;
    INPUTBUFFER  = 4096;
    OUTPUTBUFFER = 1024;
}  /* TERMINAL                          */
