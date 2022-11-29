      *****************************************************************
      * Program name:    PGM015
      *
      * Original author: DEFAY E.           
      *
      * Purpose : 
      *
      * Using :
      *    - Copybooks PGM015FC & PGM015FS                    
      *    - File (example) FILE015              
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 28/11/22  IBMUSER  Create for practice  
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM015.
       AUTHOR.        DEFAY E.
       INSTALLATION.  COBOL DEVELOPMENT CENTER.
       DATE-WRITTEN.  28/11/22.
       DATE-COMPILED. 28/11/22.
       SECURITY.      NON-CONFIDENTIAL.

      *****************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL. 
      **COPYBOOK : PGM015FC
      * FILEIN
       COPY PGM015FC REPLACING ==()== BY ==FILEIN==.
      / FILEOUT1
           SELECT FILEOUT1
           ASSIGN to FILEOUT1
           FILE STATUS is FS-FILEOUT1.
      / FILEOUT2
       COPY PGM015FC REPLACING ==()== BY ==FILEOUT2==.

      *****************************************************************
       DATA DIVISION. 
       FILE SECTION.
      **COPYBOOK : PGM015FS
      / FILEIN
       COPY PGM015FS REPLACING ==()== BY ==FILEIN==.
      / FILEOUT1 - REPORT
       FD FILEOUT1 RECORDING MODE F
           RECORD CONTAINS 80 CHARACTERS.
       01 ENTREPRISE.
           02 FILLER PIC X(80).
      / FILEOUT2 - ERRORS
       FD FILEOUT2 RECORDING MODE F
           RECORD CONTAINS 80 CHARACTERS.
       01 ERROR-REPORT.
           02 FILLER PIC X(80).

      *****************************************************************
       WORKING-STORAGE SECTION.
      / CONSTANTES
      *01 FILLER.
      *    02 NUMBER-MAX-FACTORY PIC 99 VALUE 03.
      *    02 NUMBER-MAX-WORKBH  PIC 99 VALUE 05.
      / FILE CONVERSION
       01 LINE-VERIFIED.
           02 LINE-FACT-LETTER  PIC X.
           02 LINE-FACT-NUMBER  PIC 9.            
           02 LINE-FACT-WORKBH  PIC 9(02).              
           02 LINE-DAY          PIC 9(02).         
           02 LINE-MONTH        PIC 9(02).            
           02 LINE-YEAR         PIC 9(02).            
           02 LINE-PRODUCT-OK   PIC 9(03).              
           02 LINE-PRODUCT-BK   PIC 9(03).
           02 FILLER            PIC X(64).
      / HEADERS
       01 FILLER.
           02 LINE1.
               03 FILLER PIC X(17) VALUE 'ENTREPRISE : TACA'.
               03 FILLER PIC X(42) VALUE SPACES.
               03 FILLER PIC X(13) VALUE 'Le 29/11/2022'.
               03 FILLER PIC X(08) VALUE SPACES.
           02 LINE2.
               03 FILLER PIC X(23) VALUE SPACES.
               03 FILLER PIC X(26) VALUE 'PRODUCTION DU MOIS DE : 12'.
               03 FILLER PIC X(23) VALUE SPACES.
               03 FILLER PIC X(08) VALUE SPACES.
           02 LEGEND.
               03 FILLER PIC X(40) VALUE SPACES.
               03 FILLER PIC X(05) VALUE 'TOTAL'.
               03 FILLER PIC X(14) VALUE SPACES.
               03 FILLER PIC X(07) VALUE 'DEFAUTS'.
               03 FILLER PIC X(06) VALUE SPACES.
               03 FILLER PIC X(08) VALUE SPACES.
           02 NEWLINE.
               03 FILLER PIC X(80) VALUE SPACES.
      / REPORT STRUCTURE     
       01 WS-ENTERPRISE.
           02 FILLER     OCCURS 3.
      *       1 TO 9 DEPENDING ON NUMBER-MAX-FACTORY INDEXED BY NF.
               03 FILLER OCCURS 5.
      *           1 TO 9 DEPENDING ON NUMBER-MAX-WORKBH INDEXED BY WH.
                   04 WORKBH-DISPLAY.
                       05 FILLER PIC X(17) VALUE SPACES.
                       05 FILLER PIC X(13) VALUE 'Nb Atelier : '.
                       05 IDX-WH PIC 9(02) VALUE 0.
                       05 FILLER PIC X(08) VALUE SPACES.
                       05 TOTAL-WORKBH PIC 9(05) VALUE 0.
                       05 FILLER PIC X(15) VALUE SPACES.
                       05 BREAK-WORKBH PIC 9(05) VALUE 0.
                       05 FILLER PIC X(15) VALUE SPACES.
               03 TOTAL-DISPLAY.
                   04 FILLER PIC X(26) VALUE SPACES.
                   04 FILLER PIC X(13) VALUE 'TOTAL USINE :'.
                   04 FILLER PIC X(01) VALUE SPACES.
                   04 TOTAL-FACT       PIC 9(05).
                   04 FILLER PIC X(15) VALUE SPACES.
                   04 BREAK-FACT       PIC 9(05).
                   04 FILLER PIC X(15) VALUE SPACES.
               03 FACTORY-DISPLAY.
                   04 FILLER PIC X(12) VALUE 'USINE NB : U'.
                   04 IDX-NF PIC 9(02).
                   04 FILLER PIC X(26) VALUE SPACES.
                   04 FILLER PIC X(05) VALUE 'TOTAL'.
                   04 FILLER PIC X(14) VALUE SPACES.
                   04 FILLER PIC X(07) VALUE 'DEFAUTS'.
                   04 FILLER PIC X(06) VALUE SPACES.
                   04 FILLER PIC X(08) VALUE SPACES.
       01 ENTERPRISE-DISPLAY.
           02 FILLER PIC X(11) VALUE SPACES.
           02 FILLER PIC X(18) VALUE 'TOTAL ENTREPRISE :'.
           02 FILLER PIC X(11) VALUE SPACES.
           02 TOTAL-GOODS-ENT      PIC 9(05).
           02 FILLER PIC X(15) VALUE SPACES.
           02 TOTAL-BREAK-ENT      PIC 9(05).
           02 FILLER PIC X(15) VALUE SPACES.
       01 BEST-FACTORY.
           02 TEXT-BEST-FACT   PIC X(27) 
           VALUE '  LA MEILLEURE USINE EST : '.
           02 FILLER           PIC X(01) VALUE SPACES.
           02 INDEX-BEST-FACT  PIC 9(02).
           02 FILLER           PIC X(50) VALUE SPACES.
       01 BEST-WORKBH.
           02 TEXT-BEST-WORK   PIC X(27)
           VALUE ' LE MEILLEUR ATELIER EST : '.
           02 FILLER           PIC X(01) VALUE SPACES.
           02 INDEX-BEST-WORK  PIC 9(02).
           02 FILLER           PIC X(50) VALUE SPACES.
       01  WS-ERROR-REPORT.
           02 COL-1  PIC X(20) VALUE 'ERROR Number'.
           02 COL-2  PIC X(20) VALUE 'ERROR Line'.
           02 COL-3  PIC X(32) VALUE 'ERROR Type'.
           02 FILLER PIC X(8).
      / INITIALS VALUES USED FOR MAX FINDING
       01 INDEX-FACTORY        PIC 9(05) VALUE 1.
       01 INDEX-MAX-FACTORY    PIC 9(05) VALUE 1.
       01 INDEX-WORKBH         PIC 9(05) VALUE 1.
       01 INDEX-MAX-WORKBH     PIC 9(05) VALUE 1.
       01 VALUE-MAX-FACTORY    PIC 9(05) VALUE 0.
       01 VALUE-MAX-WORKBH     PIC 9(05) VALUE 0.
      / ERRORS
       01 WS-ERROR-TYPE PIC X(50).
      / COUNTERS
       01 IDX-FACT      PIC 999.
       01 IDX-WK        PIC 999.
       01 WS-FL-COUNTER PIC 9(05) VALUE 0.
       01 WS-FL-ERRORS  PIC 9(05) VALUE 0.
      / FILES STATUS
       01 FILEIN-STATUS.
           05 FS-FILEIN      PIC X(02).
               88 FS-FC-FI       VALUE '10'.
       01 FILEOUT-UNUSED-STATUS.
           05 FS-FILEOUT1    PIC X(02).
           05 FS-FILEOUT2    PIC X(02).

      *****************************************************************
      *  Program : Setup, run main routine and exit.
      *    
      *    Main purpose
      *    - 0xx : Input/Output section
      *    - 1xx : Main element
      *    - 2xx : Verifications   
      *    - 5xx : Operations
      *    - 7xx : Handle Error file
      *    - 8xx : Handle Report file
      *    - 9xx : Close files
      *
      *    Input/Output managment
      *    - x1x : Perform a READ
      *    - x2x : Perform a WRITE
      *    - x5x : Perform Comparisons
      *
      *    Specials
      *    - xxx : OTHERS
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-PARAM
           PERFORM 001-IOPEN
           PERFORM 002-OOPEN
           PERFORM 100-FILES
           PERFORM 999-FCLOS
           GOBACK
           .
      *                                                               *
      *****************************************************************

      *****************************************************************
      *  Routine 0 : Setting up the program with Params & Files.
      *****************************************************************

       000-PARAM.
      *****************************************************************
      *  This routine should setup params (if any)
           CONTINUE 
           .

      *****************************************************************
      *  Those routines should manage file opening (if any)
       001-IOPEN.
           OPEN INPUT  FILEIN
           .
       002-OOPEN.
           OPEN OUTPUT FILEOUT1,
                       FILEOUT2
           .

       010-READ.
      *****************************************************************
      *  This routine should manage file reading
           READ FILEIN
           .
      *****************************************************************

      *****************************************************************
      *  Routine 1 : Read, compare 2 files and write in 3 other files.
      *****************************************************************
       100-FILES.
      *****************************************************************
      *  This routine should read file 1 processing :
      *    1. Exploit the data
      *    2. Make BESTS reports
      *    3. Print Report
           PERFORM 
             VARYING WS-FL-COUNTER FROM 1 BY 1
             UNTIL (FS-FC-FI)
                PERFORM 010-READ
                IF (NOT FS-FC-FI)
                   PERFORM 200-VERIFICATION
                END-IF
           END-PERFORM
           PERFORM 550-ADD-BESTS-REPORT
           PERFORM 800-PRINT-REPORT
           .

       200-VERIFICATION.
      *****************************************************************
      *  This routine verify if data type is OK
      *    ELSE : It ignore the line and make a report
      *    THEN : Convert the line in correct types and process OP
      * Check U value for factories
           IF NOT FACT-LETTER-IS-FACTORY THEN
               MOVE 'FACT-LETTER - Is it a factory?'
                 TO WS-ERROR-TYPE
                 PERFORM 700-PRINT-ERROR
           END-IF
      * Check numeric values              
           EVALUATE FALSE
               WHEN (FACT-NUMBER IS NUMERIC)
                   MOVE 'FACT-NUMBER - Format issue'
                     TO WS-ERROR-TYPE
                   PERFORM 700-PRINT-ERROR
               WHEN (FACT-WORKBH  IS NUMERIC)
                   MOVE 'FACT-WORKBH - Format issue'
                     TO WS-ERROR-TYPE
                   PERFORM 700-PRINT-ERROR
               WHEN (ENREG-DAY IS NUMERIC)
                   MOVE 'DAY - Format issue'
                     TO WS-ERROR-TYPE
                   PERFORM 700-PRINT-ERROR
               WHEN (ENREG-MONTH IS NUMERIC)
                   MOVE 'MONTH - Format issue'
                     TO WS-ERROR-TYPE
                   PERFORM 700-PRINT-ERROR
               WHEN (ENREG-YEAR IS NUMERIC)
                   MOVE 'YEAR - Format issue'
                     TO WS-ERROR-TYPE
                   PERFORM 700-PRINT-ERROR
               WHEN (PRODUCT-OK IS NUMERIC)
                   MOVE 'PRODUCT-OK - Format issue'
                     TO WS-ERROR-TYPE
                   PERFORM 700-PRINT-ERROR
               WHEN (PRODUCT-BK IS NUMERIC)
                   MOVE 'PRODUCT-BK - Format issue'
                     TO WS-ERROR-TYPE
                   PERFORM 700-PRINT-ERROR
               WHEN OTHER
                   PERFORM 400-CONVERT-TO-NUMBERS
                   PERFORM 500-ADD-TO-REPORT
           END-EVALUATE
           .


       400-CONVERT-TO-NUMBERS.
      *****************************************************************
      *  This routine change types of raw input to clean data
           MOVE FILEIN-ENREG TO LINE-VERIFIED
           .

       500-ADD-TO-REPORT.
      *****************************************************************
      *  This routine operate manipulations on the clean data
           MOVE LINE-FACT-NUMBER
             TO IDX-NF(LINE-FACT-NUMBER)
           MOVE LINE-FACT-WORKBH 
             TO IDX-WH(LINE-FACT-NUMBER, LINE-FACT-WORKBH)
      * GLOBAL
           ADD LINE-PRODUCT-OK TO TOTAL-GOODS-ENT 
           ADD LINE-PRODUCT-BK TO TOTAL-BREAK-ENT 
      * FACTORY
           ADD LINE-PRODUCT-OK TO TOTAL-FACT (LINE-FACT-NUMBER)
           ADD LINE-PRODUCT-BK TO BREAK-FACT (LINE-FACT-NUMBER)
      * WORKBH
           ADD LINE-PRODUCT-OK
            TO TOTAL-WORKBH(LINE-FACT-NUMBER, LINE-FACT-WORKBH)
           ADD LINE-PRODUCT-BK
            TO BREAK-WORKBH(LINE-FACT-NUMBER, LINE-FACT-WORKBH)
           .

       550-ADD-BESTS-REPORT.
      *****************************************************************
      *  This routine define what are :
      *    1. The best factory
      *    2. The best workbh inside this factory
      *    MAX FACTORY
           PERFORM 
               VARYING INDEX-FACTORY FROM 1 BY 1
               UNTIL (INDEX-FACTORY > NUMBER-MAX-FACTORY)
               IF (
                   (
                    TOTAL-FACT(INDEX-FACTORY) - 
                    BREAK-FACT(INDEX-FACTORY)
                   ) > VALUE-MAX-FACTORY
               ) THEN
                  COMPUTE VALUE-MAX-FACTORY = (
                   TOTAL-FACT(INDEX-FACTORY) - 
                   BREAK-FACT(INDEX-FACTORY)
                  ) 
                  MOVE INDEX-FACTORY TO INDEX-MAX-FACTORY
               END-IF
           END-PERFORM

      * MAX WORKBH FROM THIS FACTORY
           PERFORM 
               VARYING INDEX-WORKBH FROM 1 BY 1
               UNTIL (INDEX-WORKBH > NUMBER-MAX-WORKBH)
               IF (
                   (
                    TOTAL-WORKBH(INDEX-MAX-FACTORY, INDEX-WORKBH) - 
                    BREAK-WORKBH(INDEX-MAX-FACTORY, INDEX-WORKBH)
                   ) > VALUE-MAX-WORKBH
               ) THEN
                  COMPUTE VALUE-MAX-WORKBH = (
                   TOTAL-WORKBH(INDEX-MAX-FACTORY, INDEX-WORKBH) - 
                   BREAK-WORKBH(INDEX-MAX-FACTORY, INDEX-WORKBH)
                  ) 
                  MOVE INDEX-WORKBH TO INDEX-MAX-WORKBH
               END-IF
           END-PERFORM
      * FINALLY
           MOVE INDEX-MAX-FACTORY TO INDEX-BEST-FACT
           MOVE INDEX-MAX-WORKBH  TO INDEX-BEST-WORK
           .

       700-PRINT-ERROR.
      *****************************************************************
      *  This routine update the values to put inside error logs
           IF WS-FL-ERRORS = 0 THEN
                PERFORM 720-WRITE-ERROR
           END-IF
           ADD 1 TO WS-FL-ERRORS
           MOVE WS-FL-ERRORS  TO COL-1 OF WS-ERROR-REPORT
           MOVE WS-FL-COUNTER TO COL-2 OF WS-ERROR-REPORT
           MOVE WS-ERROR-TYPE TO COL-3 OF WS-ERROR-REPORT
           PERFORM 720-WRITE-ERROR
           .

       720-WRITE-ERROR.
      *****************************************************************
      *  This routine edit the error log
           WRITE ERROR-REPORT FROM WS-ERROR-REPORT
           .

       800-PRINT-REPORT.
      *****************************************************************
      * This routine organize the report writting
           PERFORM 821-WRITE-HEADER
           PERFORM 825-WRITE-REPORT
           PERFORM 829-WRITE-FOOTER
           .

       821-WRITE-HEADER.
      *****************************************************************
      * This routine write the header of the report
           WRITE ENTREPRISE FROM LINE1  
           WRITE ENTREPRISE FROM LINE2  
           WRITE ENTREPRISE FROM NEWLINE  
           .

       825-WRITE-REPORT.
      *****************************************************************
      *  This routine iterate over factories to report
           PERFORM 
               VARYING IDX-FACT FROM 1 BY 1
               UNTIL (IDX-FACT > NUMBER-MAX-FACTORY)
                   PERFORM 826-REPORT-FACTORY
           END-PERFORM
            .

       826-REPORT-FACTORY.
      *****************************************************************
      *  This routine write values of a factory and call WORKBHS of it
           WRITE ENTREPRISE FROM FACTORY-DISPLAY(IDX-FACT) 
           PERFORM 827-REPORT-WORKBH
           WRITE ENTREPRISE FROM TOTAL-DISPLAY(IDX-FACT) 
           WRITE ENTREPRISE FROM NEWLINE
           .

       827-REPORT-WORKBH.
      *****************************************************************
      *  This routine iterate over workbhs and write data about them
           PERFORM 
               VARYING IDX-WK FROM 1 BY 1
               UNTIL (IDX-WK > NUMBER-MAX-WORKBH)
                   IF NOT (IDX-WH(IDX-FACT, IDX-WK) = 0) THEN
                        WRITE ENTREPRISE
                        FROM WORKBH-DISPLAY(IDX-FACT, IDX-WK)
                   ELSE
                       CONTINUE
                   END-IF
           END-PERFORM
           .

        829-WRITE-FOOTER.   
      *****************************************************************
      *    This routine write footer of the report
           WRITE ENTREPRISE FROM NEWLINE  
           WRITE ENTREPRISE FROM LEGEND
           WRITE ENTREPRISE FROM ENTERPRISE-DISPLAY 
           WRITE ENTREPRISE FROM NEWLINE  
           WRITE ENTREPRISE FROM BEST-FACTORY 
           WRITE ENTREPRISE FROM BEST-WORKBH 
           .

      *****************************************************************
      *  Routine 2 : Close files before closing the program.
      *****************************************************************
       999-FCLOS.
           CLOSE FILEIN,
                 FILEOUT1,
                 FILEOUT2
           .
