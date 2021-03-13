PROJECT {
  NAME = 4RULES.FTL;
  DATEFORMAT = M.D.YY;
  LASTCHANGE = 5.30.94;
  CREATED    = 5.29.94;
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
                  DEFAULT_OUTPUT(0.500000);
        RESOLUTION = XGRID(0.000000), YGRID(1.000000),
                     SHOWGRID (ON), SNAPTOGRID(ON);
        TERM {
          TERMNAME = Hot;
          POINTS = (-5.000000, 1.000000),
                   (-4.803922, 1.000000),
                   (-0.294118, 0.000000),
                   (20.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (255), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = JustRight;
          POINTS = (-5.000000, 0.000000),
                   (-2.450980, 0.000000),
                   (0.000000, 1.000000),
                   (0.098039, 1.000000),
                   (7.254902, 0.000000),
                   (20.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (255), BLUE (0);
        }
        TERM {
          TERMNAME = Cool;
          POINTS = (-5.000000, 0.000000),
                   (3.431373, 0.000000),
                   (9.019608, 1.000000),
                   (15.294118, 0.000000),
                   (20.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (255);
        }
        TERM {
          TERMNAME = Frigid;
          POINTS = (-5.000000, 0.000000),
                   (10.686275, 0.000000),
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
                  DEFAULT_OUTPUT(0.500000);
        RESOLUTION = XGRID(0.000000), YGRID(1.000000),
                     SHOWGRID (ON), SNAPTOGRID(ON);
        TERM {
          TERMNAME = Zero;
          POINTS = (0.000000, 1.000000),
                   (0.784314, 1.000000),
                   (17.254902, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (255), GREEN (0), BLUE (0);
        }
        TERM {
          TERMNAME = Small;
          POINTS = (0.000000, 0.000000),
                   (12.941176, 0.000000),
                   (16.078431, 1.000000),
                   (32.549020, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (255), BLUE (0);
        }
        TERM {
          TERMNAME = Medium;
          POINTS = (0.000000, 0.000000),
                   (25.490196, 0.000000),
                   (54.117647, 1.000000),
                   (79.215686, 0.000000),
                   (100.000000, 0.000000);
          SHAPE = LINEAR;
          COLOR = RED (0), GREEN (0), BLUE (255);
        }
        TERM {
          TERMNAME = Full;
          POINTS = (0.000000, 0.000000),
                   (69.019608, 0.000000),
                   (100.000000, 1.000000);
          SHAPE = LINEAR;
          COLOR = RED (128), GREEN (0), BLUE (0);
        }
      }  /* LVAR */
    }  /* VARIABLE_SECTION */

    OBJECT_SECTION {
      INTERFACE {
        INPUT = (DeltaTemp, FCMBF);
        POS = -218, -81;
        RANGECHECK = ON;
      }
      INTERFACE {
        OUTPUT = (DutyCycle, COM);
        POS = 62, -81;
        RANGECHECK = ON;
      }
      RULEBLOCK {
        INPUT = DeltaTemp;
        OUTPUT = DutyCycle;
        AGGREGATION = (MIN_MAX, PAR (0.000000));
        COMPOSITION = (GAMMA, PAR (0.000000));
        POS = -78, -113;
        RULES {
          IF    DeltaTemp = Hot
          THEN  DutyCycle = Zero   WITH 1.000;
          IF    DeltaTemp = JustRight
          THEN  DutyCycle = Small   WITH 1.000;
          IF    DeltaTemp = Cool
          THEN  DutyCycle = Medium   WITH 1.000;
          IF    DeltaTemp = Frigid
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
}  /* TERMINAL                        */
