//JCLCOMP JOB NOTIFY=&SYSUID,
//            MSGLEVEL=(1,1),
//            MSGCLASS=A,
//            CLASS=A
//*======================================================
//*               PROGRAM NAME
//            SET PGMCBL=PGM015
//*               PATH PROGRAM
//            SET CBLPTH=MASTER.PROG.CBL
//*               PATH COPY FOLDER
//            SET CPYPTH=MASTER.PROG.COPY 
//*               PATH LOAD FOLDER
//            SET LODPTH=MASTER.PROG.LOAD
//*======================================================
//CALLIGY    EXEC IGYWCL,PARM='LIB'
//STEPLIB      DD DSN=IGY410.SIGYCOMP,DISP=SHR
//COBOL.SYSIN  DD DSN=&CBLPTH(&PGMCBL),DISP=SHR
//COBOL.SYSLIB DD DISP=SHR,DSN=&CPYPTH
//LKED.SYSLIB  DD DSN=&LODPTH,DISP=SHR
//             DD DSN=CEE.SCEELKED,DISP=SHR
//LKED.SYSLMOD DD DSN=&LODPTH(&PGMCBL),DISP=SHR
//