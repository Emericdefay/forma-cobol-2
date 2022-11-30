       IDENTIFICATION DIVISION.
       PROGRAM-ID. TPPRO01.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *----------------FICHIER EN ENTREE------------------*
           SELECT FPRO ASSIGN TO DD0001A
           FILE STATUS IS ST-F-ENTREE.
      *----------------FICHIER EN SORTIE------------------*
           SELECT FRES ASSIGN TO DD0002A.
           SELECT FERR ASSIGN TO DD0003A.
       DATA DIVISION.
       FILE SECTION.
        FD FPRO
            RECORDING MODE IS F
            LABEL RECORD STANDARD
            BLOCK CONTAINS 0 RECORDS
            RECORD CONTAINS 80 CHARACTERS
            DATA RECORD ENR-PRO.
        01 ENR-PRO.
            02 NUM-USINE PIC XX.
            02 NUM-USINE-ERRONE REDEFINES NUM-USINE PIC XX.
            02 NUM-ATELIER   PIC 99.
            02 NUM-ATELIER-ERRONE REDEFINES NUM-ATELIER  PIC XX.
            02 DATE-PRODUCTION.
              03 JJ PIC 99.
              03 MM PIC 99.
              03 AA PIC 99.
            02 WS-QTEPRO PIC 9(3).
            02 WS-QTEPRO-ERR REDEFINES WS-QTEPRO PIC X(3).
            02 WS-QTEDEF PIC 9(3).
            02 WS-QTEDEF-ERR REDEFINES WS-QTEDEF PIC X(3).
            02 FILLER PIC X(64).
       FD FRES
            RECORDING MODE IS F
            LABEL RECORD STANDARD
            BLOCK CONTAINS 0 RECORDS
            RECORD CONTAINS 80 CHARACTERS
            DATA RECORD ENR-RES.
        01 ENR-RES PIC X(80).
       FD FERR
            RECORDING MODE IS F
            LABEL RECORD STANDARD
            BLOCK CONTAINS 0 RECORDS
            RECORD CONTAINS 80 CHARACTERS
            DATA RECORD ENR-ERR.
        01 ENR-ERR PIC X(80).
       WORKING-STORAGE SECTION.
       01 MAX1     PIC 9(5) VALUE 0.
       01 MAX2     PIC XX   VALUE SPACE.
       01 MAX3     PIC 9(5) VALUE 0.
       01 MAX4     PIC 9(5) VALUE 0.
       01 Q        PIC 9(5) VALUE 0.
       01 T        PIC 9(5) VALUE 0.
       01 W-DATE.
          02 W-AA PIC XX.
          02 W-MM PIC XX.
          02 W-JJ PIC XX.
       01 QT       PIC 9(6) VALUE 0.
       01 QD       PIC 9(6) VALUE 0.
       01 NU       PIC XX.
       01 NA       PIC XX.
       01 TOT-US   PIC 9(6) VALUE 0.
       01 TOT-DE   PIC 9(6) VALUE 0.
       01 TOT-ENTRE1  PIC 9(5) VALUE 0.
       01 TOT-ENTRE2  PIC 9(5) VALUE 0.
       01 L1.
          02 FILLER PIC X(1)  VALUE SPACE.
          02 FILLER PIC X(61) VALUE "ENTREPRISE: COBOLISTE".
          02 FILLER PIC X(3)  VALUE "LE ".
          02 JOUR PIC 99.
          02 FILLER PIC X VALUE "/".
          02 MOIS PIC 99.
          02 FILLER PIC X VALUE "/".
          02 ANN  PIC 99.
          02 FILLER PIC X VALUE "/".
       01 L2.
          02 FILLER PIC X(25) VALUE SPACE.
          02 FILLER PIC X(23) VALUE "PRODUCTION DU MOIS DE: ".
          02 MMO PIC 99.
       01 L3.
          02 FILLER PIC X(36) VALUE SPACE.
          02 FILLER PIC X(15) VALUE "QUANTITE TOTAL".
          02 FILLER PIC X(2)  VALUE SPACE.
          02 FILLER PIC X(21) VALUE "QUANTITE DEFECTUEUSE".
       01 L4.
          02 FILLER PIC X(1)  VALUE SPACE.
          02 FILLER PIC X(10) VALUE "N° USINE: ".
          02 NUS    PIC XX.
       01 L5.
          02 FILLER PIC X(9)  VALUE SPACE.
          02 FILLER PIC X(14) VALUE "N° ATELIE: ".
          02 NAT    PIC XX.
          02 FILLER PIC X(16) VALUE SPACE.
          02 QTO    PIC 9(5).
          02 FILLER PIC X(13) VALUE SPACE.
          02 QDE    PIC 9(5).
       01 L6.
          02 FILLER PIC X(19)  VALUE SPACE.
          02 FILLER PIC X(17) VALUE "TOTAL USINE: ".
          02 FILLER PIC X(5) VALUE SPACE.
          02 TUSP   PIC 9(5).
          02 FILLER PIC X(13) VALUE SPACE.
          02 TUSD   PIC 9(5).
       01 L7        PIC X(80) VALUE SPACE.
       01 L8.
          02 FILLER PIC X(4)  VALUE SPACE.
          02 FILLER PIC X(37) VALUE "TOTAL ENTREPRISE".
          02 T1     PIC 9(5).
          02 FILLER PIC X(13) VALUE SPACE.
          02 T2     PIC 9(5).
       01 L9.
          02 FILLER PIC X(1)  VALUE SPACE.
          02 FILLER PIC X(24) VALUE "LA MEILLEURE USINE EST: ".
          02 MUS    PIC XX.
       01 L10.
          02 FILLER PIC X(4)  VALUE SPACE.
          02 FILLER PIC X(26) VALUE "LA MEILLEURE ATELIER EST: ".
          02 MAT    PIC 99.
       01 L11.
          02 NUM-US PIC XX.
          02 NUM-AT PIC 99.
          02 DATE-PR.
             03 JOURS PIC XX.
             03 MO    PIC XX.
             03 ANNEE PIC XX.
          02 WS-QTE-PR  PIC X(3).
          02 WS-QTE-DE  PIC X(3).
       01 L12.
          02 FILLER PIC X(23) VALUE "IL Y A DES ERREURS DANS".
          02 FILLER PIC X(57) VALUE "  LES ENREGISTREMENTS SUIVANTS :".
      *
       01 ST-F-ENTREE     PIC 9(2).
          88 ENT-OK    VALUE 00.
          88 ENT-FIN   VALUE 10.
       01 W-CPT-FPRO-LUS  PIC 9(2) COMP.

       PROCEDURE DIVISION.
       PROGRAMME.
       DEBUT.
      *------*
            OPEN INPUT FPRO
            OPEN OUTPUT FRES
            OPEN OUTPUT FERR
            WRITE  ENR-ERR FROM L12
            ACCEPT W-DATE FROM DATE
            MOVE W-AA TO ANN
            MOVE W-MM TO MOIS
            MOVE W-JJ TO JOUR
            PERFORM LECTURE
            PERFORM 01-PARA-ENTETE
            PERFORM 02-REPET UNTIL ENT-FIN
            MOVE TOT-US TO TUSP
            MOVE TOT-DE TO TUSD
            WRITE  ENR-RES FROM L7
            WRITE  ENR-RES FROM L6
            SUBTRACT TOT-DE FROM TOT-US GIVING T
            IF T > MAX1
               MOVE T   TO MAX1
               MOVE NUS TO MAX2
            END-IF
            MOVE TOT-ENTRE1   TO T1
            MOVE TOT-ENTRE2   TO T2
            WRITE  ENR-RES FROM L7
            WRITE  ENR-RES FROM L8
            MOVE MAX2   TO MUS
            DISPLAY 'PROCEDURE ='
            DISPLAY 'MAX4 'MAX4
            MOVE MAX4   TO MAT
            DISPLAY 'PROCEDURE ='
            DISPLAY 'MAT= 'MAT
            WRITE  ENR-RES FROM L7
            WRITE  ENR-RES FROM L9
            WRITE  ENR-RES FROM L7
            WRITE  ENR-RES FROM L10
            CLOSE FPRO
            CLOSE FRES
            CLOSE FERR
            STOP RUN
            .
       LECTURE.
      *--------*
            READ FPRO
            IF ENT-OK
               ADD 1 TO W-CPT-FPRO-LUS
            END-IF
            .
       01-PARA-ENTETE.
      *---------------*
            WRITE ENR-RES FROM L1 AFTER ADVANCING 1 LINE
            MOVE MM TO MMO
            WRITE ENR-RES FROM L7
            WRITE ENR-RES FROM L2
            WRITE ENR-RES FROM L7
            WRITE ENR-RES FROM L3
            MOVE NUM-USINE TO NU
            MOVE NUM-USINE TO NUS
            WRITE ENR-RES FROM L7
            WRITE ENR-RES FROM L4
            MOVE NUM-ATELIER  TO NA
            MOVE NA  TO NAT
            .
       02-REPET.
      *---------*
            MOVE NUM-ATELIER TO NAT
            PERFORM 03-CALCUL UNTIL NUM-ATELIER NOT = NA OR
                    NUM-USINE NOT = 'U1' OR ENT-FIN
            MOVE QT TO QTO
            MOVE QD TO QDE
            WRITE ENR-RES FROM L7
            WRITE ENR-RES FROM L5
            SUBTRACT QD FROM QT GIVING Q
            IF Q > MAX3
               MOVE Q TO MAX3
               DISPLAY ' NAT =' NAT
               MOVE NAT TO MAX4
            END-IF
            IF NUM-USINE NOT = 'U1'
               PERFORM 04-RESULTAT
               MOVE NUM-USINE TO NU
            SET ENT-FIN TO TRUE
            END-IF
            MOVE NUM-ATELIER TO NA
            MOVE 0 TO QT
            MOVE 0 TO QD
            SET ENT-FIN TO TRUE
               DISPLAY ' SORIE DE REPET'
               DISPLAY ' MAX4 =' MAX4
            .
       03-CALCUL.
      *---------*
            IF WS-QTEPRO IS NOT NUMERIC OR
               WS-QTEDEF IS NOT NUMERIC
               MOVE NUM-USINE   TO NUM-US
               MOVE NUM-ATELIER TO NUM-AT
               MOVE DATE-PRODUCTION TO DATE-PR
               MOVE WS-QTEPRO-ERR   TO WS-QTE-PR
               MOVE WS-QTEDEF-ERR   TO WS-QTE-DE
               WRITE ENR-ERR FROM L11 AFTER ADVANCING 1 LINE
            ELSE
               ADD WS-QTEPRO    TO QT
               ADD WS-QTEDEF    TO QD
               ADD WS-QTEPRO    TO TOT-US
               ADD WS-QTEDEF    TO TOT-DE
               ADD WS-QTEPRO    TO TOT-ENTRE1
               ADD WS-QTEDEF    TO TOT-ENTRE2
            END-IF
            READ FPRO
            .
       04-RESULTAT.
      *------------*
            MOVE  TOT-US   TO TUSP
            MOVE  TOT-DE   TO TUSD
            WRITE ENR-RES  FROM L7
            WRITE ENR-RES  FROM L6
            SUBTRACT TOT-DE FROM TOT-US GIVING T
            IF T > MAX1
               MOVE T      TO MAX1
               MOVE NUS    TO MAX2
               DISPLAY ' MAX4 =' MAX4
               MOVE MAX4   TO MAT
            END-IF
            DISPLAY ' MAT = ' MAT
            MOVE 0         TO TOT-US
            MOVE 0         TO TOT-DE
            MOVE NUM-USINE TO NUS
            WRITE ENR-RES  FROM L7
            WRITE ENR-RES  FROM L4
            .
