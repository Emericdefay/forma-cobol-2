       FD () RECORDING MODE F
           RECORD CONTAINS 80 CHARACTERS.
       01 ()-ENREG.
           02 FACT-LETTER  PIC X.
               88 FACT-LETTER-IS-FACTORY  VALUE 'U'.
           02 FACT-NUMBER  PIC X.
           02 FACT-WORKBH  PIC X(2).
           02 ENREG-DAY    PIC X(2).
           02 ENREG-MONTH  PIC X(2).
           02 ENREG-YEAR   PIC X(2).
           02 PRODUCT-OK   PIC X(3).
           02 PRODUCT-BK   PIC X(3).
           02 FILLER PIC X(64).