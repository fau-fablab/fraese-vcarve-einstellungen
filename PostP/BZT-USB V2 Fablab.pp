+================================================
+
+ MACH 3 / WINPCNC / CNC-Graf / USBCNC
+ Vectric machine output configuration file
+
+================================================
+
+ History
+
+ Who      When       What
+ ======== ========== ===========================
+ Tony     15/11/2005 Written for metric
+ Tony     06/01/2006 Added ATC option
+ Tony     14/05/2006 Fixed G21 mm in header
+ Tony     24/07/2006 Added G2 & G3 Arc support + removed (( ))
+ Mark     14/08/2008 Added G1 to Feed moves, added New_Segment
+ Sorotec  06/06/2009 Changed M3 to not be set all the time
+ Sorotec  04/02/2010 Overall Changed Now works with
+                     MACH 3 / WINPCNC / CNC-Graf /USBCNC
+ Max/Michael 4.5.2013 Kommentare ergänzt

+================================================

POST_NAME = "BZT-USB V2 FAU FabLab (*.nc)"

FILE_EXTENSION = "nc"

UNITS = "MM"

RAPID_PLUNGE_TO_STARTZ = "YES"

+------------------------------------------------
+    Line terminating characters
+------------------------------------------------

LINE_ENDING = "[13][10]"

+------------------------------------------------
+    Block numbering
+------------------------------------------------

LINE_NUMBER_START     = 5
LINE_NUMBER_INCREMENT = 5
LINE_NUMBER_MAXIMUM = 9999999

+================================================
+
+    Formating for variables
+
+================================================

VAR LINE_NUMBER = [N|A|N|1.0]
VAR SPINDLE_SPEED = [S|A|S|1.0]
VAR FEED_RATE = [F|C|F|1.1]
VAR X_POSITION = [X|A|X|1.2]
VAR Y_POSITION = [Y|A|Y|1.2]
VAR Z_POSITION = [Z|A|Z|1.2]
VAR ARC_CENTRE_I_INC_POSITION = [I|A|I|1.2]
VAR ARC_CENTRE_J_INC_POSITION = [J|A|J|1.2]
VAR X_HOME_POSITION = [XH|A|X|1.2]
VAR Y_HOME_POSITION = [YH|A|Y|1.2]
VAR Z_HOME_POSITION = [ZH|A|Z|1.2]
VAR SAFE_Z_HEIGHT = [SAFEZ|A|Z|1.2]

+================================================
+
+    Block definitions for toolpath output
+
+================================================

+---------------------------------------------------
+  Commands output at the start of the file
+---------------------------------------------------

begin HEADER
"%"
"(-----------------------------------)"
"( Postprozessor: VCarvePro PP v1.3  )"
"(-----------------------------------)"
"[N] G54 G17 G21 (erstes KOSY, XY Ebene, Milimeter)"
"[N] G40 G43 G90 (Radiuskompensation aus, Werkzeuglängenkomp. an, absolute Koordinaten)"
"(--------------------------------)"
"( Materialinfo:                  )"
"(--------------------------------)"
"(  X Laenge = [XLENGTH])"
"(  Y Laenge = [YLENGTH])"
"(  Z Laenge = [ZLENGTH])"
"(  X Min = [XMIN] X Max = [XMAX])"
"(  Y Min = [YMIN] Y Max = [YMAX])"
"(  Z Min = [ZMIN] Z Max = [ZMAX])"
"( Parkpos: X = [XH] Y = [YH] Z = [ZH])"
"( Sicherheitshoehe: Z = [SAFEZ])"
"(--------------------------------)"
"( Erstes Werkzeug                )"
"(--------------------------------)"
"(  Werkzeug      = [T] [TOOLNAME])"
"(  Vorschub      = [FC] mm/min)"
"(  Einstechen    = [FP] mm/min)"
"(  Drehzahl      = [S] U/min)"
"(--------------------------------)"
"[N] T[T] M06 (Werkzeugwechsel)"
"[N] G43 (Längenkomp. an)"
"[N] [S] M03 (Spindel im Uhrzeigersinn)"
"[N] G94 (Feedrate in mm/min)"
"[N] (Fahre auf Sicherheitspos.)"
"[N] G00 [ZH]"
"[N] G00 [XH] [YH]"
"(--------------------------------)"
"( Konturname = [TOOLPATH_NAME])"
"(--------------------------------)"

+---------------------------------------------------
+  Commands output at toolchange
+---------------------------------------------------

begin TOOLCHANGE
"(--------------------------------)"
"( Werkzeugwechsel                )"
"(--------------------------------)"
"(  Werkzeug      = [T] [TOOLNAME])"
"(  Vorige Werkzeugnummer = [TP])"
"(  Vorschub      = [FC] mm/min)"
"(  Einstechen    = [FP] mm/min)"
"(  Drehzahl      = [S] U/min)"
"(--------------------------------)"
"[N] M05 M09 (Spindel und KSS aus)"
"[N] G00 [ZH]"
"[N] T[T] M06 (Werkzeugwechsel)"
"[N] G43 (Längenkomp. an)"
"[N] [S] M03 (Spindel im Uhrzeigersinn)"

+---------------------------------------------------
+  Commands output for rapid moves
+---------------------------------------------------

begin RAPID_MOVE

"[N] G00 [X] [Y] [Z]"


+---------------------------------------------------
+  Commands output for the first feed rate move
+---------------------------------------------------

begin FIRST_FEED_MOVE

"[N] G01 [X] [Y] [Z] [F]"


+---------------------------------------------------
+  Commands output for feed rate moves
+---------------------------------------------------

begin FEED_MOVE

"[N] G01 [X] [Y] [Z]"

+---------------------------------------------------
+  Commands output for the first clockwise arc move
+---------------------------------------------------

begin FIRST_CW_ARC_MOVE

"[N] G02 [X] [Y] [I] [J] [F]"

+---------------------------------------------------
+  Commands output for clockwise arc  move
+---------------------------------------------------

begin CW_ARC_MOVE

"[N] G02 [X] [Y] [I] [J]"

+---------------------------------------------------
+  Commands output for the first counterclockwise arc move
+---------------------------------------------------

begin FIRST_CCW_ARC_MOVE

"[N] G03 [X] [Y] [I] [J] [F]"

+---------------------------------------------------
+  Commands output for counterclockwise arc  move
+---------------------------------------------------

begin CCW_ARC_MOVE

"[N]G03 [X] [Y] [I] [J]"


+ Nur aktivieren wenn erforderlich !!
+---------------------------------------------------
+  Commands output for a new segment - toolpath
+  with same toolnumber but maybe different feedrates
+---------------------------------------------------

+ begin NEW_SEGMENT

+ "[N] [S]"
+ "(--------------------------------)"
+ "( Konturname: [TOOLPATH_NAME])"
+ "(--------------------------------)"


+---------------------------------------------------
+  Commands output at the end of the file
+---------------------------------------------------

begin FOOTER

"[N] ( Grundstellung anfahren )"
"[N] G00 G40 [ZH] (Radiuskomp. aus)"
"[N] G00 [XH] [YH]"
"[N] S0 M05 M09 (Spindel und KSS aus)"
"[N] M30 ( Programm Ende )"
"%"